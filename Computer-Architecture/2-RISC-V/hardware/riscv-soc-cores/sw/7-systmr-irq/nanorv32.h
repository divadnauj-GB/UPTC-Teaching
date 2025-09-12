#ifndef NANORV32_H
#define NANORV32_H

#define csr_custom_irq_mask		0x7C0
#define csr_custom_irq_pend		0x7C1
#define csr_custom_trap			0x7C2



#ifdef QEMU
    #define configMTIME_BASE_ADDRESS		0x0200BFF8
    #define configMTIMECMP_BASE_ADDRESS		0x02004000
    #define TICKS_PER_SECOND 10000000 /*10 MHz*/
    #define US_PER_SECOND 1000000 
    #define GPIO 0x100000

    #define PUSH_CUSTOM_TRAP_REGS
    #define POP_CUSTOM_TRAP_REGS 
#else
    #define configMTIME_BASE_ADDRESS		0xfffffff0
    #define configMTIMECMP_BASE_ADDRESS		0xfffffff8
    #define TICKS_PER_SECOND 24000000 /*10 MHz*/
    #define US_PER_SECOND 1000000
    #define GPIO 0x91000000
    
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

#define MTIME_TICK_PERIOD (TICKS_PER_SECOND / US_PER_SECOND)



#endif // NANORV32_H