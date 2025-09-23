CROSS_COMPILE=riscv64-unknown-elf-
QEMU ?= 

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
NM=$(CROSS_COMPILE)nm
ARCH=-march=rv32i_zicsr -mabi=ilp32

CFLAGS+=$(ARCH) -Wall -Wextra  -std=c11 -ffreestanding

ifdef QEMU
	CFLAGS+=-g -DQEMU
	LINKERSCRIPT=qemu.lds 
else
	CFLAGS+=-O3
	LINKERSCRIPT=nanorv32-wb-soc.lds 
endif

CFLAGS+=-fno-pic --specs=nano.specs --specs=nosys.specs
CFLAGS+=$(ARCH)

LDFLAGS +=-T$(LINKERSCRIPT) 
LDFLAGS +=-nostdlib 
LDFLAGS +=-Wl,--no-relax 

LDLIBS = -lc -lgcc

C_SRC = $(wildcard *.c)
C_SRC += $(wildcard src/*.c)

ASM_SRC = $(wildcard *.S)
# Convert the list of .c files into a list of .o object files
OBJS = $(patsubst %.c, %.o, $(C_SRC))
OBJS += $(patsubst %.S, %.o, $(ASM_SRC))

INCLUDES=-I./inc -I./

build: application.elf 
nmon: application.nmon


%.o: %.S
	$(CC) $(CFLAGS) $(INCLUDES) -c $^ -o $@ 
	
%.o: %.c 
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ 

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

application.elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@ 
	$(CROSS_COMPILE)size -A -x $@

START_ADDR := $(shell $(NM) *.elf | awk '/ _start/ {print $$1}')

#xxd -e -c 4 -o 0x$(START_ADDR) -g 4 $< | sed "s/^/w/;s/: //;s/  .*//" > $@
application.nmon: application.bin
	@START_ADDR=$$($(NM) *.elf | awk '/ _start/ {print $$1}'); \
	echo "Start address: 0x$$START_ADDR"; \
	xxd -e -c 4 -o 0x$$START_ADDR -g 4 $< | awk '{gsub(":", "", $$1); print "send \"w"$$1$$2"\""}'  > .tmp ; \
	awk '{print "expect \"nmon> \"\n" $$0}' .tmp > $@ ; \
	echo "expect \"nmon> \"" >> $@ ; \
	echo "send \"g$$START_ADDR\"" >> $@ ; \
	xxd -e -c 4 -o 0x$$START_ADDR -g 4 $< | awk '{gsub(":", "", $$1); print ""$$1$$2""}'  > .tmp ; 



clean:
	rm -f *.o *.elf *.img *.bin *.nmon symbols.txt .tmp *.txt $(OBJS)
