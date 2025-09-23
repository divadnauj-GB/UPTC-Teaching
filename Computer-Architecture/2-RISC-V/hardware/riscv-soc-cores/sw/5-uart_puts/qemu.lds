OUTPUT_ARCH( "riscv" )
ENTRY( _start )

MIN_STACK_SIZE	= 0x800;

MEMORY
{
    sram (rwx): ORIGIN = 0x80000000, LENGTH = 0x80000
    sdram (rwx): ORIGIN = 0x80000000, LENGTH = 0x800000
    peripherals (rw): ORIGIN = 0x90000000, LENGTH = 0x8000000
}

SECTIONS
{
.text :
    {
    KEEP(*(.text.init));
    *(.text.trap_vec); 
    *(.text.reset); 
    *(.text)
    } > sram

.data : ALIGN(4) {
        _data_start = .;
        __DATA_BEGIN__ = .;
        *(.data .data.*);
    } > sram
    .sdata :
    {
        __SDATA_BEGIN__ = .;
        *(.sdata .sdata.* .gnu.linkonce.s.*)
    } > sram
    __bss_start = .;
    .sbss           :
    {
        *(.dynsbss)
        *(.sbss .sbss.* .gnu.linkonce.sb.*)
        *(.scommon)
    } > sram
    .bss : ALIGN(4) {
        *(.dynbss)
        *(.bss .bss.* .gnu.linkonce.b.*)
        *(COMMON)
    } > sram
    . = ALIGN(4);
    __BSS_END__ = .;
    __global_pointer$ = MIN(__SDATA_BEGIN__ + 0x800,
                            MAX(__DATA_BEGIN__ + 0x800, __BSS_END__ - 0x800));
    _end = .; PROVIDE (end = .);

    /* Stack */
    .stack :
    {
        . = ALIGN(4);
        __stack_bottom = .;
        __stack_top = ORIGIN(sram) +  LENGTH(sram);
        __stack_size_min = MIN_STACK_SIZE;
        ASSERT(__stack_bottom + __stack_size_min < __stack_top, "Error: no space for stack");
    } > sram

}
_nmon_outs = 0x00000148;
debug_ll_getc = 0x0000014C;
PROVIDE ( risc_v_trap_handler = 0x40000010 );
