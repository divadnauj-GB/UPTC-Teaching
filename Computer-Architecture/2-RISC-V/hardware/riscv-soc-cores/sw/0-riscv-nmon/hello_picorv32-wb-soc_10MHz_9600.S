/*
 * 'Hello, World!' for picorv32-wb-soc
 *
 * Copyright (C) 2017 Antony Pavlov <antonynpavlov@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 */

#define DEBUG_LL_UART_ADDR	0x90000000
#define DEBUG_LL_UART_SHIFT	2

#define UART_REG_L	lw
#define UART_REG_S	sw

#define UART_THR	(0x0 << DEBUG_LL_UART_SHIFT)
#define UART_LSR	(0x5 << DEBUG_LL_UART_SHIFT)
#define UART_LSR_THRE	0x20	/* Xmit holding register empty */

	.text
	.align 2
	.globl _start

_start:

	la	a1, hello

	li	t0, DEBUG_LL_UART_ADDR
_nmon_outs:

	lb	a0, 0(a1)
	addi	a1, a1, 1
	beqz	a0, _end

201:
	UART_REG_L	t1, UART_LSR(t0)	/* get line status */
	andi	t1, t1, UART_LSR_THRE	/* check for transmitter empty */
	beqz	t1, 201b			/* try again */

	UART_REG_S	a0, UART_THR(t0)	/* write the character */

	j	_nmon_outs

_end:
	j	_end

hello:
	.asciz "\r\nHello, World!\r\n"
