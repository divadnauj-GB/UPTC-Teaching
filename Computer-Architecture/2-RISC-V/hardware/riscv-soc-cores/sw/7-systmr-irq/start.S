
//#include "nanorv32.h"

.global main

.section .text.init
.global _start
.type   _start, @function
_start:
.option push
.option norelax
	csrci mstatus, 8
	/* zero-initialize all registers */
	addi x1, zero, 0
	addi x2, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0
	la		gp,__global_pointer$
.option pop
	# Clear the bss segment
	la      a0,__bss_start
	la      a1,__BSS_END__

clear_bss:
	bgeu	a0,a1,finish_bss
	sb		x0,0(a0)
	addi	a0,a0,1
	beq		x0,x0,clear_bss
finish_bss:
	la sp, __stack_top
	call    __libc_init_array       # Run global initialization functions

	
	call    main

	# abort execution here
	ebreak			

	.size  _start, .-_start


