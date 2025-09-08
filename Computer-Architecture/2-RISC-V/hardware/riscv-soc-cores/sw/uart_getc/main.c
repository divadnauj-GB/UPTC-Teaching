#define GPIO 0x91000000
#include <stdint.h>
#include <stdio.h>
#include "uart.h"

char wr_buffer[256]="";

void delay(volatile uint32_t count) {
    while (count--) {
        __asm__ volatile("nop");
    }
}

void main(void) {
    volatile uint32_t *gpio = (uint32_t *)GPIO;
    int sw_value = 0;
    uart_init(); // Initialize UART
    while (1) {
        while (uart_tstc())  // Check if data is available
        {
            char c = uart_getc();  // Read character
            if (c == 'u') {
                sw_value++;  // Increment on 'u'
            } else if (c == 'd') {
                sw_value--;  // Decrement on 'd'
            }
            if (sw_value > 0xFF)  // Limit to 8 bits
            {
                sw_value = 0xFF;
            }
            if (sw_value < 0) {
                sw_value = 0;
            }
            *gpio = sw_value;  // Write to LEDs
            sprintf(wr_buffer, "GPIO State: 0x%08X\n\r", (uint8_t)sw_value); // Use newlib sprintf
            uart_puts(wr_buffer); // Output gpio state
        }
        
    }
}