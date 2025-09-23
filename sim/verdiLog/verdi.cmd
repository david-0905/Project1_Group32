debImport "-sv" "tb.sv" "../src/FIFO.sv"
wvCreateWindow
verdiWindowBeWindow -win $_nWave2
wvResizeWindow -win $_nWave2 0 31 1920 981
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 {/home/joane3131/FV_1141/Project1_Group32/sim/fifo.fsdb}
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 3 -pos 1 -win $_nTrace1
srcSelect -signal "rstN" -line 4 -pos 1 -win $_nTrace1
srcSelect -signal "write_en" -line 5 -pos 1 -win $_nTrace1
srcSelect -signal "read_en" -line 6 -pos 1 -win $_nTrace1
srcSelect -signal "write_data" -line 7 -pos 1 -win $_nTrace1
srcSelect -signal "read_data" -line 8 -pos 1 -win $_nTrace1
srcSelect -signal "full" -line 9 -pos 1 -win $_nTrace1
srcSelect -signal "empty" -line 10 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb/clk" "/tb/rstN" "/tb/write_en" "/tb/read_en" \
           "/tb/write_data\[3:0\]" "/tb/read_data\[3:0\]" "/tb/full" \
           "/tb/empty"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 0.000000 69228958.190541
wvResizeWindow -win $_nWave2 0 31 1920 981
wvResizeWindow -win $_nWave2 0 31 1920 981
wvSelectGroup -win $_nWave2 {G2}
wvZoom -win $_nWave2 17513159.374695 28144453.954456
wvZoom -win $_nWave2 19591737.642212 21491513.478118
wvZoom -win $_nWave2 19891281.834977 20137573.726808
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb"
wvGetSignalSetScope -win $_nWave2 "/tb/u_fifo"
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvGetSignalClose -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 135334026.348984 222819829.992992
wvZoom -win $_nWave2 154155429.095018 164639011.732107
wvZoom -win $_nWave2 158151973.562117 159467013.009937
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 157805934.800613 158900725.875602
wvZoom -win $_nWave2 158141967.380029 158514058.249945
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 7148.563420 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 24566.993693 -snap {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetCursor -win $_nWave2 35148.283111 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 54286.615277 -snap {("G1" 4)}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb"
wvGetSignalSetScope -win $_nWave2 "/tb/u_fifo/Unnamed_\$FIFO_sv_45"
wvGetSignalSetScope -win $_nWave2 "/tb/u_fifo"
wvGetSignalSetScope -win $_nWave2 "/tb"
wvGetSignalSetOptions -win $_nWave2 -input on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -output on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -inout on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -net on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -net off
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -register on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -all on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -all off
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvGetSignalSetOptions -win $_nWave2 -all on
wvGetSignalSetSignalFilter -win $_nWave2 "*"
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomAll -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb/u_fifo"
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvGetSignalClose -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 0.000000 135766.082691
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 1431446.741416 1590824.316748
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 675878.976875 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoom -win $_nWave2 1127448.773651 1275020.602663
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 6240706.482130 7449043.728101
wvZoomAll -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb/u_fifo"
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same_empty} -height 20 \
{/tb/u_fifo/rd_wr_same_full} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 10 )} 
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb/clk} -height 20 \
{/tb/rstN} -height 20 \
{/tb/write_en} -height 20 \
{/tb/read_en} -height 20 \
{/tb/write_data\[3:0\]} -height 20 \
{/tb/read_data\[3:0\]} -height 20 \
{/tb/full} -height 20 \
{/tb/empty} -height 20 \
{/tb/u_fifo/rd_wr_same_empty} -height 20 \
{/tb/u_fifo/rd_wr_same_full} -height 20 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 9 10 )} 
wvSetPosition -win $_nWave2 {("G1" 10)}
wvGetSignalClose -win $_nWave2
wvZoom -win $_nWave2 3824031.990189 4875996.180799
wvZoom -win $_nWave2 4327529.917439 4497082.660145
wvSetCursor -win $_nWave2 4355095.605111 -snap {("G1" 4)}
wvZoomOut -win $_nWave2
