# Simple RISC-V SoC

This repository contains a basic SoC desing using a nanorv32 core. This repository is an updated version from the original repository available [here](https://github.com/open-design/riscv-soc-cores.git). This repository now works with using fusesoc 2.4.3 using the latest CAP2 configuration specifications. 

The current repository has been proven on the Altera DE1 and DE10-nano boards. 

## Preparation. 
create a conda environment and install fusesoc

```bash
conda create -n fusesoc python=3.11
conda activate fusesoc
pip install fusesoc
```


## System architecture. 

The minimal SoC is composed of a nanorv32 RISC-V processor interconected with several memoery mapped peripherals. The following figure depicts the addresable memory space for each peripheral. 

![Image](./doc/image.png)


## Simulation:

```bash
conda activate fusesoc

fusesoc --cores-root cores/ run --target sim nanorv32-wb-soc-mtvec

gtkwave build/nanorv32-wb-soc-mtvec_0/sim-icarus/nanorv32-wb-soc.vcd 
```

## Build for DE1 Board

```bash
conda activate fusesoc
export PATH=$PATH:</path/to/quartus>/13.0sp1/quartus/bin
fusesoc --cores-root cores/ run --build --tool quartus de1-nanorv32-wb-soc-mtvec
```

## FPGA Program 

```bash
jtagconfig
quartus_pgm  -m jtag -o "p;build/de1-nanorv32-wb-soc-mtvec_0/default-quartus/de1-nanorv32-wb-soc-mtvec_0.sof"
```

## Booting a sw application using NMON 
For loading and booting your application with NMON you need to install `expect`, you can simply type `sudo apt install expect`. Then you can follow these intructions.

```bash
cd sw/blink_led
make clean nmon
expect nmon-loader.sh application.nmon /dev/ttyUSB 115200
```

if you want to terminate the terminal session after programming the SOC, press `~-` followed by the return key.
