module my_scoreboard_bind (
    input clk,
    input rst_n,
    input write_en,
    input [3:0]data_in,
    input read_en,
    input [3:0]data_out,
    input full,
    input empty,
    input non
);

logic vld_in, vld_out;
assign vld_in = write_en && !full;
assign vld_out = read_en && !empty;

my_scoreboard scoreboard(
    .clk(clk),
    .rstN(rst_n),
    .incoming_vld(vld_in),
    .incoming_data(data_in),
    .outgoing_vld(vld_out),
    .outgoing_data(data_out)
);

endmodule

module my_scoreboard (
    input clk,
    input rstN,
    input incoming_vld,
    input [3:0]incoming_data,
    input outgoing_vld,
    input [3:0]outgoing_data
);

logic [3:0] ScoreBoard_mem[7:0];
logic ScoreBoard_InValid[7:0];
logic [2:0] write_ptr;
logic [2:0] read_ptr;

// Scoreboard incoming behavior
always_ff @(posedge clk ) begin
    if(~rstN) begin
        for(int i; i<8;i++) begin
            ScoreBoard_mem[i] <= 4'b0;
            ScoreBoard_InValid[i] <= 1'b0;
            write_ptr <= 3'b0;
            read_ptr <= 3'b0;
        end
    end
    else if(incoming_vld && outgoing_vld) begin
        ScoreBoard_mem[write_ptr] <= incoming_data;
        ScoreBoard_InValid[write_ptr] <= 1'b1;
        ScoreBoard_InValid[read_ptr] <= 1'b0;
        write_ptr <= write_ptr + 3'b1;
        read_ptr <= read_ptr + 3'b1;
    end
    else if(incoming_vld) begin
        ScoreBoard_mem[write_ptr] <= incoming_data;
        ScoreBoard_InValid[write_ptr] <= 1'b1;
        write_ptr <= write_ptr + 3'b1;

        read_ptr <= read_ptr;
    end
    else if(outgoing_vld)begin
        write_ptr <= write_ptr;
        
        read_ptr <= read_ptr + 3'b1;
        ScoreBoard_InValid[read_ptr] <= 1'b0;
    end
    else begin
        write_ptr <= write_ptr ;
        read_ptr <= read_ptr;
    end
end

// Overflow property
//DA_TRE_RACE = 
//Detect Arithmetic Threshold/Range Exceeded — Raise Assertion/Carry Event
DA_TRE_RACE : assert property(
    @(posedge clk)
    disable iff (!rstN)
    (outgoing_vld) |->ScoreBoard_InValid[read_ptr] == 1'b1
);

// Data Integrity
RACE_ETA_3 : assert property(
    @(posedge clk)
    disable iff (!rstN)
    outgoing_vld |-> ScoreBoard_mem[read_ptr]==outgoing_data
);

endmodule

bind FIFO my_scoreboard_bind BIND_FIFO(
    .clk(clk),
    .rst_n(rstN),
    .write_en(write_en),
    .data_in(write_data),
    .read_en(read_en),
    .data_out(read_data),
    .full(full),
    .empty(empty),
    .non()
);