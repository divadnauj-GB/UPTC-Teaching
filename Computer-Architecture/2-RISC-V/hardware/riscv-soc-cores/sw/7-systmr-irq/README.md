# Interrupts on NanoRV32-SoC
This example implements the drivers/libraries to handle the GPIO and the UART on the nanorv32-SoC system. The program implements interrupts trigered by the systimer in the system. The times has been configured to triger an interrupt every 100us. The main loop of the program implements a software timer that activate a series of actions (mesages and led control) every second, using as basis the systimer interrupt. 

## Project structure
The following shows the file structure of the current project.

```bash
.
├── inc
│   ├── nanorv32_regs.h # Core registers definitions
│   ├── nanorv32.h      # Helper functions and definitions
│   ├── riscv-csr.h.    # Definitions and registers of the CSR registers
│   ├── soc_gpio.h      # Register definitions and functions for controlling GPIOs
│   ├── soc_regs.h      # Peripherals memory map
│   ├── soc_uart.h      # Register definitions and functions for controlling UART
│   └── systimer.h      # Funtions and definitions for using the systimer
├── src
│   ├── soc_gpio.c      # GPIOs functions
│   ├── soc_uart.c      # UART functions
│   ├── stub_stdlib.c   # stdlib stub functions
│   └── systimer.c      # Systimer functions
├── main.c              # Main program
├── start.S             # crt0 initialization of the processor before calling main function
├── nanorv32-wb-soc.lds # Linker script memory segments definitions
├── qemu.lds            # Linker script memory segments definitions for QEMU
├── Makefile            # Makefile targets 
└── nmon-loader.sh      # nanorv32-SoC programmer through UART
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

1. Compile the program
    ```bash
    cd UPTC-Teaching/Computer-Architecture/2-RISC-V/hardware/riscv-soc-cores/sw/7-systmr-irq
    make clean build nmon
    ```
2. Program the nanorv32-SoC with the compiled application
    ```bash
    expect nmon-loader.sh application.nmon /dev/ttyUSB 115200
    ```