#define GPIO 0x91000000
#include <stdint.h>

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
    }
}