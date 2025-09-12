nmon RISC-V nano-monitor
========================

nmon is a tiny monitor (<1 KiB) program for the RISC-V processors.

It can operate with NO working RAM at all!

It uses only the processor registers and NS16550-compatible
UART port for operation, so it can be used for a memory
controller setup code debugging.

nmon is based on MIPS nmon from barebox bootloader (http://www.barebox.org).

nmon has only 4 commands:

    q - quit
    d <addr> - read 32-bit word from <addr> address
    w <addr> <val> - write 32-bit word <val> to <addr>
    g <addr> - jump to <addr>

Address and data values must be given in hexadecimal.
Everything (including hex digits 'a'..'f') must
be in lower case.

EXAMPLE: change value of the 32-bit word at address ``0xa0000000``

    nmon> d a0000000
    00000000
    nmon> w a0000000 12345678
    nmon> d a0000000
    12345678
    nmon>

There is no error checking of any kind. If you
give an invalid address you will probably get
an exception which will hang the board and you
will have to press the reset button.

You can interrupt current command (e.g. you have
made error in input ``<addr>`` value) by pressing
the ``<ESC>`` key.
