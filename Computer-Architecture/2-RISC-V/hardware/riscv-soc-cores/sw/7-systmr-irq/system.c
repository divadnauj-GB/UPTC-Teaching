#include "nanorv32.h"
#include "system.h"
#include <stdint.h>
#include <stdio.h>
#include "uart.h"

void mtime_updated(unsigned int us)
{
    uint64_t next_mtime;
    next_mtime = update_mtime_period(us*MTIME_TICK_PERIOD);
    update_mtimecmp(next_mtime);
}

uint64_t update_mtime_period(unsigned int time_from_now)
{
    uint32_t curr_mth=0, curr_mtl=0;
    uint64_t next_mtime=0;

    volatile uint32_t *mtime = (uint32_t *)(configMTIME_BASE_ADDRESS);
    curr_mtl = mtime[0];
    curr_mth = mtime[1];
    while (curr_mth != mtime[1]) {
        curr_mtl = mtime[0];
        curr_mth = mtime[1];
    }
 
    next_mtime = ((uint64_t)(curr_mth&0xffffffff));
    next_mtime <<= 32;
    next_mtime |= (uint64_t)(curr_mtl&0xffffffff);
    next_mtime += (uint64_t)time_from_now;

    return next_mtime;
}

void update_mtimecmp(uint64_t next_mtime)
{
    uint32_t dummy=0xffffffff;
    volatile uint32_t *mtimecmp = (uint32_t *)(configMTIMECMP_BASE_ADDRESS);
    mtimecmp[0] = dummy;
    mtimecmp[1] = (uint32_t)(next_mtime >> 32);
    mtimecmp[0] = (uint32_t)(next_mtime & 0xFFFFFFFF);
}