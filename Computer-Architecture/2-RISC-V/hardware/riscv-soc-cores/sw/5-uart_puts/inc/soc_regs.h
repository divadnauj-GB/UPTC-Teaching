#ifndef __SOC_REGS_H__
#define __SOC_REGS_H__
#include <stdint.h>

#ifdef QEMU

    #define GPIO_BASE 0x80020000
    #define UART_BASE 0x10000000

#else

    #define GPIO_BASE 0x91000000
    #define UART_BASE 0x90000000

#endif


#endif