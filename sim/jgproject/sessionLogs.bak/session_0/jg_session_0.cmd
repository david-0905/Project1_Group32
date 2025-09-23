# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.03
# platform  : Linux 6.8.0-51-generic
# version   : 2022.03p002 64 bits
# build date: 2022.05.26 13:21:20 UTC
# ----------------------------------------
# started   : 2025-09-23 14:50:36 CST
# hostname  : vcsdl4.(none)
# pid       : 255869
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:35693' '-style' 'windows' '-data' 'AAAAWnicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpOGA8QGUYcMI4gGxCIMuQzFDKUMBQypDEUMOQyZDHkMJUJwdAFhGC/s=' '-proj' '/home/joane3131/FV_1141/Project1_Group32/sim/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/joane3131/FV_1141/Project1_Group32/sim/jgproject/.tmp/.initCmds.tcl'
check_superlint -init
analyze -sv ../src/FIFO.sv
clock clk
elaborate -top FIFO
clock clk
reset ~rstN
set_superlint_fsm_ctl_livelock true
set_superlint_fsm_ctl_livelock true
set_superlint_fsm_ctl_deadlock true
check_superlint -extract
set_superlint_prove_parallel_tasks on
set_prove_no_traces true
analyze -verilog {/home/joane3131/FV_1141/Project1_Group32/src/FIFO.sv} ; 
