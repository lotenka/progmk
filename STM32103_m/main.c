/*#include <stdint.h>
#include <stm32f10x.h>
#include <stdio.h>


int __attribute((noreturn)) main(void) {
    //RCC->APB2ENR |= 0b10000;
    // Включает тактирование PORTC, PORTB
    RCC->APB2ENR |= (RCC_APB2ENR_IOPCEN | RCC_APB2ENR_IOPBEN);
    // Настройка PORTC, PC13 на выход, General purpose output push-pull
    // Vopros. Configuracia dlya PC13 CNF(00) MODE(10), verno?
    GPIOC->CRH = ~(GPIO_CRH_CNF13 | GPIO_CRH_MODE13) | GPIO_CRH_MODE13_0; 
    // Настройка PORTB, PB9 на вход с подтягивающим резистором
    // Vopros. Configuracia dlya PB9 CNF(01) MODE(00), verno?
    // Why we set reserved??
    GPIOB->CRH = ~(GPIO_CRH_CNF9 | GPIO_CRH_MODE9) | GPIO_CRH_CNF9_1;
    // Включение pull-up на PB9
    GPIOB->ODR |= GPIO_ODR_ODR9;
    // Запись логического 0 на выход PC13 (LED ON)
    GPIOC->ODR |= GPIO_ODR_ODR13;

    while (1) {
        if ((GPIOB->IDR & GPIO_IDR_IDR9)){ 
            //Why we set zero to PC13?
            //GPIOC->ODR |= GPIO_ODR_ODR13; // LED OFF
            GPIOC->ODR &= ~GPIO_ODR_ODR13; // LED ON
        } else { // Button is pressed
            GPIOC->ODR |= GPIO_ODR_ODR13; // LED OFF
        }
    }
    
}*/
// git check

#include <stdint.h>
#include <stm32f10x.h>
#include <stdbool.h>

void delay(uint32_t ticks) {
	for (int i=0; i<ticks; i++) {
		__NOP();
	}
}

int MIN(uint32_t arr[]) {
    int min = arr[0];
    for (int i = 0; i < 4; i++){
        if (arr[i] < min){
            min = arr[i];
        }
    }
    return min;
}
#define MAX(a,b) (((a)>=(b))?(a):(b))
#define MIN_EX(a,b) (((a)<=(b))?(a):(b))

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
		uint32_t m[] = {ms, maxMs};
		uint32_t msToDelay = MIN(m);
		delay_us(msToDelay * 1000);
		ms -= msToDelay;
	}
	//Упрощённо: delay_us(ms * 1000);
}

#define LED_PIN_NO 13


//Port Number: A,B,C,...
//Pin number (line)
void gpioToggle(GPIO_TypeDef* port, uint32_t lineNo) {
	const uint32_t mask = (1<<lineNo);
	uint16_t gpio = port->ODR & mask;
	port->BSRR = (gpio << 16) | (~gpio & mask);
	//BSRR: [31:16] -- reset, [15:0] -- set
}

static volatile uint32_t Counter = 0;

void SysTick_Handler() {
	//Do some periodic action
	Counter++;
}

//getter
uint32_t getSystemCounter() {
	return Counter;
}

void some_action() {
	uint16_t gpio = GPIOC->ODR & GPIO_ODR_ODR13;
	GPIOC->BSRR = (gpio << 16) | (~gpio & GPIO_ODR_ODR13);
	//BSRR: [31:16] -- reset, [15:0] -- set
	//delay_ms(100);
}

int __attribute((noreturn)) main(void) 
{
#if 0 //Простейшая программа "Blink"
	// Enable clock for AFIO
	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
	// Enable clock for GPIOC
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
	// Enable PC13 push-pull mode
	GPIOC->CRH &= ~GPIO_CRH_CNF13; //clear cnf bits
	GPIOC->CRH |= GPIO_CRH_MODE13_0; //Max speed = 10Mhz

    while (1) {
	    GPIOC->ODR |= (1U<<13U); //U -- unsigned suffix (to avoid syntax warnings in IDE)
		delay(5000000);
	    GPIOC->ODR &= ~(1U<<13U);
	    delay(1000000);
    }
#endif
	RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
	//CRL: пины 0-7, CRH: пины 8-15
	GPIOC->CRH = GPIOC->CRH & ~(GPIO_CRH_CNF13 | GPIO_CRH_MODE13) | GPIO_CRH_MODE13_0; //PC13 = output
	//включаем тактирование порта A
	RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
	//конфигурируем GPIOA 3-5 пины на вход
	GPIOA->CRL = GPIOA->CRL & ~(GPIO_CRL_CNF1|GPIO_CRL_CNF2|GPIO_CRL_CNF3|GPIO_CRL_CNF4|GPIO_CRL_CNF5 |
	  GPIO_CRL_MODE1|GPIO_CRL_MODE2|GPIO_CRL_MODE3|GPIO_CRL_MODE4|GPIO_CRL_MODE5) |
	  GPIO_CRL_CNF1_1|GPIO_CRL_CNF2_1|GPIO_CRL_CNF3_1|GPIO_CRL_CNF4_1|GPIO_CRL_CNF5_1;
	//включаем подтяжку к питанию
	GPIOA->ODR |= GPIO_ODR_ODR1|GPIO_ODR_ODR2|GPIO_ODR_ODR3|GPIO_ODR_ODR4|GPIO_ODR_ODR5;

/*
	//Конфигурация SySTick
	SysTick_Config(SystemCoreClock/1000);

	while (1) {
		uint32_t start = getSystemCounter();
		//Переключение состояния светодиода
		some_action();
		uint32_t elapsed = getSystemCounter() - start;
		//delay_ms(200 - elapsed);
		delay_ms(200);
	}
	*/
	bool duty_cycle = true;
	uint32_t d = 90; // koef dutycycle

	uint32_t t1 = 500; //led switch period ON
	uint32_t p1 = t1 * d / 100;
	uint32_t p2 = t1 * (100 - d) / 100;
	const uint32_t t2 = 50;
	const uint32_t t3 = 50;  //button check period
    const uint32_t t4 = 50;
    const uint32_t t5 = 50;
	const uint32_t t6 = 50;

	uint32_t p[] = {t1, t2, t3, t4, t5, t6};
	//У кого-то это кнопка PB9
	bool prevButtonState5 = GPIOA->IDR & GPIO_IDR_IDR5;
    bool prevButtonState4 = GPIOA->IDR & GPIO_IDR_IDR4;
    bool prevButtonState3 = GPIOA->IDR & GPIO_IDR_IDR3;
	bool prevButtonState2 = GPIOA->IDR & GPIO_IDR_IDR2;
	bool prevButtonState1 = GPIOA->IDR & GPIO_IDR_IDR1;

	bool ledBlink = true;

	while (1) 
	{
		uint32_t tau = MIN(p);
		delay_ms(tau);
		uint32_t p1 = t1 * d / 100;
		uint32_t p2 = t1 * (100 - d) / 100;
		for (int i=0; i<8; i++) {
			p[i] -= tau;
		}
		if (p[0] == 0) {
			if (ledBlink)
				gpioToggle(GPIOC, 13);
			if (duty_cycle)
				p[0] = p1;
			else
				p[0] = p2;
			duty_cycle = !duty_cycle;
		}
		if (p[1] == 0) {
			//PB9 кнопка mid
			bool newState5 = GPIOA->IDR & GPIO_IDR_IDR5;
			if (!newState5 && prevButtonState5)
				ledBlink = !ledBlink; //switch led blink
			
			prevButtonState5 = newState5;
			p[1] = t2;
		}
		if (p[2] == 0) {
			//A4 button UP
			bool newState4 = GPIOA->IDR & GPIO_IDR_IDR4;
			if (!newState4 && prevButtonState4 && (t1 < 1000))
				//increase led blink delay by 5ms
				t1 += 5;
				
			p[2] = t3;
		}
		if (p[3] == 0) {
			//A3 button DOWN
			bool newState3 = GPIOA->IDR & GPIO_IDR_IDR3;
			if (!newState3 && prevButtonState3 && (t1 > 10))
				//decrease led blink delay by 5ms
				t1 -= 5;
			
			p[3] = t4;
		}
		if (p[4] == 0) {
			//A2 button RIGHT increase duty cycle koef
			bool newState2 = GPIOA->IDR & GPIO_IDR_IDR2;
			if (!newState2 && prevButtonState2 && (d < 90))
				//decrease duty cycle koef by 5%
				d += 5;
			
			p[4] = t5;
		}
		if (p[5] == 0) {
			//A3 button LEFT decrease duty cycle koef
			bool newState1 = GPIOA->IDR & GPIO_IDR_IDR1;
			if (!newState1 && prevButtonState1 && (d > 10))
				//decrease duty_cycle koef by 5%
				d -= 5;
			
			p[5] = t6;
		}
	}
}
