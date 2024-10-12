all: test_1
test_1: test_1.o
	gcc test_1.o -o test_1

test_1.o: test_1.c
	gcc -c test_1.c

clean:
	rm -rf *.o