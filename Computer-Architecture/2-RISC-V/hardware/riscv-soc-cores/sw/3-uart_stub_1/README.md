# UART Reusing bootloader functions on NanoRV32-SoC
This example uses the uart function from the bootloader to send a message to the PC from the NanoRV32-SoC. The linkerscript expose the address of the function `_nmon_outs = 0x00000148;`, therefore the in the main.c the function is declared as external `extern void _nmon_outs(const char *val0, const char *fmt);` 

Where is `_nmon_outs = 0x00000148;` comming from ?. after compiling the bootloader [0-riscv-nmon](../0-riscv-nmon/) we run the `riscv64-unknown-elf-nm` to get the list of symbols of the bootloader, where we observe that the address were this fuction is allocated corresponds to `0x00000148`, meaning that it corresponds to an address in the Boot ROM. 

```bash
...
00000148 t _nmon_outs
00000000 T _start
...
```

## Project structure
The following corresponds to the project structure the main program is located in `main.c` the `start.S` file contains the initialization file equivalent to `crt0.S` required by C programing. The file `stub_stdlib.c` incorporates the function definitions required by the `libc` library in order to enable the usage of standar C functions such as `sprintf`, `malloc` among others. 

The `nanorv32-wb-soc.lds` corresponds to the linkerscript where the memoery segments are defined according to the `nanorv32-SoC` arhitecture.

The `Makefile` implements the compilation targets of the program.

Finally, the `nmon-loader.sh` is an script the allows to program the `nanorv32-SoC` using the UART conection, this file is independent of the program.



```bash
.
├── main.c
├── stub_stdlib.c
├── start.S
├── nanorv32-wb-soc.lds
├── Makefile
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

1. Compile the program
    ```bash
    cd UPTC-Teaching/Computer-Architecture/2-RISC-V/hardware/riscv-soc-cores/sw/3-uart_stub_1
    make clean build nmon
    ```
2. Program the nanorv32-SoC with the compiled application
    ```bash
    expect nmon-loader.sh application.nmon /dev/ttyUSB 115200
    ```