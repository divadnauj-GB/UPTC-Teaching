# Simulation tools (Opensource)

HDL simulation is crucial for verifying the functional accuracy, timing, and behavior of digital designs before hardware implementation, which reduces errors, saves costs, and allows for rapid design modifications. Key HDL simulation tools include industry standards like Verilog and VHDL, which are supported by proprietary software from vendors like Aldec (e.g., Active-HDL) and open-source alternatives such as Icarus Verilog, Verilator, and GHDL.

## Open-Source Tools:
**Icarus Verilog**: A widely used, open-source Verilog simulator that allows for simulation and netlist generation. 

**Verilator**: A high-performance Verilog simulator that compiles Verilog into C++ or SystemC for faster execution and system-level simulation.

**GHDL**: A simulator and synthesis tool for VHDL. GHDL can be build for various backends: gcc - using the GCC compiler framework.

**Yosys**: An open-source synthesis framework that can be used in conjunction with simulation tools for the complete design flow. This also support the FPGA development on wide spectrum of devices.


## Installation of OSS-CAD-SUITE
OSS CAD Suite is a binary software distribution for a number of open source software used in digital logic design. You will find tools for RTL synthesis, formal hardware verification, place & route, FPGA programming, and testing with support for HDLs like Verilog, Migen, and Amaranth.

### Instalation
1. Download an archive matching your OS from the [releases page](https://github.com/YosysHQ/oss-cad-suite-build/releases/latest).
2. Extract the archive to a location of your choice (for Windows it is recommended that path does not contain spaces)
3. On macOS to allow execution of quarantined files `xattr -d com.apple.quarantine oss-cad-suite-darwin-x64-yyymmdd.tgz` on downloaded file, or run: ./activate in extracted location once.
4. Set the environment as described below.

**Linux and macOS**
```bash
export PATH="<extracted_location>/oss-cad-suite/bin:$PATH"
# or
source <extracted_location>/oss-cad-suite/environment
```

**Windows**
```bash
#from existing CMD prompt:
<extracted_location>\oss-cad-suite\environment.bat

#from existing PowerShell prompt:
. <extracted_location>\oss-cad-suite\environment.ps1

#to create new CMD prompt:
<extracted_location>\oss-cad-suite\start.bat
```

## Examples on how to use the simulation tools

### Verilog
#### icarus verilog
- [Example-cli](./Verilog/icarus/example-cli/)

- [Example-makefile](./Verilog/icarus/example-makefile/)

#### Verilator
- [Example-cli](./Verilog/verilator/example-cli/)

- [Example-makefile](./Verilog/verilator/example-makefile/)

#### Modelsim
- [Example-gui](./Verilog/modelsim/example-gui/)

- [Example-tcl](./Verilog/modelsim/example-tcl/)

### VHDL

#### GHDL
- [Example-cli](./VHDL/GHDL/example-cli/)

- [Example-script](./VHDL/GHDL/example-script/)

#### Modelsim
- [Example-gui](./VHDL/modelsim/example-gui/)

- [Example-tcl](./VHDL/modelsim/example-tcl/)