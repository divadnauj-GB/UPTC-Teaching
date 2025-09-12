
CFLAGS=-g -Wall

all: program

program: 
	gcc $(CFLAGS) main.c -o main

test: program
	./main


debug: program
	gdb ./main -ex "tb main" -ex "c"



clean:
	rm -f *.o main
