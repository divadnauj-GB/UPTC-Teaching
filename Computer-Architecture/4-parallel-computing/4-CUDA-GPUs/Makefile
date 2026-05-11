CUDA_ROOT_DIR=/usr/local/cuda-11.6
SM_ARCH=86

NVCC=nvcc
NVCC_FLAGS=-gencode arch=compute_${SM_ARCH},code=sm_${SM_ARCH} 
NVCC_LIBS=

# CUDA library directory:
CUDA_LIB_DIR= -L$(CUDA_ROOT_DIR)/lib64
# CUDA include directory:
CUDA_INC_DIR= -I$(CUDA_ROOT_DIR)/include
# CUDA linking libraries:
CUDA_LINK_LIBS= -lcudart


vectorAdd:
	$(NVCC) $(NVCC_FLAGS) -c vector_addition.cu $(NVCC_LIBS)
	$(NVCC) vector_addition.o -o run
	./run 

matmul:
	$(NVCC) $(NVCC_FLAGS) -c matmul.cu $(NVCC_LIBS)
	$(NVCC) matmul.o -o run
	./run 

clean:
	rm run