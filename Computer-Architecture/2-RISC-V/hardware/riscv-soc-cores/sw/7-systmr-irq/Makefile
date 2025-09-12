PROJECT ?= application
QEMU ?= 

CROSS_COMPILE=riscv64-unknown-elf-

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
NM=$(CROSS_COMPILE)nm
SIZE=$(CROSS_COMPILE)size

ARCH=-march=rv32im_zicsr -mabi=ilp32

#nanorv32-wb-soc.lds
CFLAGS+=$(ARCH) -Wall -Wextra  -std=c11 -ffreestanding

ifdef QEMU
	CFLAGS+=-g -DQEMU
	LINKERSCRIPT=qemu.lds 
else
	CFLAGS+=-O2
	LINKERSCRIPT=nanorv32-wb-soc.lds 
endif
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

build: $(PROJECT).elf 
nmon: $(PROJECT).nmon


%.o: %.S
	$(CC) $(CFLAGS) -c $^ -o $@ 
	
%.o: %.c 
	$(CC) $(CFLAGS)  -c $< -o $@ 

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

$(PROJECT).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@ 
	$(SIZE) -A -x $@

#START_ADDR := $(shell $(NM) *.elf | awk '/ _start/ {print $$1}')

#xxd -e -c 4 -o 0x$(START_ADDR) -g 4 $< | sed "s/^/w/;s/: //;s/  .*//" > $@
$(PROJECT).nmon: $(PROJECT).bin
	@START_ADDR=$$($(NM) *.elf | awk '/ _start/ {print $$1}'); \
	xxd -e -c 4 -o 0x$$START_ADDR -g 4 $< | awk '{gsub(":", "", $$1); print "send \"w"$$1$$2"\""}'  > .tmp ; \
	awk '{print "expect \"nmon> \"\n" $$0}' .tmp > $@ ; \
	echo "expect \"nmon> \"" >> $@ ; \
	echo "send \"g$$START_ADDR\"" >> $@ ; \
	echo "Start address: 0x$$START_ADDR"; \
	rm -f .tmp



clean:
	rm -f *.o *.elf *.img *.bin *.nmon symbols.txt .tmp *.txt
