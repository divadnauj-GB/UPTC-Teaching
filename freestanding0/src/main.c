#include <system.h>
/* 
static  int sisyphus = 0;
int main( void ) {
  // Increment a variable.
  soc_init();
  wdt_disable();
  //printf("Hello, ESP32 %d!\n",sisyphus);
  for ( ; ; ) {
    ++sisyphus;
    //printf("Hello, ESP32 %d!\n",sisyphus);
  }
  return 0;
}

*/



// On the ESP32C3 dev boards, the WS2812 LED is connected to GPIO 8
static int ws_2812_pin = 8;

// Simple hue function for generation of smooth rainbow.
static uint8_t hueval(int value) {
  value = value % 1536;
  if (value < 256) {
    return (uint8_t) value;
  } else if (value < 768) {
    return 255;
  } else if (value < 1024) {
    return (uint8_t) (1023 - value);
  } else {
    return 0;
  }
}

static void blink(int count, unsigned long delay_millis) {
  uint8_t green[3] = {100, 0, 0}, black[3] = {0, 0, 0};
  for (int i = 0; i < count; i++) {
    ws2812_show(ws_2812_pin, green, sizeof(green));
    delay_ms(delay_millis);
    ws2812_show(ws_2812_pin, black, sizeof(black));
    delay_ms(delay_millis);
  }
}

static void rainbow(int count) {
  for (int i = 0; i < count; i++) {
    uint8_t rgb[3] = {hueval(i), hueval(i + 512), hueval(i + 1024)};
    ws2812_show(ws_2812_pin, rgb, sizeof(rgb));
    delay_ms(2);
  }
}

int main(void) {
  int initialized = 0;
  wdt_disable();
  gpio_output(ws_2812_pin);

  for (;;) {
    printf("Blinking and rainbow...%d\n",initialized++);
    blink(3, 100);
    rainbow(2000);
  }

  return(0);
  //return 0;
}



/*
static int led_pin = LED1;  // To override: make EXTRA_CFLAGS=-DLED1=5
static int led_state = 0;
static int ws_2812_pin = 8;

int main(void) {
  wdt_disable();
  gpio_output(ws_2812_pin);

  for (;;) {
    printf("LED: %d\n", led_state);  // Print current state to console
    gpio_write(led_pin, led_state);  // Blink an LED
    led_state = !led_state;          // Toggle state
    delay_ms(500);                   // Delay a bit
  }

  return 0;
}

*/