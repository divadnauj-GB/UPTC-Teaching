CC=gcc
LDFLAGS=-fopenmp


hello:
	$(CC) hello.c -o app $(LDFLAGS)
	./app

for:
	$(CC) parallel.for.directive.c -o app $(LDFLAGS)
	./app

clean:
	rm app