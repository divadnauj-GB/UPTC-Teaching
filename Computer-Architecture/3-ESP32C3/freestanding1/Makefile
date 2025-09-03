ESPRESSIF_PATH=~/.espressif
IDF_PATH=~/esp/v5.5/esp-idf
GCC_VERSION=14.2.0_20241119
GDB_VERSION=16.2_20250324
ESP_QEMU_VERSION=develop_9.0.0_20240606
PORT=/dev/tty.usbserial-2140
BAUD=115200

IDF_PYTHON = $(ESPRESSIF_PATH)/python_env/idf5.5_py3.13_env/bin/python
ESPTOOL = $(IDF_PATH)/components/esptool_py/esptool/esptool.py
ESP_QEMU = $(ESPRESSIF_PATH)/tools/qemu-riscv32/esp_$(ESP_QEMU_VERSION)/qemu/bin/qemu-system-riscv32
PROG        ?= firmware
ARCH        ?= esp32c3
LINKERSCRIPT = ./ld/esp32c3.ld



CFLAGS      ?= -W -Wall -Wextra  -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion -ffreestanding\
               -march=rv32imc_zicsr -mabi=ilp32 --specs=nano.specs --specs=nosys.specs \
               -g -Og -ffunction-sections -fdata-sections -std=gnu11  -Wno-enum-conversion -gdwarf-4 -ggdb\
               -I. -I./inc $(EXTRA_CFLAGS) 
EXTRA_LINKFLAGS = 
LINKFLAGS   ?= -T${LINKERSCRIPT} $(EXTRA_LINKFLAGS)  -nostdlib -Wl,-Map=$@.map -Wl,--gc-sections -Wl,--cref -Wl,--no-warn-rwx-segments 

LDLIBS = -lc -lgcc

ESP_TOOLCHAIN   ?= $(ESPRESSIF_PATH)/tools/riscv32-esp-elf/esp-$(GCC_VERSION)/riscv32-esp-elf/bin/riscv32-esp-elf
ESP_GDB = $(ESPRESSIF_PATH)/tools/riscv32-esp-elf-gdb/$(GDB_VERSION)/riscv32-esp-elf-gdb/bin/riscv32-esp-elf-gdb
# TOOLCHAIN   ?= riscv64-unknown-elf

ROOT = .
SRCS = $(wildcard $(ROOT)/bootstrap/*.S  $(ROOT)/bootstrap/*.c) \
		$(ROOT)/src/main.c

all: clean build 

build: $(PROG).elf $(PROG).bin

$(PROG).elf: $(SRCS)
	$(ESP_TOOLCHAIN)-gcc  $(CFLAGS) $(SRCS) $(LINKFLAGS) $(LDLIBS) -o $@

$(PROG).bin: $(PROG).elf
	$(ESP_TOOLCHAIN)-objcopy -O binary $(PROG).elf $(PROG).bin


qemu: 
	$(IDF_PYTHON) $(ESPTOOL) \
	--chip=$(ARCH) merge_bin --output=./qemu_flash.bin --fill-flash-size=4MB \
	--flash_mode dio --flash_freq 80m --flash_size 4MB 0x0 $(PROG).bin 

	$(ESP_QEMU) -machine $(ARCH) -nographic -s -S -drive file=./qemu_flash.bin,if=mtd,format=raw 

gdb: 
	$(ESP_GDB) $(PROG).elf -ex "target remote :1234" -ex "tb _entry" -ex "tb _clear_bss" -ex "tb _end_clear_bss" -ex "c"

flash: $(PROG).bin 
	$(IDF_PYTHON) $(ESPTOOL) \
	--chip $(ARCH) --port $(PORT) --baud $(BAUD) \
	 --before default_reset --after hard_reset write_flash -z --flash_mode dio \
	 --flash_freq 80m --flash_size detect 0x0 $(PROG).bin 

monitor: 
	screen $(PORT) $(BAUD)

clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*

# $(TOOLCHAIN)-objcopy -O binary $(PROG).elf $(PROG).bin

