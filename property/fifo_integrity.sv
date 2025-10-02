module fifo_integrity(
    input clk,
    input rst_b,
    input vld_in,
    input [3:0] data_in,
    input vld_out,
    input [3:0] data_out
);

// Scoreboard content
logic [3:0] sb_mem [5:0];
logic [2:0] counter;
logic [3:0] read_data;

// Counter
always_ff@(posedge clk or negedge rst_b) begin
  if (!rst_b) begin
    counter <= 3'd0;
  end else begin
    if (vld_in && !vld_out) begin
      counter <= counter + 3'd1;
    end else if (!vld_in && vld_out) begin
      counter <= counter - 3'd1;
    end
  end
end

always_ff@(posedge clk or negedge rst_b) begin
  if (!rst_b) begin
    for (int i = 0; i < 6; i++) begin
      sb_mem[i] <= 4'd0;
    end
  end else begin
    if (vld_in && !vld_out) begin
      sb_mem[counter] <= data_in;
    end
  end
end

no_overflow : assert property (
          @(posedge clk) disable iff (!rst_b) 
          !(counter == 3'd4 && vld_in && !vld_out)
          );

data_integrity : assert property (
          @(posedge clk) disable iff (!rstN) 
          (true_write) |=> (write_data == read_data)
          );

endmodule

bind FIFO fifo_integrity u_fifo_int (
    .clk(clk),
    .rst_b(rstN),
    .vld_in(write_en && (!full || read_en)),
    .data_in(write_data),
    .vld_out(read_en && (!empty || write_en)),
    .data_out(read_data)
);