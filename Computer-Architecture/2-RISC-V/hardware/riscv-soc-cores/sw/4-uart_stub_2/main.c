#define GPIO 0x91000000
#include <stdint.h>
#include <stdio.h>

extern void _nmon_outs(const char *val0, const char *fmt);

char wr_buffer[256]="";

void delay(volatile uint32_t count) {
    while (count--) {
        __asm__ volatile("nop");
    }
}

void main(void) {
    volatile uint32_t *gpio = (uint32_t *)GPIO;
    uint32_t sw_value = 0;
    while (1) {
        sw_value = *gpio;  // Read current state
        *gpio = sw_value;  // Write to LEDs
        delay(200000);   // Simple delay
        sprintf(wr_buffer, "GPIO State: 0x%08X\n\r", (uint8_t)sw_value); // Use newlib sprintf
        _nmon_outs(wr_buffer,wr_buffer); // Output gpio state
    }
}