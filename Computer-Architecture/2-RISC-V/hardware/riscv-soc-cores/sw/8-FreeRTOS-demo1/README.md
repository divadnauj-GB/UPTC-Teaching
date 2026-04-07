# RTOS basic example NanoRV32-SoC
This example implements a port example of FreeRTOS on nanorv32-SoC. The program creates two tasks. The first task is executed every 500ms and the second task is executed every 300ms. The tasks control a separate set of LEDs and send a message via UART during the operation.

## Project structure
The following shows the file structure of the current project.

```bash
.
├── inc
│   ├── freertos_risc_v_chip_specific_extensions.h
│   ├── FreeRTOSConfig.h
│   ├── nanorv32_regs.h
│   ├── nanorv32.h
│   ├── print.h
│   ├── riscv-csr.h
│   ├── soc_gpio.h
│   ├── soc_regs.h
│   ├── soc_uart.h
│   └── systimer.h
├── src
│   ├── main.c
│   ├── print.c
│   ├── soc_gpio.c
│   ├── soc_uart.c
│   ├── start.S
│   └── systimer.c
├── Makefile
├── nanorv32-wb-soc.lds
└── nmon-loader.sh
```

# How to use this example

## 1. Build the hardware SoC

1. Build the hardware and program de FPGA device
    ```bash
    cd UPTC-Teaching/Computer-Architecture/2-RISC-V/hardware/riscv-soc-cores/
    conda activate fusesoc
    fusesoc --cores-root cores/ run --build --tool quartus de1-nanorv32-wb-soc-mtvec    
    ```
2. Program the *.sof file to the FPGA using either the terminal or the Quartus graphical interface
    ```bash
    jtagconfig
    quartus_pgm  -m jtag -o "p;build/de1-nanorv32-wb-soc-mtvec_0/default-quartus/de1-nanorv32-wb-soc-mtvec_0.sof"
    ```
2. Connect the nanorv32-SoC to the PC using a USB-to-Serial converter (e.g., FT232RL), following this schematic diagram. the GPIO_0[1] must be connected to the RX pin on the USB-to-Serial converter and the GPIO_0[3] must be connected to the TX pin on the USB-to-Serial converter. The GND pin (12) must be connected to the GND pin on the USB-to-Serial converter.

    -------------------------
        .------.
        | 1   2|  2 (GPIO_0[1]) fpga --> host
        | 3   4|  4 (GPIO_0[3]) fpga <-- host
        | .....|
        |    12| 12 (GND)
        |      |
        |      |
        |......|
        |      |
        |39  40|
        '------'
        GPIO0
    -------------------------

## Compile and program de SoC with the application
1. Pull the FreeRTOS main repository
    ```bash
    cd UPTC-Teaching/Computer-Architecture/2-RISC-V/hardware/riscv-soc-cores/sw/8-FreeRTOS-demo1
    git submodule update --recursive
    ```
2. Compile the program
    ```bash
    cd UPTC-Teaching/Computer-Architecture/2-RISC-V/hardware/riscv-soc-cores/sw/7-systmr-irq
    make clean build nmon
    ```
3. Program the nanorv32-SoC with the compiled application
    ```bash
    expect nmon-loader.sh application.nmon /dev/ttyUSB 115200
    ```