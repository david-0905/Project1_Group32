clear -all
check_cov -init -type all

#for `JS3_*
jasper_scoreboard_3 -init

analyze -sv [glob ./src/FIFO.sv]
analyze -sv [glob ./property/jasper_sb_3.sv]
elaborate -top FIFO

clock clk
reset ~rstN

prove -all