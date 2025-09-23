vcs:
	vcs -debug_access+all -sverilog -R -full64 \
		tb.sv \
		-sv ../src/FIFO.sv

verdi:
	verdi -sv tb.sv ../src/FIFO.sv &

lint:
	jg -superlint & 