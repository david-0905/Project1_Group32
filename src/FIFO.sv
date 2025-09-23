`ifndef FIFO_SV
`define FIFO_SV
`timescale 1ns/1ps

module FIFO(
  input logic clk,
  input logic rstN,
  input logic write_en,
  input logic read_en,
  input logic [3:0] write_data,
  output logic [3:0] read_data,
  output logic full,
  output logic empty
);

parameter DEPTH = 4;
parameter ADDR_WIDTH = $clog2(DEPTH);

logic [3:0] mem [DEPTH-1:0];
logic [ADDR_WIDTH:0] write_ptr, read_ptr;
logic [ADDR_WIDTH-1:0] true_write_ptr, true_read_ptr;
logic msb_write_ptr, msb_read_ptr;
logic rd_wr_same_empty, rd_wr_same_full;

assign {msb_write_ptr, true_write_ptr} = write_ptr;
assign {msb_read_ptr, true_read_ptr} = read_ptr;

// Read Operation
always_ff@(posedge clk or negedge rstN) begin
  if(!rstN) begin
    read_ptr <= 3'd0;
  end else if(read_en && (!empty || write_en)) begin
    read_ptr <= read_ptr + 3'd1;
  end
end

// For Read Write at same time , since data is not written into memory 
assign rd_wr_same_full = (read_en && write_en && full ); // For full condition check
assign rd_wr_same_empty = (read_en && write_en && empty);
assign read_data = (!rd_wr_same_empty)? mem[true_read_ptr] : write_data;

// Write Operation
always_ff@(posedge clk or negedge rstN) begin
  if(!rstN) begin
    write_ptr <= 3'd0;  
    for(int i = 0; i < DEPTH; i++) begin
      mem[i] <= 4'd0;
    end 
  end else if(write_en && (!full || read_en)) begin
    write_ptr <= write_ptr + 3'd1;
    mem[true_write_ptr] <= write_data;
  end
end

// Full and Empty Flags
assign full = (msb_write_ptr != msb_read_ptr) && (true_write_ptr == true_read_ptr);
assign empty = (write_ptr == read_ptr);

endmodule
`endif