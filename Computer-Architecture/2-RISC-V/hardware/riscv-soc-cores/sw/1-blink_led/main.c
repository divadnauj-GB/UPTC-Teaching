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
    int led_val = 1; // Initialize LEDs to off (assuming active low)
    while (1) {
        *gpio = led_val; // Set LEDs
        delay(200000);   // Simple delay
        led_val <<=1; // shift left
        if (led_val > 0x80) led_val = 1; // reset
    }
}