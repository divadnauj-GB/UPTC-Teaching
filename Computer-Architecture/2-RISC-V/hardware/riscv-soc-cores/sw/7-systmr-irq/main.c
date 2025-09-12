#include "system.h"
#include "riscv-csr.h"
#include "uart.h"
#include <stdint.h>
#include <stdio.h>


volatile char timer_flag = 0;
char msg[256] = "";
const char values[50] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                    13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
                    23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 
                    33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
                    43, 44, 45, 46, 47, 48, 49};


void  __attribute__((interrupt ("machine") ))  risc_v_trap_handler(void) {
    PUSH_CUSTOM_TRAP_REGS;
    uint32_t mcause = csr_read_mcause();
    if ((mcause & 0x80000000) && ((mcause & 0xff) == 7)) {
        // Machine timer interrupt
        timer_flag = 1;
        mtime_updated(100*MTIME_TICK_PERIOD); // Set timer interrupt period
        csr_clr_bits_mip(MIP_MTI_BIT_MASK); // Clear the machine timer interrupt pending bit
        
    } else {
        // Unexpected trap, just hang here
        sprintf(msg, "Unexpected trap: mcause=0x%08x\n", mcause);
        uart_puts(msg);
        while (1);
    }
    POP_CUSTOM_TRAP_REGS;
}


void main(void) {
    volatile uint32_t *gpio = (uint32_t *)GPIO;
    uint32_t sw_value = 0, curr_sw=0, old_sw=0;
    int counter = 0, idx=0;   
    char str[100];
    uart_init();
    csr_write_mtvec((uint32_t )risc_v_trap_handler);
    csr_set_bits_mie(MIE_MTI_BIT_MASK);
    mtime_updated(100*MTIME_TICK_PERIOD); // Set timer interrupt period
    csr_clr_bits_mip(MIP_MTI_BIT_MASK); // Clear the machine timer interrupt pending bit
    csr_set_bits_mstatus(MSTATUS_MIE_BIT_MASK);
    //CSR_SET_BITS_IMM_MSTATUS(MSTATUS_MIE_BIT_MASK);
    // Enable machine timer interrupt in mie
    sw_value = *gpio; 
    *gpio = sw_value;     
    uart_puts("Tick...\n");
    while (1)
    {
        curr_sw = *gpio;
        if (curr_sw!=old_sw)
        {
            old_sw=curr_sw;
            sw_value=curr_sw;
        }
        if (timer_flag) {
            timer_flag = 0;
            counter++;
            if (counter >= 50) { // Approximately every second
                counter = 0;
                sw_value = ~(sw_value)&0xFF; // Read the state of the 4 switches
                *gpio = sw_value & 0xFF; // Output to the 4 LEDs
                sprintf(msg,"Tick...%d\n",values[idx]);
                uart_puts(msg);
                idx++;
                if(idx==50){
                    idx=0;
                }
            }
        }
    }
    
}