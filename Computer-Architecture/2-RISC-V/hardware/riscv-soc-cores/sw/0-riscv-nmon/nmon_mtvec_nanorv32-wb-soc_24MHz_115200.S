/*
 * nano-monitor for RISC-V CPU
 *
 * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
 *
 * This file is part of barebox.
 * See file CREDITS for list of people who contributed to this project.
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

#define CONFIG_NMON_HELP

#define CONFIG_DEBUG_LL
#define DEBUG_LL_UART_ADDR	0x90000000
#define DEBUG_LL_UART_SHIFT	2
#define DEBUG_LL_UART_IOSIZE32

#define DEBUG_LL_UART_CLK	(24000000 / 16)
#define DEBUG_LL_UART_BPS	115200
#define DEBUG_LL_UART_DIVISOR	(DEBUG_LL_UART_CLK / DEBUG_LL_UART_BPS)

#include "debug_ll_ns16550.h"

#include "riscv_nmon.h"

	.section .text.init
	.global _start
_start:
	j reset

.section .text.trap_vec
.global trap_vec
.align 4
trap_vec:
	wfi
	j trap_vec

.section .text.reset
.global reset
reset:
	li a0, 0x00000010
	csrw mtvec, a0
	li a0,0x80
	csrrs zero, mie, a0
	li a0,0x8
	csrrs zero, mstatus, a0

	debug_ll_ns16550_init

	riscv_nmon

	j	_start

