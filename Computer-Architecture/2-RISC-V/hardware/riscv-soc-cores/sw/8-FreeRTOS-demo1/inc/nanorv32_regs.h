#ifndef __NANORV32_REGS_H__
#define __NANORV32_REGS_H__
#include <stdint.h>


#ifdef QEMU
    #define MTIME_BASE_ADDRESS		0x0200BFF8
    #define MTIMECMP_BASE_ADDRESS		0x02004000

#else

    #define csr_custom_irq_mask		0x7C0
    #define csr_custom_irq_pend		0x7C1
    #define csr_custom_trap			0x7C2
    #define MTIME_BASE_ADDRESS		0xfffffff0
    #define MTIMECMP_BASE_ADDRESS	0xfffffff8

#endif


#endif