#ifndef NANORV32_H
#define NANORV32_H
#include "nanorv32_regs.h"
#include "soc_regs.h"
#include "riscv-csr.h"


#ifdef QEMU
    #define CPU_CLK_FREQ  10000000 /*10 MHz*/

    #define PUSH_CUSTOM_TRAP_REGS
    #define POP_CUSTOM_TRAP_REGS 
#else
    #define CPU_CLK_FREQ 24000000 /*10 MHz*/
    
    #define PUSH_CUSTOM_TRAP_REGS \
    register unsigned int valuep;        \
        __asm__ __volatile__ ("addi sp, sp, -4" :::); \
        __asm__ __volatile__ ("csrr %0, 0x7C2" :"=r" (valuep)::); \
        __asm__ __volatile__ ("sw %0,0(sp)" ::"r" (valuep):)

    #define POP_CUSTOM_TRAP_REGS \
    register unsigned int value;        \
        __asm__ __volatile__ ("lw %0, 0(sp)" :"=r" (value)::); \
        __asm__ __volatile__ ("csrw 0x7C2, %0" ::"r" (value):); \
        __asm__ __volatile__ ("addi sp, sp, 4" :::)
    
#endif

#define US_PER_SECOND 1000000

void risc_v_trap_handler(void) __attribute__((interrupt));


#endif // NANORV32_H