CC=mpicc
LDFLAGS=-fopenmp
#--hostfile <file>
HOSTFILE=
NP=8


one:
	$(CC) 1-environ.c -o app $(LDFLAGS)
	mpirun -np $(NP) $(HOSTFILE) --oversubscribe ./app

two:
	$(CC) 2-blocking.c -o app $(LDFLAGS)
	mpirun -np $(NP) $(HOSTFILE) --oversubscribe ./app

three:
	$(CC) 3-nonblock.c -o app $(LDFLAGS)
	mpirun -np $(NP) $(HOSTFILE) --oversubscribe ./app

four:
	$(CC) 4-hybrid.c -o app $(LDFLAGS)
	mpirun -np $(NP) $(HOSTFILE) --oversubscribe ./app

clean:
	rm app