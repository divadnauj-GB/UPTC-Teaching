#ifndef __UART_H__
#define __UART_H__

#define CONFIG_DEBUG_LL
#define DEBUG_LL_UART_ADDR	0x90000000
#define DEBUG_LL_UART_SHIFT	2
#define DEBUG_LL_UART_IOSIZE32

#define DEBUG_LL_UART_CLK	(24000000 / 16)
#define DEBUG_LL_UART_BPS	115200
#define DEBUG_LL_UART_DIVISOR	(DEBUG_LL_UART_CLK / DEBUG_LL_UART_BPS)

#define UART_THR	(0x0 << DEBUG_LL_UART_SHIFT)
#define UART_RBR	(0x0 << DEBUG_LL_UART_SHIFT)
#define UART_DLL	(0x0 << DEBUG_LL_UART_SHIFT)
#define UART_DLM	(0x1 << DEBUG_LL_UART_SHIFT)
#define UART_LCR	(0x3 << DEBUG_LL_UART_SHIFT)
#define UART_LSR	(0x5 << DEBUG_LL_UART_SHIFT)

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