#include <stdio.h>
#include <omp.h>

void print_message(int id) {
	printf("Runnign function from thread : %d\n", id);
}

int main()
{
	int nthreads, tid;
	printf("Hello parallel world from threads:\n");

	/* set the number of threads (maybe greater than number of 
	   core/processors) */
	omp_set_num_threads(5);

	// fork
	#pragma omp parallel private(tid) default(none)
	{
		tid = omp_get_thread_num();
	  printf("Execution from thread: %d\n", tid);
	  print_message(tid);
	}
	// implicit join given by }

	printf("Back to the serial world.\n");
}