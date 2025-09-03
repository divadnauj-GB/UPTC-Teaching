# Basic Project 

This example shows how to create and compile asimple project using quartus II using TCL scripts and CLI, this is very usefule when using servers or linux based frameworks.

### Project, Build, and Compile

```bash
export PATH:$PATH:/path/to/quartus/bin #export the quartus bin directory to the path
quartus_sh -t de1_basic_project.tcl #create the project using tcl scripts
quartus_map de1_basic_project # synthesize and map to LUTS
quartus_fit de1_basic_project # Place and routing
quartus_asm de1_basic_project # assemble bitstring generation
quartus_sta de1_basic_project # static timing analysis
quartus_dse de1_basic_project # power analysis

```

Alaternatively you can use the makefile to automate the process
```bash
export PATH:$PATH:/path/to/quartus/bin #export the quartus bin directory to the path
make all
```

### FPGA device programming using USB blaster on Linux devices

- check that the device is connected properly
```bash
./jtagconfig
1) USB-Blaster [1-2]
031050DD 10M50DA(.|ES)/10M50DC
```

- Program the device using the `*.sof` file
```bash
quartus_pgm  -m jtag -o "p;de1_basic_project.sof" 
```
