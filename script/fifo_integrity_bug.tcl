clear -all
check_cov -init -type all

analyze -sv [glob ../src/FIFO_bug.sv]
analyze -sv [glob ../property/fifo_integrity.sv]
elaborate -top FIFO

clock clk
reset ~rstN

prove -all