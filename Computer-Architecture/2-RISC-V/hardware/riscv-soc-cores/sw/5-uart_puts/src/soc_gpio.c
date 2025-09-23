#include "soc_gpio.h"

extern volatile soc_gpio_dev_t *GPIO0_DEV=(soc_gpio_dev_t*)(GPIO_BASE);


void gpio_init(void){
    GPIO0_DEV->gpio_dir=0xffffffff;
}

uint32_t gpio_read_port(void){
    return(GPIO0_DEV->gpio.input);
}

void gpio_write_port(uint32_t val){
    GPIO0_DEV->gpio.output=val;
}

uint32_t gpio_read_port_pin( uint32_t pin){
    switch (pin)
    {
    case 0:
        return(GPIO0_DEV->gpio.input_bits.in0);
        break;
    case 1:
        return(GPIO0_DEV->gpio.input_bits.in1);
        break;
    case 2:
        return(GPIO0_DEV->gpio.input_bits.in2);
        break;
    case 3:
        return(GPIO0_DEV->gpio.input_bits.in3);
        break;
    case 4:
        return(GPIO0_DEV->gpio.input_bits.in4);
        break;
    case 5:
        return(GPIO0_DEV->gpio.input_bits.in5);
        break;
    case 6:
        return(GPIO0_DEV->gpio.input_bits.in6);
        break;
    case 7:
        return(GPIO0_DEV->gpio.input_bits.in7);
        break;
    default:
        return(0);
        break;
    }
}


void gpio_write_port_pin(uint32_t pin, uint32_t val){
    switch (pin)
    {
    case 0:
        GPIO0_DEV->gpio.output_bits.out0=val;
        break;
    case 1:
        GPIO0_DEV->gpio.output_bits.out1=val;
        break;
    case 2:
        GPIO0_DEV->gpio.output_bits.out2=val;
        break;
    case 3:
        GPIO0_DEV->gpio.output_bits.out3=val;
        break;
    case 4:
        GPIO0_DEV->gpio.output_bits.out4=val;
        break;
    case 5:
        GPIO0_DEV->gpio.output_bits.out5=val;
        break;
    case 6:
        GPIO0_DEV->gpio.output_bits.out6=val;
        break;
    case 7:
        GPIO0_DEV->gpio.output_bits.out7=val;
        break;
    default:
        break;
    }
}
