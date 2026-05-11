// Include C++ header files.
#include <iostream>

#include <math.h>

#define M 500
#define N 1000
#define K 300

/**
 * Sample CUDA device function which adds an element from array A and array B.
 *
 */
__global__ void MatMul(float *A, float *B, float *C, int Mn, int Nn, int Kn) 
{
    int row = blockIdx.y*blockDim.y + threadIdx.y;
    int col = blockIdx.x*blockDim.x + threadIdx.x;
    if (row<Mn && col<Nn){
        for (int ii = 0; ii < Kn; ii++) {
            C[row * Nn + col] += A[row * Kn + ii] * B[ii * Nn + col];
        }
    }
}

/**
 * Wrapper function for the CUDA kernel function.
 */
void kernel(float *A, float *B, float *C, int Mn, int Nn, int Kn) {
    // Launch CUDA kernel.
    float *d_A, *d_B, *d_C;
    cudaMalloc((void**) &d_A, M*K*sizeof(float));
    cudaMalloc((void**) &d_B, K*N*sizeof(float));
    cudaMalloc((void**) &d_C, M*N*sizeof(float));

    cudaMemcpy(d_A, A, M*K*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, K*N*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_C, C, K*N*sizeof(float), cudaMemcpyHostToDevice);

    dim3 blockSize(32,32);
    dim3 gridSize(ceil(((float)N)/blockSize.x), 
                  ceil(((float)M)/blockSize.y));

    MatMul<<<gridSize, blockSize>>>(d_A, d_B, d_C, Mn, Nn, Kn);
    //cudaDeviceSynchronize();
    cudaMemcpy(C, d_C, M*N*sizeof(float), cudaMemcpyDeviceToHost);
}


void cpu_MatMul(float *A, float *B, float *C, int m, int n, int k){
    for(int row=0; row<m; row++){
        for (int col=0; col<n; col++){
            for (int ii = 0; ii < k; ii++) {
                C[row * n + col] += A[row * k + ii] * B[ii * n + col];
            }
        }
    }
}


int main(void) {

    float *A;
    float *B;
    float *C, *C_cpu;

    A = (float *)malloc(M*K*sizeof(float));
    B = (float *)malloc(K*N*sizeof(float));
    C = (float *)malloc(M*N*sizeof(float));

    C_cpu = (float *)malloc(M*N*sizeof(float));

    for(int i=0;i<M;i++){
        for(int j=0;j<K;j++){
            A[K*i+j]=static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
        }
    }

    for(int i=0;i<K;i++){
        for(int j=0;j<N;j++){
            B[N*i+j]=static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
        }
    }

    for(int i=0;i<M;i++){
        for(int j=0;j<N;j++){
            C[N*i+j]=0;
            C_cpu[N*i+j]=0;
        }
    }

    cpu_MatMul(A,B,C_cpu,M,N,K);

    kernel(A,B,C,M,N,K);
    bool error = false;
    float diff = 0.0;
    for(int i=0;i<M;i++){
        for(int j=0;j<N;j++){
            diff = abs(C[i*N+j] - C_cpu[i*N+j]);
            if (diff>10e-4){            
                error = true;
                std::cout << i << " " << j << " " << diff << " " << C[i*N+j] << " " << C_cpu[i*N+j] << std::endl;
           }           
        }
        //std::cout << std::endl;
    }

    if (error==true){
       printf("\nThe Results are Different!\n");
    }else{
        printf("\nThe Results match!\n");
    }

    printf("\nProgramm Finished!\n");
    return 0;
}