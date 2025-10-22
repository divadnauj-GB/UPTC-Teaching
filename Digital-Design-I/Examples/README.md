# HDL examples
This directory contains basic examples of both VHDL and Verilog used for describing digital systems. The examples cover from basic building blocks structures up to comples systems combining different hardware components

## How to
Every example can be simulated using either GHDL (for VHDL examples) or Verilator (for verilog examples). In either case, you can compile and check the waveforms typing the following command: 

```bash
make clean wave
```

This command will compile, simulate and open the waveforms using GtKwave. 

## List of examples

### Mux

- **mux2to1**:
- **mux4to1**:
- **mux4to1Nbit**:

### Barrel-Shifter

### Encoders
- **binary encoder**
- **priority encoder**

### Decoders
- **bcd 7seg**
- **decoder 2to4**

### Adders
- **riple carry adder**
- **behavioral adder**

### Multipliers
- **array multiplier**
- **behavioral multiplier**

### Comparator
- **unsigned comparator**

### Flip-flops
- **D FF**
- **T FF**
- **JK FF**

### Registers
- **PIPO (parallel input parallel output)**
- **PISO (parallel input serial output)**
- **SIPO (serial input parallel output)**
- **SISO (serial input serial output)**

### Counters
- **async counter**
- **simple behavioural synchronous counter**
- **parallel load counter**

### FSM

