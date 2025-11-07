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


SemaphoreHandle_t SMF1;
SemaphoreHandle_t SMF2;
SemaphoreHandle_t SMF3;

void vTask1(void *pvParameters)
{
    while (1)
    {
        if (xSemaphoreTake(SMF1, pdMS_TO_TICKS(200)) == true)
		{
            uint8_t led_data[3] = {0x20, 0x00, 0x00}; // Red color
            ws2812_show(ws_2812_pin, led_data, sizeof(led_data));
            vTaskDelay(pdMS_TO_TICKS(500));
            uint8_t led_data_off[3] = {0x00, 0x00, 0x00}; // LED off
            ws2812_show(ws_2812_pin, led_data_off, sizeof(led_data_off));
            vTaskDelay(pdMS_TO_TICKS(500));
            xSemaphoreGive(SMF2);
        }else
        {
            // Timeout occurred
            printf("Semaphore take timed out\n");
        }
        vTaskDelay(pdMS_TO_TICKS(100));
    }
}


void vTask2(void *pvParameters)
{
    while (1){
       
        //if (xSemaphoreTake(SMF, pdMS_TO_TICKS(200)) == true)
        //    {
            if (xSemaphoreTake(SMF2, pdMS_TO_TICKS(200)) == true)
            {
                    uint8_t led_data[3] = {0x00, 0x20, 0x00}; // Red color
                    ws2812_show(ws_2812_pin, led_data, sizeof(led_data));
                    vTaskDelay(pdMS_TO_TICKS(500));
                    uint8_t led_data_off[3] = {0x00, 0x00, 0x00}; // LED off
                    ws2812_show(ws_2812_pin, led_data_off, sizeof(led_data_off));
                    vTaskDelay(pdMS_TO_TICKS(500));
                    xSemaphoreGive(SMF3);
            }
        }
}

void vTask3(void *pvParameters)
{
    while (1){
       
        //if (xSemaphoreTake(SMF, pdMS_TO_TICKS(200)) == true)
        //    {
            if (xSemaphoreTake(SMF3, pdMS_TO_TICKS(200)) == true)
            {
                    uint8_t led_data[3] = {0x00, 0x00, 0x20}; // Red color
                    ws2812_show(ws_2812_pin, led_data, sizeof(led_data));
                    vTaskDelay(pdMS_TO_TICKS(500));
                    uint8_t led_data_off[3] = {0x00, 0x00, 0x00}; // LED off
                    ws2812_show(ws_2812_pin, led_data_off, sizeof(led_data_off));
                    vTaskDelay(pdMS_TO_TICKS(500));
                    xSemaphoreGive(SMF1);
            }
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
    SMF1 =  xSemaphoreCreateBinary();
    SMF2 =  xSemaphoreCreateBinary();
    SMF3 =  xSemaphoreCreateBinary();
    xSemaphoreGive(SMF1);
    xTaskCreate(vTask1, "Task 1", 2048, NULL, 1, NULL);
    xTaskCreate(vTask2, "Task 2", 2048, NULL, 1, NULL);
    xTaskCreate(vTask3, "Task 3", 2048, NULL, 1, NULL);

    // The scheduler is already started in ESP-IDF, so no need to call vTaskStartScheduler()

}