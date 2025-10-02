module my_scoreboard(
    input clk,
    input rst_b,
    input vld_in,
    input [3:0] data_in,
    input vld_out,
    input [3:0] data_out
);

// Instance of Jasper Scoreboard 3
jasper_scoreboard_3 #(
    .CHUNK_WIDTH(4),
    .IN_CHUNKS(1),
    .OUT_CHUNKS(1),
    .ORDERING(`JS3_IN_ORDER),
    .SINGLE_CLOCK(1),
    .MAX_PENDING(4)
) u_scoreboard (
    .clk(clk),
    .rstN(rst_b),
    .incoming_vld(vld_in),
    .incoming_data(data_in),
    .outgoing_vld(vld_out),
    .outgoing_data(data_out)
);
endmodule

bind FIFO my_scoreboard u_sb (
    .clk(clk),
    .rst_b(rstN),
    .vld_in(write_en && (!full || read_en)),
    .data_in(write_data),
    .vld_out(read_en && (!empty || write_en)),
    .data_out(read_data)
);