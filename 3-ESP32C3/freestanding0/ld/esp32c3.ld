MEMORY {
  iache  (rwx)  : ORIGIN = 0X4037c000, LENGTH = 16k
  iram   (rwx)  : ORIGIN = 0x40380400, LENGTH = 32k 
  dram   (rw)   : ORIGIN = 0x3fc80000 + LENGTH(iram), LENGTH = 128k
}

_eram = ORIGIN(dram) + LENGTH(dram);
ENTRY(call_start_cpu0)

SECTIONS {
  .text     : { *(.text) *(.text*) } > iram

  .data : {
    . = ALIGN(16);
    _sdata = .;
    *(.data)
    *(.data*)
    *(.sdata)
    *(.sdata*)
    *(.srodata)
    *(.srodata*)
    *(.rodata)
    *(.rodata*)
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    *(.riscv.*)
    . = ALIGN(16);
    _edata = .;
  } > dram

  .bss (NOLOAD): {
    . = ALIGN(16);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(.sbss)
    *(.sbss*)
    *(COMMON)
    . = ALIGN(16);
    _ebss = .;
  } > dram

  . = ALIGN(16);
  PROVIDE(end = .);
  PROVIDE(_end = .);

  /* Stack */
  .stack :
  {
    __stack_bottom = .;
    __stack_top = ORIGIN(dram) +  LENGTH(dram);
    __stack_size_min = 0x4000;
    ASSERT(__stack_bottom + __stack_size_min < __stack_top, "Error: no space for stack");
  }
}




/* Functions */
__absvdi2 = 0x40000764;
__absvsi2 = 0x40000768;
__adddf3 = 0x4000076c;
__addsf3 = 0x40000770;
__addvdi3 = 0x40000774;
__addvsi3 = 0x40000778;
__ashldi3 = 0x4000077c;
__ashrdi3 = 0x40000780;
__bswapdi2 = 0x40000784;
__bswapsi2 = 0x40000788;
__clear_cache = 0x4000078c;
__clrsbdi2 = 0x40000790;
__clrsbsi2 = 0x40000794;
__clzdi2 = 0x40000798;
__clzsi2 = 0x4000079c;
__cmpdi2 = 0x400007a0;
__ctzdi2 = 0x400007a4;
__ctzsi2 = 0x400007a8;
__divdc3 = 0x400007ac;
__divdf3 = 0x400007b0;
__divdi3 = 0x400007b4;
__divsc3 = 0x400007b8;
__divsf3 = 0x400007bc;
__divsi3 = 0x400007c0;
__eqdf2 = 0x400007c4;
__eqsf2 = 0x400007c8;
__extendsfdf2 = 0x400007cc;
__ffsdi2 = 0x400007d0;
__ffssi2 = 0x400007d4;
__fixdfdi = 0x400007d8;
__fixdfsi = 0x400007dc;
__fixsfdi = 0x400007e0;
__fixsfsi = 0x400007e4;
__fixunsdfsi = 0x400007e8;
__fixunssfdi = 0x400007ec;
__fixunssfsi = 0x400007f0;
__floatdidf = 0x400007f4;
__floatdisf = 0x400007f8;
__floatsidf = 0x400007fc;
__floatsisf = 0x40000800;
__floatundidf = 0x40000804;
__floatundisf = 0x40000808;
__floatunsidf = 0x4000080c;
__floatunsisf = 0x40000810;
__gcc_bcmp = 0x40000814;
__gedf2 = 0x40000818;
__gesf2 = 0x4000081c;
__gtdf2 = 0x40000820;
__gtsf2 = 0x40000824;
__ledf2 = 0x40000828;
__lesf2 = 0x4000082c;
__lshrdi3 = 0x40000830;
__ltdf2 = 0x40000834;
__ltsf2 = 0x40000838;
__moddi3 = 0x4000083c;
__modsi3 = 0x40000840;
__muldc3 = 0x40000844;
__muldf3 = 0x40000848;
__muldi3 = 0x4000084c;
__mulsc3 = 0x40000850;
__mulsf3 = 0x40000854;
__mulsi3 = 0x40000858;
__mulvdi3 = 0x4000085c;
__mulvsi3 = 0x40000860;
__nedf2 = 0x40000864;
__negdf2 = 0x40000868;
__negdi2 = 0x4000086c;
__negsf2 = 0x40000870;
__negvdi2 = 0x40000874;
__negvsi2 = 0x40000878;
__nesf2 = 0x4000087c;
__paritysi2 = 0x40000880;
__popcountdi2 = 0x40000884;
__popcountsi2 = 0x40000888;
__powidf2 = 0x4000088c;
__powisf2 = 0x40000890;
__subdf3 = 0x40000894;
__subsf3 = 0x40000898;
__subvdi3 = 0x4000089c;
__subvsi3 = 0x400008a0;
__truncdfsf2 = 0x400008a4;
__ucmpdi2 = 0x400008a8;
__udivdi3 = 0x400008ac;
__udivmoddi4 = 0x400008b0;
__udivsi3 = 0x400008b4;
__udiv_w_sdiv = 0x400008b8;
__umoddi3 = 0x400008bc;
__umodsi3 = 0x400008c0;
__unorddf2 = 0x400008c4;
__unordsf2 = 0x400008c8;


/***************************************
 Group newlib
 ***************************************/

/* Functions */
memset = 0x40000354;
memcpy = 0x40000358;
memmove = 0x4000035c;
memcmp = 0x40000360;
strcpy = 0x40000364;
strncpy = 0x40000368;
strcmp = 0x4000036c;
strncmp = 0x40000370;
strlen = 0x40000374;
strstr = 0x40000378;
bzero = 0x4000037c;
isalnum = 0x40000388;
isalpha = 0x4000038c;
isascii = 0x40000390;
isblank = 0x40000394;
iscntrl = 0x40000398;
isdigit = 0x4000039c;
islower = 0x400003a0;
isgraph = 0x400003a4;
isprint = 0x400003a8;
ispunct = 0x400003ac;
isspace = 0x400003b0;
isupper = 0x400003b4;
toupper = 0x400003b8;
tolower = 0x400003bc;
toascii = 0x400003c0;
memccpy = 0x400003c4;
memchr = 0x400003c8;
memrchr = 0x400003cc;
strcasecmp = 0x400003d0;
strcasestr = 0x400003d4;
strcat = 0x400003d8;
strdup = 0x400003dc;
strchr = 0x400003e0;
strcspn = 0x400003e4;
strcoll = 0x400003e8;
strlcat = 0x400003ec;
strlcpy = 0x400003f0;
strlwr = 0x400003f4;
strncasecmp = 0x400003f8;
strncat = 0x400003fc;
strndup = 0x40000400;
strnlen = 0x40000404;
strrchr = 0x40000408;
strsep = 0x4000040c;
strspn = 0x40000410;
strtok_r = 0x40000414;
strupr = 0x40000418;
longjmp = 0x4000041c;
setjmp = 0x40000420;
abs = 0x40000424;
div = 0x40000428;
labs = 0x4000042c;
ldiv = 0x40000430;
qsort = 0x40000434;
rand_r = 0x40000438;
rand = 0x4000043c;
srand = 0x40000440;
utoa = 0x40000444;
itoa = 0x40000448;
atoi = 0x4000044c;
atol = 0x40000450;
strtol = 0x40000454;
strtoul = 0x40000458;
printf = 0x40000040;

uart_tx_one_char = 0x40000068;

uart_tx_one_char = 0x40000068;
uart_tx_one_char2 = 0x4000006c;
uart_rx_one_char = 0x40000070;
uart_rx_one_char_block = 0x40000074;
uart_rx_readbuff = 0x40000078;

PROVIDE ( UART0 = 0x60000000 );
PROVIDE ( UART1 = 0x60010000 );
PROVIDE ( SPIMEM1 = 0x60002000 );
PROVIDE ( SPIMEM0 = 0x60003000 );
PROVIDE ( GPIO = 0x60004000 );
PROVIDE ( SDM = 0x60004f00 );
PROVIDE ( RTCCNTL = 0x60008000 );
PROVIDE ( RTCIO = 0x60008400 );
PROVIDE ( EFUSE = 0x60008800 );
PROVIDE ( HINF = 0x6000B000 );
PROVIDE ( I2S0  = 0x6002d000 );
PROVIDE ( I2C0  = 0x60013000 );
PROVIDE ( UHCI0  = 0x60014000 );
PROVIDE ( HOST = 0x60015000 );
PROVIDE ( RMT = 0x60016000 );
PROVIDE ( RMTMEM = 0x60016400 );
PROVIDE ( SLC = 0x60018000 );
PROVIDE ( LEDC = 0x60019000 );
PROVIDE ( TIMERG0 = 0x6001F000 );
PROVIDE ( TIMERG1 = 0x60020000 );
PROVIDE ( SYSTIMER = 0x60023000 );
PROVIDE ( GPSPI2  = 0x60024000 );
PROVIDE ( SYSCON = 0x60026000 );
PROVIDE ( TWAI   = 0x6002B000 );
PROVIDE ( APB_SARADC = 0x60040000 );
PROVIDE ( USB_SERIAL_JTAG = 0x60043000 );
PROVIDE ( GDMA    = 0x6003F000 );
PROVIDE ( SYSTEM = 0x600c0000 );



