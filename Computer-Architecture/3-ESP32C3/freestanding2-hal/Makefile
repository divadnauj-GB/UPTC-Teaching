USER_PATH=~
HOME_PATH=$(shell realpath $(USER_PATH))
ESPRESSIF_PATH = $(HOME_PATH)/.espressif
IDF_PATH = $(HOME_PATH)/esp/v5.5/esp-idf
GCC_VERSION=14.2.0_20241119
GDB_VERSION=16.2_20250324
ESP_QEMU_VERSION=develop_9.0.0_20240606
PORT = /dev/tty.usbserial-2140
BAUD = 115200

IDF_PYTHON = $(ESPRESSIF_PATH)/python_env/idf5.5_py3.13_env/bin/python
ESPTOOL = $(IDF_PATH)/components/esptool_py/esptool/esptool.py
ESP_QEMU = $(ESPRESSIF_PATH)/tools/qemu-riscv32/esp_$(ESP_QEMU_VERSION)/qemu/bin/qemu-system-riscv32
PROG        ?= firmware
ARCH        ?= esp32c3
LINKERSCRIPT = ./ld/esp32c3.ld


CFLAGS      ?= -W -Wall -Wextra  -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion -ffreestanding\
               -march=rv32imc_zicsr -mabi=ilp32  -fno-pic --specs=nano.specs --specs=nosys.specs \
               -g -Og -ffunction-sections -fdata-sections -std=gnu11  -Wno-enum-conversion -gdwarf-4 -ggdb\
            $(EXTRA_CFLAGS) 

EXTRA_LINKFLAGS = 
LINKFLAGS   ?= -T${LINKERSCRIPT} $(EXTRA_LINKFLAGS)  -nostdlib  -Wl,-Map=$@.map -Wl,--gc-sections -Wl,--cref  -Wl,--no-warn-rwx-segments

LDLIBS = -lc -lgcc

ESP_TOOLCHAIN   ?= $(ESPRESSIF_PATH)/tools/riscv32-esp-elf/esp-$(GCC_VERSION)/riscv32-esp-elf/bin/riscv32-esp-elf
ESP_GDB = $(ESPRESSIF_PATH)/tools/riscv32-esp-elf-gdb/$(GDB_VERSION)/riscv32-esp-elf-gdb/bin/riscv32-esp-elf-gdb
# ESP_TOOLCHAIN   ?= riscv64-unknown-elf

ROOT = .
SRCS = $(wildcard $(ROOT)/bootstrap/*.c) \
		$(ROOT)/src/main.c \
		$(ROOT)/src/stub_stdlib.c

SRCS +=  $(wildcard $(IDF_PATH)/components/soc/esp32c3/*.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/adc_hal_common.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/adc_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/adc_one_shot_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/aes_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/brownout_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/cache_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/color_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/ds_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/efuse_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/gdma_hal_ahb_v1.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/gdam_hal_axi.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/gdam_hal_crc_gen.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/gdma_hal_top.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/gpio_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/hal_utils.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/hmac_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/i2c_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/i2c_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/i2s_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/ledc_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/ledc_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/ip_i2s_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/ip_timer_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/mmu_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/mpi_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/rmt_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/rtc_io_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/sdm_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/sha_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_flash_encrypt_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_flash_hal_gpspi.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_flash_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_flash_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_slave_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_slave_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/spi_slave_hd_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/systimer_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/timer_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/uart_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/uart_hal.c)
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/uhci_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/usb_serial_jtag_hal.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/wdt_hal_iram.c) 
SRCS +=  $(wildcard $(IDF_PATH)/components/hal/xt_wdt_hal.c) 


INCDIRS ?= -I. -I./inc
INCDIRS += -I$(IDF_PATH)/components/soc/include 
INCDIRS += -I$(IDF_PATH)/components/soc/esp32c3/include 
INCDIRS += -I$(IDF_PATH)/components/soc/esp32c3/register 
INCDIRS += -I$(IDF_PATH)/components/hal/esp32c3/include
INCDIRS += -I$(IDF_PATH)/components/hal/platform_port/include
INCDIRS += -I$(IDF_PATH)/components/hal/include
INCDIRS += -I$(IDF_PATH)/components/esp_common/include
INCDIRS += -I$(IDF_PATH)/components/esp_rom/include
INCDIRS += -I$(IDF_PATH)/components/esp_rom/esp32c3/include
INCDIRS += -I$(IDF_PATH)/components/esp_rom/esp32c3/include/esp32c3


all: clean build 

build: $(PROG).elf $(PROG).bin

$(PROG).elf: $(SRCS)
	$(ESP_TOOLCHAIN)-gcc  $(CFLAGS) $(INCDIRS) $(SRCS) $(LINKFLAGS) $(LDLIBS) -o $@

$(PROG).bin: $(PROG).elf
	$(IDF_PYTHON) $(ESPTOOL) \
	--chip $(ARCH) elf2image --flash_mode dio --flash_freq 80m --flash_size 4MB -o $(PROG).bin $(PROG).elf


qemu: 
	$(IDF_PYTHON) $(ESPTOOL) \
	--chip=$(ARCH) merge_bin --output=./qemu_flash.bin --fill-flash-size=4MB \
	--flash_mode dio --flash_freq 80m --flash_size 4MB 0x0 $(PROG).bin 

	$(ESP_QEMU) -machine $(ARCH) -nographic -s -S -drive file=./qemu_flash.bin,if=mtd,format=raw 

gdb: 
	$(ESP_GDB) $(PROG).elf -ex "target remote :1234" -ex "tb call_start_cpu0"  -ex "c"

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

