#include <system.h>
#include <stdlib.h>
#include "hal/gpio_hal.h"
#include "hal/wdt_hal.h"
#include "soc/soc_caps.h"
#include "soc/system_reg.h"
#include "soc/system_struct.h"
#include "soc/clk_tree_defs.h"

volatile gpio_hal_context_t gpio_hal={.dev=GPIO_LL_GET_HW(0)};

typedef struct 
{
  wdt_hal_context_t rwdt_0;
  wdt_hal_context_t mwdt_0;
  wdt_hal_context_t mwdt_1;
} wdt_hal_all_context_t;

// On the ESP32C3 dev boards, the WS2812 LED is connected to GPIO 8
static int ws_2812_pin = GPIO_NUM_8;

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

static inline void ws2812_show_gpio(gpio_hal_context_t *gpio_hal, int pin, const uint8_t *buf, size_t len) {
  unsigned long delays[2] = {8, 12};
  for (size_t i = 0; i < len; i++) {
    for (uint8_t mask = 0x80; mask; mask >>= 1) {
      int i1 = buf[i] & mask ? 1 : 0, i2 = i1 ^ 1;  // This takes some cycles
      gpio_hal_set_level(gpio_hal,pin,1);
      spin(delays[i1]);
      gpio_hal_set_level(gpio_hal,pin,0);
      spin(delays[i2]);
    }
  }
}

static void blink(gpio_hal_context_t *gpio_hal,int count, unsigned long delay_millis) {
  uint8_t green[3] = {100, 0, 0}, black[3] = {0, 0, 0};
  for (int i = 0; i < count; i++) {
    ws2812_show_gpio(gpio_hal,ws_2812_pin, green, sizeof(green));
    delay_ms(delay_millis);
    ws2812_show_gpio(gpio_hal,ws_2812_pin, black, sizeof(black));
    delay_ms(delay_millis);
  }
}

static void rainbow(gpio_hal_context_t *gpio_hal,int count) {
  for (int i = 0; i < count; i++) {
    uint8_t rgb[3] = {hueval(i), hueval(i + 512), hueval(i + 1024)};
    ws2812_show_gpio(gpio_hal,ws_2812_pin, rgb, sizeof(rgb));
    delay_ms(2);
  }
}

void wdt_disable_all(wdt_hal_all_context_t *wdt_all){
  wdt_hal_init(&wdt_all->rwdt_0,WDT_RWDT,0,false);
  wdt_hal_init(&wdt_all->mwdt_0,WDT_MWDT0,0,false);
  wdt_hal_init(&wdt_all->mwdt_1,WDT_MWDT1,0,false);

  wdt_hal_write_protect_disable(&wdt_all->rwdt_0);
  wdt_all->rwdt_0.rwdt_dev->wdt_config0.val=0;
  wdt_all->rwdt_0.rwdt_dev->swd_wprotect=RTC_CNTL_SWD_WKEY_VALUE;
  wdt_all->rwdt_0.rwdt_dev->swd_conf.swd_disable=1;
}


void soc_init2(void){
  system_dev_t *sys_dev=&SYSTEM;
  sys_dev->cpu_per_conf.reg_cpuperiod_sel=1;
  sys_dev->cpu_per_conf.reg_cpu_wait_mode_force_on=1;
  sys_dev->cpu_per_conf.reg_cpu_waiti_delay_num=0xF;
  sys_dev->cpu_per_conf.reg_pll_freq_sel=1;

  sys_dev->sysclk_conf.reg_soc_clk_sel=SOC_CPU_CLK_SRC_PLL;
  sys_dev->sysclk_conf.reg_clk_div_en=1;
  sys_dev->sysclk_conf.reg_pre_div_cnt=0;
}

int main(void) {
  int initialized = 0;
  //soc_init();
  soc_init2();
  //wdt_disable();
  /*WDT disable*/ 
  wdt_hal_all_context_t wdt_all;
  wdt_disable_all(&wdt_all);

  /* GPIO configuration*/
  volatile gpio_hal_context_t *gpio=&gpio_hal;
  gpio_hal_input_disable(gpio,GPIO_NUM_8);
  gpio_hal_output_enable(gpio,GPIO_NUM_8);
  
  

  for (;;) {
    printf("Blinking and rainbow...%d\n",initialized++);
    blink(gpio,3, 100);
    rainbow(gpio,2000);
    blink(gpio,3, 300);
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