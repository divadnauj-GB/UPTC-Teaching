#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N       100000
#define CHUNKSIZE   100

int main() {

	int i, chunk, tid;
	float a[N], b[N], c[N];

/* Some initializations */
	for (i = 0; i < N; i++)
		a[i] = b[i] = i * 1.0;
	chunk = CHUNKSIZE;
	clock_t t = clock();
//#pragma omp parallel for shared(a, b, c, chunk) private(i) schedule(static, chunk) default(none)
   //The schedule(static, chunk-size) clause of the loop construct
   // specifies that the for loop has the static scheduling type.
   // OpenMP divides the iterations into chunks of size chunk-size
   // and it distributes the chunks to threads in a circular order.
//#pragma omp parallel shared(a, b, c, chunk) private(i) default(none)
#pragma omp parallel for shared(a, b, c, chunk,tid) private(i) schedule(static, chunk) default(none)
	//{
		for (i = 0; i < N; i++){
			c[i] = a[i] + b[i];
		}
		tid = omp_get_thread_num();
	  	printf("Execution from thread: %d\n", tid);
		
	//}

	// end of parallelized for
	t = clock() - t;
	double time_taken = ((double) t) / CLOCKS_PER_SEC; // in seconds

	printf("The loop took %lf seconds (%lu) to execute \n", time_taken, t);
}


