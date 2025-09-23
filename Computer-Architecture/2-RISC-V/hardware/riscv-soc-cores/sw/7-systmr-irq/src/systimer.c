#include "systimer.h"

extern volatile systimer_dev_t *SYSTMR_DEV=(systimer_dev_t * )MTIME_BASE_ADDRESS;


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

    curr_mtl = SYSTMR_DEV->mtimel;
    curr_mth = SYSTMR_DEV->mtimeh;
    while (curr_mth != SYSTMR_DEV->mtimeh) {
        curr_mtl = SYSTMR_DEV->mtimel;
        curr_mth = SYSTMR_DEV->mtimeh;
    }
 
    next_mtime = ((uint64_t)(curr_mth&0xffffffff));
    next_mtime <<= 32;
    next_mtime |= (uint64_t)(curr_mtl&0xffffffff);
    next_mtime += (uint64_t)time_from_now;

    return next_mtime;
}

void update_mtimecmp( uint64_t next_mtime)
{
    uint32_t dummy=0xffffffff;
    SYSTMR_DEV->mtimecmpl = dummy;
    SYSTMR_DEV->mtimecmph = (uint32_t)(next_mtime >> 32);
    SYSTMR_DEV->mtimecmpl = (uint32_t)(next_mtime & 0xFFFFFFFF);
}