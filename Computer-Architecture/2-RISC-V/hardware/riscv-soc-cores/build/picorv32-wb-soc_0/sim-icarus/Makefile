TARGET           := picorv32-wb-soc_0
VPI_MODULES      := vpi.vpi
TOPLEVEL         := -spicorv32_wb_soc_tb
IVERILOG_OPTIONS := -DPRESCALER_PRESET_HARD -DPRESCALER_HIGH_PRESET=0 -DPRESCALER_LOW_PRESET=2 -DSIM
VVP_OPTIONS := 

all: $(VPI_MODULES) $(TARGET)

$(TARGET):
	iverilog $(TOPLEVEL) -c $(TARGET).scr -o $@ $(IVERILOG_OPTIONS)

run: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l icarus.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(VVP_OPTIONS) $(TARGET) -fst $(EXTRA_OPTIONS)

clean:
	$(RM) $(VPI_MODULES) $(TARGET)

vpi_LIBS := 
vpi_INCS := -Isrc/elf-loader_0/
vpi_SRCS := src/elf-loader_0/elf-loader.c src/elf-loader_0/vpi_wrapper.c

vpi.vpi: $(vpi_SRCS)
	iverilog-vpi --name=vpi $(vpi_LIBS) $(vpi_INCS) $?

clean_vpi:
	$(RM) vpi.vpi
