# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2022.03
# platform  : Linux 6.8.0-51-generic
# version   : 2022.03p002 64 bits
# build date: 2022.05.26 13:21:20 UTC
# ----------------------------------------
# started   : 2025-10-02 14:21:55 CST
# hostname  : vcsdl4.(none)
# pid       : 2791
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:34837' '-style' 'windows' '-data' 'AAAAeHicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpOGA8QGUYcMI4gGxEYMeEOozFDMkMxQxZDIUMJQAeVkMiUCRAoZUoFg8kJUEJI2B6kqAqnJA+gES5xEK' '-proj' '/home/joane3131/FV_1141/Project1_Group32/build/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/joane3131/FV_1141/Project1_Group32/build/jgproject/.tmp/.initCmds.tcl' '../script/jasper_sb_3.tcl'
clear -all
check_cov -init -type all

#for `JS3_*
jasper_scoreboard_3 -init

analyze -sv [glob ../src/FIFO.sv]
analyze -sv [glob ../property/jasper_sb_3.sv]
elaborate -top FIFO

clock clk
reset ~rstN

prove -all
visualize -violation -property <embedded>::FIFO.u_sb.u_scoreboard.genblk6.core.genblk5.genblk2.no_overflow -new_window
