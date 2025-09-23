PROJECT ?= FreeRTOS_demo
QEMU ?= 

CROSS_COMPILE=riscv64-unknown-elf-

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
NM=$(CROSS_COMPILE)nm
SIZE=$(CROSS_COMPILE)size
OBJDUMP=$(CROSS_COMPILE)objdump

ARCH=-march=rv32im_zicsr -mabi=ilp32

#nanorv32-wb-soc.lds
CFLAGS+=$(ARCH) -Wall -Wextra  -std=c11 -ffreestanding

ifdef QEMU
	CFLAGS+=-g -DQEMU
	LINKERSCRIPT=qemu.lds 
else
	CFLAGS+=-O3
	LINKERSCRIPT=nanorv32-wb-soc.lds 
endif
CFLAGS+=--specs=nano.specs --specs=nosys.specs
CFLAGS+=-MMD

LDFLAGS +=-T$(LINKERSCRIPT) 
LDFLAGS +=-nostdlib 
LDFLAGS +=-Wl,--no-relax,--strip-debug,-Bstatic

LDLIBS = -lc -lgcc

OBJS = \
	bin/start.o \
	bin/main.o \
	bin/soc_uart.o \
	bin/soc_gpio.o \
	bin/systimer.o \
	bin/print.o \
	bin/portASM.o \
	bin/port.o \
	bin/heap_4.o \
	bin/tasks.o \
	bin/queue.o \
	bin/list.o \
	bin/timers.o 

INCLUDES=-I./inc -I./../FreeRTOS-Kernel/portable/GCC/RISC-V -I./../FreeRTOS-Kernel/include

build: ./bin/$(PROJECT).elf 
nmon: $(PROJECT).nmon


bin/%.o: src/%.S
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $^ -o $@ 

./bin/%.o: src/%.c 
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES)  -c $< -o $@ 

bin/%.o: ../FreeRTOS-Kernel/portable/GCC/RISC-V/%.S
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $^ -o $@ 

./bin/%.o: ../FreeRTOS-Kernel/portable/GCC/RISC-V/%.c 
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ 

./bin/%.o: ../FreeRTOS-Kernel/portable/MemMang/%.c 
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ 

./bin/%.o: ../FreeRTOS-Kernel/%.c 
	mkdir -pv $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ 

./bin/%.bin: ./bin/%.elf
	$(OBJCOPY) -O binary $< $@

./bin/$(PROJECT).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@ 
	$(SIZE) -A -x $@
	$(OBJDUMP) -S -d ./bin/$(PROJECT).elf > app.txt

#START_ADDR := $(shell $(NM) *.elf | awk '/ _start/ {print $$1}')

#xxd -e -c 4 -o 0x$(START_ADDR) -g 4 $< | sed "s/^/w/;s/: //;s/  .*//" > $@
$(PROJECT).nmon: ./bin/$(PROJECT).bin
	@START_ADDR=$$($(NM) ./bin/*.elf | awk '/ _start/ {print $$1}'); \
	xxd -e -c 4 -o 0x$$START_ADDR -g 4 $< | awk '{gsub(":", "", $$1); print "send \"w"$$1$$2"\""}'  > .tmp ; \
	awk '{print "expect \"nmon> \"\n" $$0}' .tmp > $@ ; \
	echo "expect \"nmon> \"" >> $@ ; \
	echo "send \"g$$START_ADDR\"" >> $@ ; \
	echo "Start address: 0x$$START_ADDR"; \
	xxd -e -c 4 -o 0x$$START_ADDR -g 4 $< | awk '{gsub(":", "", $$1); print ""$$1$$2""}'  > .tmp ; 



clean:
	rm -f *.o *.elf *.img *.bin *.nmon symbols.txt .tmp *.txt 
	rm -rf bin
