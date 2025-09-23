#ifndef __SOC_UART__
#define __SOC_UART__

#include "nanorv32.h"

#define UART_CLK	(CPU_CLK_FREQ / 16)


typedef volatile struct soc_uart_dev_s
{
    union
    {
        uint8_t R_uart_RBR;
        uint8_t W_uart_THR;
        uint8_t RW_uart_DLL;
    } uart_reg0;
    union 
    {
       struct 
       {
            uint8_t RDAvail       :1;
            uint8_t THRempty      :1;
            uint8_t RLSatusInt    :1;
            uint8_t MStatInt      :1;
            uint8_t reserved47    :4;
       }RW_uart_IER_bits; 
       uint8_t RW_uart_IER;
       uint8_t RW_uart_DLH;
    } uart_reg1;
    union 
    {
        struct
        {
            uint8_t IP            :1;
            uint8_t Priority      :3;
            uint8_t Reserved47    :4;
        }R_uart_IIR_bits;
       uint8_t R_uart_IIR;
       struct
        {
            uint8_t en           :1;
            uint8_t clear_R      :1;
            uint8_t clear_T      :1;
            uint8_t reserved35   :3;
            uint8_t IntLevel     :2;
        }W_uart_FCR_bits;
       uint8_t W_uart_FCR;
    } uart_reg2;
    union 
    {
       struct 
       {
            uint8_t N           :2;
            uint8_t S           :1;
            uint8_t PE          :1;
            uint8_t PS          :1;
            uint8_t SP          :1;
            uint8_t BC          :1;
            uint8_t DLA         :1;
       }RW_uart_LCR_bits;
       uint8_t RW_uart_LCR;
    } uart_reg3;
    union 
    {
       struct 
       {
        uint8_t DTR           :1;
        uint8_t RTS           :1;
        uint8_t RI            :1;
        uint8_t DCD           :1;
        uint8_t loopback      :1;
        uint8_t reserved57    :3;
       }W_uart_MCR_bits;
       uint8_t W_uart_MCR;
    } uart_reg4;
    union 
    {
       struct 
       {
            uint8_t DR           :1;
            uint8_t OE           :1;
            uint8_t PE           :1;
            uint8_t FE           :1;
            uint8_t BI           :1;
            uint8_t TF           :1;
            uint8_t TE           :1;
            uint8_t P            :1;
       }R_uart_LSR_bits;
       uint8_t R_uart_LSR;
    } uart_reg5;
    union 
    {
       struct 
       {
            uint8_t DCTS       :1;
            uint8_t DDSR       :1;
            uint8_t TERI       :1;
            uint8_t DDCD       :1;
            uint8_t CTS        :1;
            uint8_t DSR        :1;
            uint8_t RI         :1;
            uint8_t DCD        :1;
       }R_uart_MSR_bits;
       uint8_t R_uart_MSR;
    } uart_reg6;
}soc_uart_dev_t;

extern volatile soc_uart_dev_t *UART0_DEV;

void uart_init( uint32_t baudrate);
void uart_putc( char c);
char uart_getc(void);
int uart_tstc(void);
void uart_puts(const char *s);

#endif