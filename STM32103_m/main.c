#include <stdint.h>
#include <stdbool.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/rcc.h>
#include <libopencmsis/core_cm3.h>
#include <libopencm3/stm32/usart.h>
#include <FreeRTOS.h>
#include <task.h>
#include <libopencm3/stm32/adc.h>

void hard_fault_handler() {
	while (1) {
		;
	}
}

#define MIN(a,b) (((a)<=(b))?(a):(b))
#define MAX(a,b) (((a)>=(b))?(a):(b))

//delay в микросекундах. 1 итерация -- 8 тактов, 9 итераций -- 8*9*1/72 = 1мкс
void delay_us(uint32_t us) {
	__asm volatile (
		"push {r0}\r\n"
		"mov R0, %0\r\n"
		"_loop:\r\n" //approx. 8ticks/iteration
			"cmp R0, #0\r\n"     //1
			"beq _exit\r\n"      //1 or 1+P (when condition is True)
			"sub R0, R0, #1\r\n" //1
			"nop\r\n" //1 allignment
			"b _loop\r\n" //1+P (pipeline refill) ~4 cycle
		"_exit:\r\n"
		"pop {r0}\r\n"
		:: "r"(9 * us) //for 72Mhz
	);
}

//задержка в ms. Для больших задержек, учитываем вместимость типа.
//Если us слишком большое, то делаем несколько задержек
void delay_ms(uint32_t ms) {
	const uint32_t maxMs = UINT32_MAX/1000;
	while (ms > 0) {
		uint32_t msToDelay = MIN(ms, maxMs);
		delay_us(msToDelay * 1000);
		ms -= msToDelay;
	}
	//Упрощённо: delay_us(ms * 1000);
}

void usart_print(const char *str) {
	while (*str != '\0') {
		usart_send_blocking(USART1, *str);
		str++;
	}
}

char * uint16tohex(char *buffer, uint16_t value) {
	for (int i=3; i>=0; i--) {
		uint32_t nibble = (value >> i*4) & 0xF;
		if (nibble <= 9)
			*buffer = nibble + '0';
		else //nibble >9
			*buffer = (nibble - 10) + 'a';
		buffer++;
	}
	return buffer;
}

void init_uart() {
	rcc_periph_clock_enable(RCC_GPIOA);
	rcc_periph_clock_enable(RCC_USART1);
	gpio_set_mode(GPIOA, GPIO_MODE_OUTPUT_2_MHZ, 
		GPIO_CNF_OUTPUT_ALTFN_PUSHPULL, GPIO9); //PA9 -- TX
	gpio_set_mode(GPIOA, GPIO_MODE_INPUT,
		GPIO_CNF_INPUT_FLOAT, GPIO10); //PA10 -- RX
	usart_set_baudrate(USART1, 9600);
	usart_set_mode(USART1, USART_MODE_TX_RX);
	//usart_set_databits(USART1, 8);
	usart_set_stopbits(USART1, USART_CR2_STOPBITS_1);
	usart_enable(USART1);
}

#define ADC_BUF_SIZE 1024
static uint16_t ADCBuffer[ADC_BUF_SIZE] = {0};
static uint16_t ADCBufPos = 0;
static bool Complete = false;

void adc1_2_isr() {
	if (adc_eoc(ADC1)) {
		uint16_t value = adc_read_regular(ADC1);
		ADCBuffer[ADCBufPos] = value;
		ADCBufPos = (ADCBufPos + 1)%ADC_BUF_SIZE;
	}
	if (ADCBufPos >= 1023) {
		adc_power_off(ADC1);
		Complete = true;
	}

	ADC_SR(ADC1) = 0; //Сброс флага прерывания
}

void adc_task(void *params) {
	init_uart();

	//Pa0
	rcc_periph_clock_enable(RCC_GPIOA);
	rcc_periph_clock_enable(RCC_AFIO); //?
	gpio_set_mode(GPIOA, GPIO_MODE_INPUT,
		GPIO_CNF_INPUT_ANALOG, GPIO0);
	rcc_periph_clock_enable(RCC_ADC1);
	//Max. ADC clk = 14Mhz по Даташиту
	adc_power_off(ADC1); //выкл.
	delay_us(1000);
	rcc_set_adcpre(RCC_CFGR_ADCPRE_PCLK2_DIV8);

	adc_power_on(ADC1); //вкл.
	adc_reset_calibration(ADC1);
	adc_calibrate_async(ADC1); //стартуем калибровку
	uint32_t cal_iteration = 0;
	while (adc_is_calibrating(ADC1)) {
		if (cal_iteration++ >= 100000) {
			usart_print("Calibration timeout\r\n");
			return;
		}
	}
	adc_power_off(ADC1); //выкл.
	//init adc
	//Регулярная группа каналов. До 8каналов из 16 доступных
	adc_set_regular_sequence(ADC1, 1, (uint8_t[]){ADC_CHANNEL0});
	//Частота сэмплирования хитрая! В клоках, а не во времени!
	adc_set_sample_time(ADC1, 0, ADC_SMPR_SMP_239DOT5CYC );
	//F_adc / (smpr + 12.5)
	//External trigger
	//EXTSEL SWSTART -- Триггер ручного запуска ADC
	adc_enable_external_trigger_regular(ADC1, ADC_CR2_EXTSEL_SWSTART);
	adc_set_continuous_conversion_mode(ADC1); //вкл. непрерывный режим
	adc_enable_eoc_interrupt(ADC1);
	//вкл. питание
	adc_power_on(ADC1);
	nvic_enable_irq(NVIC_ADC1_2_IRQ);
	nvic_set_priority(NVIC_ADC1_2_IRQ, 0);
	delay_us(1000);

	uint16_t value = 0;
	adc_power_on(ADC1);
	adc_start_conversion_regular(ADC1);

	while (1) {
		/*
		adc_start_conversion_regular(ADC1);
		//EOC --End of Convertion
		while (!adc_eoc(ADC1)) ;
		//DR -- Один единственный регистр на все каналы по очереди
		value = adc_read_regular(ADC1);
		uint32_t voltage = (3300 * value) / 4096;
		//3300мВ -- напряжение питания
		//4096 -- полный диапазон ADC
		//выведем в uart
		*/
		
		
		if (Complete) {
			
			usart_print("Complete\r\n");
			char buffer[32] = {0};
			
			for (int i = 0; i < ADC_BUF_SIZE; i++){
				
				uint16tohex(buffer, ADCBuffer[i]);
				usart_print(buffer);
				usart_print(" ");
			}
			
			usart_print(buffer);
			usart_print("\r\n");
			Complete = false;
	
		}
		vTaskDelay(300);
	}
}

//arg -- параметр задаче (который нам нужен)
void taskBlink(void *arg) {
	rcc_periph_clock_enable(RCC_GPIOC);
	gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ, 
		GPIO_CNF_OUTPUT_PUSHPULL, GPIO13);
	while (1) {
		gpio_toggle(GPIOC, GPIO13);
		vTaskDelay(1000); //1sec. delay
	}
}

int main(void) {
	rcc_clock_setup_pll (&rcc_hse_configs [RCC_CLOCK_HSE8_72MHZ ]);
#if 0	//Uart
	rcc_periph_clock_enable(RCC_GPIOC);
	gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ, 
		GPIO_CNF_OUTPUT_PUSHPULL, GPIO13); //PC13 LED
	//USART1
	rcc_periph_clock_enable(RCC_GPIOA);
	rcc_periph_clock_enable(RCC_USART1);
	gpio_set_mode(GPIOA, GPIO_MODE_OUTPUT_2_MHZ, 
		GPIO_CNF_OUTPUT_ALTFN_PUSHPULL, GPIO9); //PA9 -- TX
	gpio_set_mode(GPIOA, GPIO_MODE_INPUT,
		GPIO_CNF_INPUT_FLOAT, GPIO10); //PA10 -- RX
	
	usart_set_baudrate(USART1, 9600);
	usart_set_mode(USART1, USART_MODE_TX_RX);
	//usart_set_databits(USART1, 8);
	usart_set_stopbits(USART1, USART_CR2_STOPBITS_1);
	//прерывание в периферии вкл.
	usart_enable_rx_interrupt(USART1);
	//NVIC -- в ядре MCU
	nvic_set_priority(NVIC_USART1_IRQ, 0);
	nvic_enable_irq(NVIC_USART1_IRQ);
	usart_enable(USART1);

	while (1) {
		if (Command) {
			if (LedState)
				gpio_set(GPIOC, GPIO13);
			else
				gpio_clear(GPIOC, GPIO13);
			Command = false;
			usart_print("OK\r\n");
		}
	}
#endif
	xTaskCreate(taskBlink, "blink", 256, NULL, 0, NULL);

	xTaskCreate(adc_task, "ADC", 256, NULL, 0, NULL);

	vTaskStartScheduler();
}