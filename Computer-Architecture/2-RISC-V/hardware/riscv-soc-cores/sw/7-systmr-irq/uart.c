#include "uart.h"
#include <stdint.h>

void uart_init(void) {
    volatile unsigned char *uart = (unsigned char *)DEBUG_LL_UART_ADDR;
    // Set baud rate divisor
    uart[UART_LCR] = UART_LCR_DLAB; // DLAB on
    uart[UART_DLL] = DEBUG_LL_UART_DIVISOR & 0xFF; // write low order byte
    uart[UART_DLM] = (DEBUG_LL_UART_DIVISOR >> 8) & 0xFF; // write high order byte
    uart[UART_LCR] = UART_LCR_W; // DLAB off
}


void uart_putc(char c) {
    volatile unsigned char *uart = (unsigned char *)DEBUG_LL_UART_ADDR;
    while ((uart[UART_LSR ] & UART_LSR_THRE) == 0);
    uart[UART_THR ] = c;
}


char uart_getc(void) {
    
    volatile unsigned char *uart = (unsigned char *)DEBUG_LL_UART_ADDR;
    return (char)(uart[UART_RBR ] & 0xFF);
}


int uart_tstc(void) {
    volatile unsigned char *uart = (unsigned char *)DEBUG_LL_UART_ADDR;
    return (uart[UART_LSR ] & UART_LSR_DR) != 0;
}

void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') {
            uart_putc('\r'); // Carriage return before newline
        }
        uart_putc(*s++);
    }
}
