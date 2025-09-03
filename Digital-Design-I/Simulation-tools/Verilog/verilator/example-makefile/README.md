# Verilator simulation with Makefile commands

```bash
verilator --binary --timing -Wno-moddup -Wno-fatal trafic_lights_tb.v trafic_lights.v -top-module trafic_lights_tb 
./obj/Vtrafic_lights_tb
````


