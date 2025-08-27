# Verilator simulation with CLI commands

```bash
verilator --binary --timing --trace -Wno-moddup -Wno-fatal trafic_lights_tb.v trafic_lights.v -top-module trafic_lights_tb 
./obj_dir/Vtrafic_lights_tb
gtkwave trafic_lights_tb.vcd
````

