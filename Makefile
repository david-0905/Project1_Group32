vcs:
	mkdir -p build
	cd build  && \
	vcs -debug_access+all -sverilog -R -full64 \
		../sim/tb.sv \
		-v ../src/FIFO.sv

verdi:
	mkdir -p build
	cd build && \
	verdi -sv ../sim/tb.sv ../src/FIFO.sv &

lint:
	mkdir -p build
	cd build && \
	jg -superlint & 

sb_pass:
	mkdir -p build
	cd build && \
	jg  ../script/jasper_sb_3.tcl &

sb_fail:
	mkdir -p build
	cd build && \
	jg  ../script/jasper_sb_3_bug.tcl &

mysb_pass:
	mkdir -p build
	cd build && \
	jg  ../script/fifo_integrity.tcl &

mysb_fail:
	mkdir -p build
	cd build && \
	jg  ../script/fifo_integrity_bug.tcl &

clean:
	rm -rf build