vcs:
	@mkdir -p build
	cd build  && \
	vcs -debug_access+all -sverilog -R -full64 \
		../sim/tb.sv \
		-v ../src/FIFO.sv

verdi:
	@mkdir -p build
	cd build && \
	verdi -sv ../sim/tb.sv ../src/FIFO.sv &

lint:
	@mkdir -p build
	cd build && \
	jg -superlint & 

sb_pass:
	@mkdir -p build
	cd build && \
	jg  ../script/jasper_sb_3.tcl &
clean:
	rm -rf build