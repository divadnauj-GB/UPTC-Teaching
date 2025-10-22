ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

VERILATOR_PARAMS = --trace
VERILATOR_PARAMS += --timing 
VERILATOR_PARAMS += --binary
VERILATOR_PARAMS += -Wno-moddup 
VERILATOR_PARAMS += -Wno-fatal

TOP = array_multiplier_Nbit_tb
ROOT = .
SRC = $(wildcard $(ROOT)/*.v)

default: compile

compile: $(SRC) 
	@echo "-- VERILATE/COMPILE SBTR --------------------"
	$(VERILATOR) $(VERILATOR_PARAMS) $(SRC) -top-module $(TOP)
	@echo "-- DONE -------------------------------------"

test: compile
	./obj_dir/V${TOP}

wave: test
	gtkwave ${TOP}.vcd
clean:
	-rm -rf obj_dir logs *.log *.dmp *.vpd core *.txt *.vcd