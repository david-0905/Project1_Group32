module  fifo_integrity(
    input clk,
    input rst_b,
    input vld_in,
    input [3:0] data_in,
    input vld_out,
    input [3:0] data_out
);

logic [3:0] sb_mem [7:0]; // Scoreboard memory
logic [2:0] wr_ptr, rd_ptr;
logic [3:0] counter;

logic [3:0] data_out_1t;
logic [3:0] sb_data_1t;
logic [3:0] data_out_golden;

// FIFO Counters and Valid Signals
always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        wr_ptr <= 3'd0;
        rd_ptr <= 3'd0;
        counter <= 4'd0;
    end else begin
        if (vld_in) begin
            wr_ptr <= wr_ptr + 3'd1;
        end
        if (vld_out) begin
            rd_ptr <= rd_ptr + 3'd1;
        end

        if (vld_in && !vld_out) begin
            counter <= counter + 4'd1;
        end else if (!vld_in && vld_out) begin
            counter <= counter - 4'd1;
        end
    end
end

// Writing data to the Scoreboard
always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        for (int i = 0; i < 7; i++) begin
            sb_mem[i] <= 4'd0;
        end
    end else begin
        if (vld_in) begin
            sb_mem[wr_ptr] <= data_in;
        end
    end
end

logic [3:0] pre_rd_ptr;
// Capturing output data and valid signal
always_ff @(posedge clk or negedge rst_b) begin
  if (!rst_b) begin
    data_out_1t <= 4'd0;
    pre_rd_ptr <= 3'd0;
  end else begin
    data_out_1t <= data_out;
    pre_rd_ptr <= rd_ptr;
  end
end

// check
assign data_out_golden = sb_mem[pre_rd_ptr];

// Overflow Check (Assertion: Overflow when FIFO is full and write occurs without read)
no_overflow : assert property (
    @(posedge clk)
    disable iff (!rst_b)
    !(counter == 4'd4 && vld_in && !vld_out)); // FIFO overflow check

// Data Integrity Check (Assertion: Written data should match read data)
data_integrity : assert property (
    @(posedge clk)
    disable iff (!rst_b)
    (vld_out) |=> (data_out_golden == data_out_1t)); // Ensuring data integrity

endmodule

// Bind for FIFO Integrity
bind FIFO fifo_integrity u_sb (
    .clk(clk),
    .rst_b(rstN),
    .vld_in(write_en && (!full || read_en)),    // Write enable condition (FIFO not full or reading)
    .data_in(write_data),
    .vld_out(read_en && (!empty || write_en)),   // Read enable condition (FIFO not empty or writing)
    .data_out(read_data)
);
