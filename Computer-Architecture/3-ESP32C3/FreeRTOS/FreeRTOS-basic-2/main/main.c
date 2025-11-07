#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "driver/gpio.h"
#include "esp_log.h"

#define ws_2812_pin 8

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
        uint8_t green[3] = {100, 0, 0}, red[3]={0,100,0}, blue[3]={0,0,100}, black[3] = {0, 0, 0};
        ws2812_show(ws_2812_pin, red, sizeof(red));
        vTaskDelay(pdMS_TO_TICKS(200));
        ws2812_show(ws_2812_pin, green, sizeof(green));
        vTaskDelay(pdMS_TO_TICKS(200));
        ws2812_show(ws_2812_pin, blue, sizeof(blue));
        vTaskDelay(pdMS_TO_TICKS(200));
        ws2812_show(ws_2812_pin, black, sizeof(black));
        vTaskDelay(pdMS_TO_TICKS(200));
    }
}


void vTask2(void *pvParameters)
{
    while (1)
    {
        printf("Task 2 is running\n");
        vTaskDelay(pdMS_TO_TICKS(200));
    }
}

void vTask3(void *pvParameters)
{
    while (1)
    {
        printf("Task 3 is running\n");
        vTaskDelay(pdMS_TO_TICKS(200));
    }
}



void esp_configure_led_gpio()
{
   gpio_config_t io_conf = {};
   //disable interrupt
   io_conf.intr_type = GPIO_INTR_DISABLE;
   //set as output mode
   io_conf.mode = GPIO_MODE_OUTPUT;
   //bit mask of the pins that you want to set,e.g.GPIO18
   io_conf.pin_bit_mask = (1ULL << ws_2812_pin);
   //disable pull-down mode
   io_conf.pull_down_en = 0;
   //disable pull-up mode
   io_conf.pull_up_en = 0;
   //configure GPIO with the given settings
   gpio_config(&io_conf);

}

void app_main(void)
{
    esp_configure_led_gpio();

    xTaskCreate(vTask1, "Task 1", 2048, NULL, 1, NULL);
    xTaskCreate(vTask2, "Task 2", 2048, NULL, 1, NULL);
    xTaskCreate(vTask2, "Task 3", 2048, NULL, 1, NULL);
    // The scheduler is already started in ESP-IDF, so no need to call vTaskStartScheduler()

}