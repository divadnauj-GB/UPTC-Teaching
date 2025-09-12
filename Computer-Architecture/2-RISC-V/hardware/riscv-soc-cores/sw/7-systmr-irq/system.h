#ifndef _SYSTEM_H
#define _SYSTEM_H

#include "nanorv32.h"
#include <stdint.h>


void risc_v_trap_handler(void) __attribute__((interrupt));

void mtime_updated(unsigned int time_from_now);
void update_mtimecmp(uint64_t next_mtime);
uint64_t update_mtime_period(unsigned int time_from_now);


#endif // _SYSTEM_H