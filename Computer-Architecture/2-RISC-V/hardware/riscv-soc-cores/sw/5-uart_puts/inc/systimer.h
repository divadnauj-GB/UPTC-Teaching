#ifndef __SYSTIMER_H__
#define __SYSTIMER_H__
#include <stdint.h>
#include "nanorv32.h"


#define MTIME_TICK_PERIOD (CPU_CLK_FREQ / US_PER_SECOND)

typedef volatile struct systimer_dev_s
{
    uint32_t mtimel;
    uint32_t mtimeh;
    uint32_t mtimecmpl;
    uint32_t mtimecmph;
}systimer_dev_t;

extern volatile systimer_dev_t *SYSTMR_DEV;


void mtime_updated(unsigned int time_from_now);
void update_mtimecmp(uint64_t next_mtime);
uint64_t update_mtime_period(unsigned int time_from_now);

#endif /*__SYSTIMER_H__*/