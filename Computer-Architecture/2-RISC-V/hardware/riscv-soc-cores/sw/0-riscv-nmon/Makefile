PROJECT = nmon_nanorv32-wb-soc_24MHz_115200

CROSS_COMPILE=riscv64-unknown-elf-

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
NM=$(CROSS_COMPILE)nm
SIZE=$(CROSS_COMPILE)size

ARCH=-march=rv32im_zicsr -mabi=ilp32
LINKERSCRIPT=riscv_nmon.lds
CFLAGS+=$(ARCH) -Wall -Wextra  -std=c11 -ffreestanding

CFLAGS+=-g 
CFLAGS+=-fno-pic --specs=nano.specs --specs=nosys.specs
CFLAGS+=$(ARCH)

LDFLAGS +=-T$(LINKERSCRIPT) 
LDFLAGS +=-nostdlib 
LDFLAGS +=-Wl,--no-relax 

LDLIBS = -lc -lgcc

C_SRC = $(wildcard *.c)
ASM_SRC = $(wildcard *.S)
# Convert the list of .c files into a list of .o object files
OBJS = $(patsubst %.c, %.o, $(C_SRC))
OBJS += $(patsubst %.S, %.o, $(ASM_SRC))

build: $(PROJECT).elf $(PROJECT).txt



%.o: %.S
	$(CC) $(CFLAGS) -c $^ -o $@ 
	
%.o: %.c 
	$(CC) $(CFLAGS)  -c $< -o $@ 

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

$(PROJECT).elf: $(PROJECT).o
	$(CC) $(CFLAGS) $(LDFLAGS) $(PROJECT).o $(LDLIBS) -o $@ 
	$(SIZE) -A -x $@

START_ADDR:=80000000
%.txt: %.bin
	hexdump -v -e '/4 "%08x\n"' $< > $@
	@xxd -e -c 4 -o 0x$(START_ADDR) -g 4 $< | awk '{gsub(":", "", $$1); print ""$$1$$2""}'  > .tmp ;




clean:
	rm -f *.o *.elf *.img *.bin *.nmon symbols.txt .tmp *.txt
