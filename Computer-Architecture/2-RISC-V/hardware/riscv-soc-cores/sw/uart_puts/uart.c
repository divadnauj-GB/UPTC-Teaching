#include "uart.h"
#include <stdint.h>

void uart_init(void) {
    
    volatile uint32_t *uart = (uint32_t *)DEBUG_LL_UART_ADDR;

    uart[UART_LCR >> DEBUG_LL_UART_SHIFT] = UART_LCR_DLAB; // DLAB on
    uart[UART_DLL >> DEBUG_LL_UART_SHIFT] = DEBUG_LL_UART_DIVISOR & 0xFF; // write low order byte
    uart[UART_DLM >> DEBUG_LL_UART_SHIFT] = (DEBUG_LL_UART_DIVISOR >> 8) & 0xFF; // write high order byte
    uart[UART_LCR >> DEBUG_LL_UART_SHIFT] = UART_LCR_W; // DLAB off
}


void uart_putc(char c) {
    volatile uint32_t *uart = (uint32_t *)DEBUG_LL_UART_ADDR;

    // Wait for transmitter to be ready
    while ((uart[UART_LSR >> DEBUG_LL_UART_SHIFT] & UART_LSR_THRE) == 0);

    // Send the character
    uart[UART_THR >> DEBUG_LL_UART_SHIFT] = c;
}


char uart_getc(void) {
    volatile uint32_t *uart = (uint32_t *)DEBUG_LL_UART_ADDR;

    // Wait for data to be available
    while ((uart[UART_LSR >> DEBUG_LL_UART_SHIFT] & UART_LSR_DR) == 0);

    // Read and return the character
    return (char)(uart[UART_RBR >> DEBUG_LL_UART_SHIFT] & 0xFF);
}


void uart_puts(const char *s) {
    while (*s) {
        if (*s == '\n') {
            uart_putc('\r'); // Carriage return before newline
        }
        uart_putc(*s++);
    }
}