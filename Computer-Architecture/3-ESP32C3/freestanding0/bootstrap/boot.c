// Copyright (c) 2021 Cesanta
// All rights reserved

#include "system.h"

extern int main(void);
extern char _sbss, _ebss, _end, _eram, __stack_bottom[],__stack_top[];

static char *s_heap_start, *s_heap_end, *s_brk;

extern int uart_tx_one_char(uint8_t c);

ssize_t _write(int fildes, const void *buf, size_t nbyte)
{
    const uint8_t *cbuf = (const uint8_t *) buf;
    for (size_t i = 0; i < nbyte; ++i) {
        uart_tx_one_char(cbuf[i]);
    }
    return nbyte;
}

void _exit(int exit_code)
{
    while (true) {
        ;
    }
}

__attribute__((section(".text")))
__attribute__((naked))
void call_start_cpu0() {
  s_heap_start = s_brk = &_end, s_heap_end = __stack_bottom;
  for (char *p = &_sbss; p < &_ebss;) *p++ = '\0';
  __asm__ __volatile__  ("mv sp, %[stack_top]\n": :[stack_top] "r" (__stack_top));
  __asm__ __volatile__  ("call  __libc_init_array");
  soc_init();
  main();
  for (;;) (void) 0;
}
