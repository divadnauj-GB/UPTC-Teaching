


CC =  riscv64-unknown-elf-gcc
CFLAGS = -Wall -Wextra -Werror -std=c11 -ffreestanding
OBJCOPY =  riscv64-unknown-elf-objcopy
OBJDUMP =  riscv64-unknown-elf-objdump
ARCH =  -march=rv32imc -mabi=ilp32

ifeq ($(DBG),1)	
	QEMU = qemu-system-riscv32 -machine virt -bios default -nographic --no-reboot -S -s
else
	QEMU = qemu-system-riscv32 -machine virt -bios default -nographic --no-reboot
endif

LINKERSCRIPT = riscv-qemu.ld


build: myos.elf 

myos.elf: crt0.S 
	$(CC) $(ARCH) -T$(LINKERSCRIPT) -g -Og -ffreestanding -O2 -nostdlib -lgcc -Wl,--no-relax $^ -o $@ 

qemu: myos.elf
	$(QEMU) -kernel myos.elf 

gdb: myos.elf
	riscv64-elf-gdb myos.elf -ex "target remote :1234" -ex "tb _start" -ex "tb clear_bss" -ex "c"

clean:
	rm -f *.o *.elf *.img