# Baremetal examples

### These exercises were adapted to work with RISC-V QEMO, the original exercises were taken from the repository https://github.com/johnwinans/rvddt/tree/master of John Winans

These illustrate an approach to initializing an address space suitable
for running a C program that uses newlib.

*** freestanding example apps:

stand00:
	long-form %pcrel() assembler macros

stand01:
	use pseudo-ops to implement crt0.S in an understandable manner

stand02:
	- add some variables to the data and bss regions
	- now there is somehting to zero-out
	- note that the text region now is zero-padded in order to be able to initialize the page-aligned data region
	- see the bss region get zeroed out this time

stand03:
	call main  -->  main() { return 0x8675309 }

	- the "call main" pseudo-operation is same as:
		cm1:    auipc   x1,%pcrel_hi(main)
		        jalr    x1,%pcrel_lo(callmain)(cm1)

	- how does 'call' know to use x1 as the return address register?????? 
		Because the ABI says so!

stand04:
	call main() and set the value of a variable in the BSS

stand05:
	call main() and set the values from variables in the DATA and BSS regions.

stand06:
	Create a char array in main() that is not used.  Even with an initializer it is optimized away!

stand07: (error)
	Create char array in main() and then use it.
	This examle fails due to missing memset()!!

stand08:
	Add -lgcc and -lc libraries.

stand09: (error)
	Add a call to malloc() that fails because there is no sbrk()

stand10: (note that the text region is too big to hardcode the data to start at 0x1000)
	Add stubs for the newlib's stdlib dependancies in stub_stdlib.c
	Demonstrate that malloc() is working properly.


Conclusion: 

We can now execute single-threaded C programs that can use functions from the
standard library.  There are no provisions, however, for things like I/O.




*** Related issues:

- use ABI names since x-this and x-that make thinking about arg-1 and arg-2 of a
	C func calls easier.  Show reg table from RVALP here.

- auipc + addi = how we put the address of some label into a register.
	This method is optimized to eliminate accessing memory (where we could just store a pointer).
	There is an 'la' pseudo-instruction:
				la		a1,target
 	... that tells the assembler to do this:
		la1:    auipc   a1,%pcrel_hi(target)
				addi    a1,a1,%pcrel_lo(la1)

	- pcrel_hi(label) represents an immediate-value suitable for auipc based on the label.
		This immediate will be the distance from the PC to the label!!
    - pcrel_lo(hi_label) is used to calc the right imm value for an addi insn matched to an auipc!

- lui + addi = how we put an absolute value into a register
	There is an 'li' pseudo-instruction that can load any value into a register:
		li      a1,0x12345678

	The li pseudo-operation on an RV32I will expand into this:
		lui		a1,%hi(0x12345678)
		addi    a1,a1,%lo(0x12345678)

	On RV32 the assembler will only need to use either an addi or a lui and addi.
	Note that 'li' works on RV64 and RV128 machines too.  To accomplish the loading
	the assembler will use a series of instructions like lui, addi, and shift.


