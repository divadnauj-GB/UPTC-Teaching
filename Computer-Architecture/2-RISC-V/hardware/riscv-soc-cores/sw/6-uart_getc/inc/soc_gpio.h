#ifndef __SOC_GPIO_H__
#define __SOC_GPIO_H__

#include "nanorv32.h"

typedef volatile struct soc_gpio_dev_s
{
    union {
        struct {
            uint32_t in0 : 1;
            uint32_t in1 : 1;
            uint32_t in2 : 1;
            uint32_t in3 : 1;
            uint32_t in4 : 1;
            uint32_t in5 : 1;
            uint32_t in6 : 1;
            uint32_t in7 : 1;
            uint32_t reserved24 : 24;
            } input_bits;
        uint32_t input;
        struct {
            uint32_t out0 : 1;
            uint32_t out1 : 1;
            uint32_t out2 : 1;
            uint32_t out3 : 1;
            uint32_t out4 : 1;
            uint32_t out5 : 1;
            uint32_t out6 : 1;
            uint32_t out7 : 1;
            uint32_t reserved24 : 24;
            } output_bits;
        uint32_t output;
    }gpio;
    uint32_t gpio_dir;
}soc_gpio_dev_t;
extern volatile soc_gpio_dev_t *GPIO0_DEV;

void gpio_init(void);
uint32_t gpio_read_port(void);
void gpio_write_port(uint32_t val);
uint32_t gpio_read_port_pin(uint32_t pin);
void gpio_write_port_pin(uint32_t pin, uint32_t val);



#endif /*__SOC_GPIO_H__*/