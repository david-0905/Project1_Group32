module  fifo_integrity(
    input clk,
    input rst_b,
    input vld_in,
    input [3:0] data_in,
    input vld_out,
    input [3:0] data_out,
    input full,
    input empty
);

logic [5:0] sb_mem [3:0]; // Scoreboard memory
logic [1:0] wr_ptr, rd_ptr;
logic [2:0] counter;
logic [1:0] tag;

logic vld_out_1t;
logic [3:0] data_out_1t;
logic [3:0] sb_data_1t;
logic [3:0] data_out_golden;

// FIFO Counters and Valid Signals
always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        wr_ptr <= 2'd0;
        rd_ptr <= 2'd0;
        counter <= 3'd0;
        tag <= 2'd0;
    end else begin
        if (vld_in) begin
            wr_ptr <= wr_ptr + 2'd1;
            tag <= tag + 2'd1;
        end
        if (vld_out) begin
            rd_ptr <= rd_ptr + 2'd1;
        end

        if (vld_in && !vld_out) begin
            counter <= counter + 3'd1;
        end else if (!vld_in && vld_out) begin
            counter <= counter - 3'd1;
        end
    end
end

// Writing data to the Scoreboard
always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        for (int i = 0; i < 4; i++) begin
            sb_mem[i] <= 6'd0;
        end
    end else begin
        if (vld_in) begin
            sb_mem[wr_ptr] <= {tag,data_in};
        end
    end
end

logic [5:0] untag_read_data;
logic [1:0] data_out_tag;
assign untag_read_data = sb_mem[rd_ptr];
// Capturing output data and valid signal
always_ff @(posedge clk or negedge rst_b) begin
  if (!rst_b) begin
    vld_out_1t <= 1'b0;
    data_out_1t <= 4'd0;
    data_out_golden <= 4'd0;
    data_out_tag <= 2'd0;
  end else begin
    vld_out_1t <= vld_out;
    data_out_1t <= data_out;
    if(counter == 3'd0) begin
      data_out_golden <= data_in;
      data_out_tag <= tag;
    end else begin
      data_out_golden <= untag_read_data[3:0] ;
      data_out_tag <= untag_read_data[5:4];
    end
  end
end

// Overflow Check (Assertion: Overflow when FIFO is full and write occurs without read)
no_overflow : assert property (
    @(posedge clk)
    disable iff (!rst_b)
    !(counter == 3'd4 && vld_in && !vld_out)); // FIFO overflow check


// Data drop Check (Assertion:)
localparam int SB_DEPTH = 4;

logic [SB_DEPTH-1:0] match_vec;
logic [3:0] true_sb_mem_data [3:0];

always_comb begin
    for (integer i = 0; i < SB_DEPTH; i++) begin : GEN_SB_CMP
    // combinational compare
    true_sb_mem_data[i] = sb_mem[i] & 6'hf;
    match_vec[i] = (data_out_golden == true_sb_mem_data[i]);
    end
end

no_drop : assert property (
  @(posedge clk)
  disable iff (!rst_b)
  vld_out |-> (|match_vec) && ( !(counter == 3'd4 && vld_in && !vld_out) ||(data_out_golden == data_in))
);
// Data Duplicate Check (Assertion: After vld_out, the next tag shouln't same as last tag)
// 當讀取請求，讀出的資料與下一次讀取請求後讀出的資料 tag不能一樣
no_duplicate : assert property(
    @(posedge clk)
    disable iff(!rst_b)
    vld_out_1t |=> (data_out_tag)!= $past(data_out_tag)
);

// Data out of order Check (Assertion:)
// 讀取的tag必須照順序
no_OutOfOrder : assert property(
    @(posedge clk)
    disable iff(!rst_b)
    vld_out_1t |=> (data_out_tag) == $past(data_out_tag+ 2'd1)
);

// Data Corrupted Check (Assertion: Written data should match read data)
data_corrupted : assert property (
    @(posedge clk)
    disable iff (!rst_b)
    (vld_out_1t) |-> (data_out_golden == data_out_1t)); // Ensuring data don't corrupted

///////////////////////////////////////////////////////////////
logic [3:0] sampling_d;
logic rand_samping_var;
assume property($stable(sampling_d)); 

logic sampling_in;
logic sampling_out;

logic incr = vld_in && (!sampling_in ) ;
logic decr = vld_out && (!sampling_out ) ;
//logic decr = vld_out && (!((tracking_counter==1) && sampling_in) || (full&& vld_in)) ;
//第一個就是sampling_d 並且馬上讀入讀出
//logic sampled_same_read_write = sampling_d == data_in && vld_out && vld_in ;
always_ff @(posedge clk) begin : Sample_In_Region
    if(!rst_b) begin
        sampling_in <= 1'b0;
    end
    else if(sampling_d == data_in && incr && rand_samping_var) begin
        sampling_in <= 1'b1;
    end
end
                    //裡面至少一筆資料
assign must_read = ((tracking_counter==1) && sampling_in && decr) || (tracking_counter==0 && incr && decr && rand_samping_var && sampling_d == data_in);
always_ff @(posedge clk) begin : Sample_Out_Region
    if(!rst_b) begin
        sampling_out <= 1'b0;
    end
    else if(must_read) begin
        sampling_out <= 1'b1;
    end
end

logic [3:0]tracking_counter;
always_ff @(posedge clk) begin : Ptr_counter
    if(!rst_b) begin
        tracking_counter <= 3'b0;
    end 
    else begin
        tracking_counter <= tracking_counter + incr - decr;
    end

end

data_intigrity : assert property (
    @(posedge clk)
    disable iff (!rst_b)
    (must_read  |-> (data_out==sampling_d)) 
);

tracking_counter_under : cover property (
    @(posedge clk)
    disable iff (!rst_b)
    (tracking_counter == 3'h1) 
);

endmodule

// Bind for FIFO Integrity
bind FIFO fifo_integrity u_sb (
    .clk(clk),
    .rst_b(rstN),
    .vld_in(write_en && (!full || read_en)),    // Write enable condition (FIFO not full or reading)
    .data_in(write_data),
    .vld_out(read_en && (!empty || write_en)),   // Read enable condition (FIFO not empty or writing)
    .data_out(read_data),
    .full(full),
    .empty(empty)
);
