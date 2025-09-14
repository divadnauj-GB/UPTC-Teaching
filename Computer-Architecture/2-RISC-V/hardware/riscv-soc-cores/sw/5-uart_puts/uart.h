#ifndef __UART_H__
#define __UART_H__

#define CONFIG_DEBUG_LL
#ifdef QEMU
    #define DEBUG_LL_UART_ADDR	0x10000000
    #define TICKS_PER_SECOND 0x989680ull
#else
    #define DEBUG_LL_UART_ADDR	0x90000000
    #define TICKS_PER_SECOND 24000000 
#endif

#define DEBUG_LL_UART_CLK	(TICKS_PER_SECOND / 16)
#define DEBUG_LL_UART_BPS	115200
#define DEBUG_LL_UART_DIVISOR	(DEBUG_LL_UART_CLK / DEBUG_LL_UART_BPS)

#define UART_THR	( 0x0 )
#define UART_RBR	( 0x0 )
#define UART_DLL	( 0x0 )
#define UART_DLM	( 0x1 )
#define UART_LCR	( 0x3 )
#define UART_LSR	( 0x5 )

#define UART_LCR_W	0x07	/* Set UART to 8,N,2 & DLAB = 0 */
#define UART_LCR_DLAB	0x87	/* Set UART to 8,N,2 & DLAB = 1 */

#define UART_LSR_DR	0x01    /* UART received data present */
#define UART_LSR_THRE	0x20	/* Xmit holding register empty */



void uart_init(void);
void uart_putc(char c);
char uart_getc(void);
int uart_tstc(void);
void uart_puts(const char *s);



#endif // __UART_H__