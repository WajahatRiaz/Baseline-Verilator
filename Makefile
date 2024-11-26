FLIST="${BASE}/flist.f"
DUT="${BASE}/src/dut.sv"
TBENCH="${BASE}/sim/tbench.sv"

all: help

.PHONY: help all 

build: clean
	@-verilator --binary -j 8 --skip-identical \
		--timing -Wno-fatal -Wno-INSECURE -Wno-style -Wno-lint -quiet \
		-f ${FLIST} \
		${DUT} ${TBENCH} --top tbench \
		--autoflush --trace --coverage --x-assign 1 
		 
run:
	@-$(MAKE) -C ./obj_dir -f ./Vtbench.mk OPT_FAST="-Os" 
	@-./obj_dir/Vtbench +dumpon
	
coverage:
	verilator_coverage --write-info coverage.info coverage.dat
	genhtml coverage.info --output-directory ./logs/html

trace:
	@-gtkwave ./waveform.vcd

synthesize:
	@- yosys ./synth.ys

help:
	@-echo "Please use 'make <target>' where <target> is one of\n"	
	@-echo " help      to get help"
	@-echo " clean     to clean logs, binaries and results"
	@-echo " build     to create binary against your Testbench Top and DUT"
	@-echo " run       to run the verilated source files"
	@-echo " coverage  to collect and view coverage data"
	@-echo "\nMake sure the environment variable BASE is set by using the command below:"
	@-echo ' export BASE="/path/to/this/folder"'

clean:
	@-rm -rf ./obj_dir 
	@-rm -rf ./*.hex 
	@-rm -rf ./*.vcd 
	@-rm -rf ./*.html 
	@-rm -rf ./*.css 
	@-rm -rf ./*.info 
	@-rm -rf ./*.png 
	@-rm -rf ./*.dat 
	@-rm -rf ./src/*.html 
	@-rm -rf ./sim/*.html 
	@-rm -rf ./logs
	@-rm -rf ./*.vcd
	@rm -rf ./*.txt
