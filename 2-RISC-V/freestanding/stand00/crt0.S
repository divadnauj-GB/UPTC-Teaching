  .text
  .global _start			// void _start() { ... }
  .type   _start, @function

_start:

	# Initialize global pointer
.option push
.option norelax
setgp:	
	auipc gp,%pcrel_hi(__global_pointer$)
	addi  gp,gp, %pcrel_lo(setgp)
.option pop

	# Clear the bss segment (starting at __bss_start and ending at __BSS_END__-1)

	// a0 = __bss_start
	lui		a0,%hi(__bss)
	addi	a0,a0,%lo(__bss)

	// a1 = _end
	lui		a1,%hi(__bss_end)
	addi	a1,a1,%lo(__bss_end)

clear_bss:
    bgeu    a0,a1,done_bss      # while (!(a0 >= a1)) {
    sb      x0,0(a0)            #   *a0 = 0;
    addi    a0,a0,1             #   ++a0
    beq     x0,x0,clear_bss		# }
done_bss:   

loop: j loop

	.size  _start, .-_start


print:
	li a7, 0x4442434E
	li a6, 0x00
	li a0, 12
	la a1, debug_string
	li a2, 0
	ecall
	

.section .rodata
debug_string:
    .string "Hello world\n"