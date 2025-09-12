#define GPIO 0x91000000
#include <stdint.h>
#include <stdio.h>

extern void _nmon_outs(const char *val0, const char *fmt); // nmon function to output strings via uart

char buffer[32]="hello world!\n\r";

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
        _nmon_outs(buffer,buffer); // Output uart using nmon function
    }
}