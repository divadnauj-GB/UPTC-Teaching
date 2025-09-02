
CC=gcc
CFLAGS=-c -Wall -g
INCLUDES=-I./inc


all: program

program: ./build/main.o ./build/special_functions.o
	$(CC) ./build/main.o ./build/special_functions.o -o ./build/program


./build/main.o: build main.c
	$(CC) $(CFLAGS) $(INCLUDES) main.c -o ./build/main.o

./build/special_functions.o: build ./src/special_functions.c
	$(CC) $(CFLAGS) $(INCLUDES) ./src/special_functions.c -o ./build/special_functions.o

build:
	mkdir -p build

test: program
	./build/program

debug: 
	gdb ./build/program -ex "tb main" -ex "c"

clean:
	rm -rf build program