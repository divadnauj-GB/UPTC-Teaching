#include "soc_uart.h"


extern volatile soc_uart_dev_t *UART0_DEV =(soc_uart_dev_t *)UART_BASE;


void uart_init(uint32_t baudrate) {
    UART0_DEV->uart_reg3.RW_uart_LCR_bits.DLA=1;
    UART0_DEV->uart_reg3.RW_uart_LCR_bits.N=3;
    UART0_DEV->uart_reg3.RW_uart_LCR_bits.S=1;

    uint64_t uart_divisor=(UART_CLK/baudrate);
    UART0_DEV->uart_reg0.RW_uart_DLL=uart_divisor & 0xFF;
    UART0_DEV->uart_reg1.RW_uart_DLH=(uart_divisor>>8) & 0xFF;

    UART0_DEV->uart_reg3.RW_uart_LCR_bits.DLA=0;
}


void uart_putc(char c) {
    while(UART0_DEV->uart_reg5.R_uart_LSR_bits.TF==0);
    UART0_DEV->uart_reg0.W_uart_THR=c;
}


char uart_getc(void) {
    return((char)(UART0_DEV->uart_reg0.R_uart_RBR & 0xFF));
}


int uart_tstc(void) {
    return(UART0_DEV->uart_reg5.R_uart_LSR_bits.DR!=0);
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') {
            uart_putc('\r'); // Carriage return before newline
        }
        uart_putc(*s++);
    }
}
