#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "driver/gpio.h"
#include "esp_log.h"

#define ws_2812_pin PIN_NUM_8

static inline void spin(volatile unsigned long count) {
  while (count--) asm volatile("nop");
}

// API WS2812
static inline void ws2812_show(int pin, const uint8_t *buf, size_t len) {
  unsigned long delays[2] = {5, 8};
  for (size_t i = 0; i < len; i++) {
    for (uint8_t mask = 0x80; mask; mask >>= 1) {
      int i1 = buf[i] & mask ? 1 : 0, i2 = i1 ^ 1;  // This takes some cycles
      gpio_set_level(pin, 1);
      spin(delays[i1]);
      gpio_set_level(pin, 0);
      spin(delays[i2]);
    }
  }
}



void vTask1(void *pvParameters)
{
    while (1)
    {
        printf("Task 1 is running\n");
        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}


void vTask2(void *pvParameters)
{
    while (1)
    {
        printf("Task 2 is running\n");
        vTaskDelay(pdMS_TO_TICKS(1200));
    }
}


void app_main(void)
{
    xTaskCreate(vTask1, "Task 1", 2048, NULL, 1, NULL);
    xTaskCreate(vTask2, "Task 2", 2048, NULL, 1, NULL);

    // The scheduler is already started in ESP-IDF, so no need to call vTaskStartScheduler()

}