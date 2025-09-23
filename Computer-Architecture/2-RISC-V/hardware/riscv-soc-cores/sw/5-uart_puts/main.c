#include <stdint.h>
#include <stdio.h>
#include "soc_gpio.h"
#include "soc_uart.h"

char wr_buffer[256]="";

void delay(volatile uint32_t count) {
    while (count--) {
        __asm__ volatile("nop");
    }
}

void main(void) {
    volatile uint32_t sw_value = 0;

    gpio_init();
    uart_init(115200); // Initialize UART
    
    while (1) {
        sw_value = gpio_read_port();
        gpio_write_port(sw_value);
        delay(200000);   // Simple delay
        sprintf(wr_buffer, "GPIO State: 0x%08X\n\r", (uint32_t)sw_value); // Use newlib sprintf
        uart_puts(wr_buffer); // Output gpio state
    }
}