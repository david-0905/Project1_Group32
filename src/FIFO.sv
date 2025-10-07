module FIFO (
    input clk,
    input rstN,
    input write_en,
    input read_en,
    input [3:0]write_data,
    output logic [3:0]read_data,
    output logic full,
    output logic empty
);

// Reg and Ptr logic
logic [3:0]FIFO_reg[3:0];
logic [2:0]write_ptr;
logic [2:0]read_ptr;

// Full and Empty logic
logic full_flag;
logic empty_flag;
assign empty_flag = (write_ptr == read_ptr);
assign full_flag = (write_ptr[2]!=read_ptr[2]) && (read_ptr[1:0]== write_ptr[1:0]);

// Input and Output port assign
assign full = full_flag;
assign empty = empty_flag;

// Ptr storage and control
always_ff @(posedge clk) begin : READ_PtrCtrl
    if (~rstN) begin
        read_ptr <= 3'b0;
    end
    else if(read_en && (!empty_flag || write_en)) begin
        read_ptr <= read_ptr + 3'b001;
    end
    else begin
        read_ptr <= read_ptr;
    end
end

// Ptr storage and control
always_ff @(posedge clk) begin : Write_PtrCtrl
    if (~rstN) begin
        write_ptr <= 3'b0;
    end
    else if(write_en && (!full_flag || read_en)) begin
        write_ptr <= write_ptr + 3'b001;
    end
    else begin
        write_ptr <= write_ptr;
    end
end

// FIFO behavior
always_ff @(posedge clk ) begin : FIFO_behavior
    if(~rstN) begin
        for(int i; i<4;i++) begin
            FIFO_reg[i] <= 4'b0;
        end
    end
    else if(write_en && (!full_flag || read_en)) begin
        FIFO_reg[write_ptr[1:0]] <= write_data;
    end   
end

// Read and write trigger at the same time
logic [3:0]empty_read_write;
logic [3:0]read_data_normal;
assign empty_read_write = write_data;
assign read_data_normal = (read_en && !empty_flag) ? FIFO_reg[read_ptr[1:0]] : 4'b0;

// Read logic
assign read_data = (empty_flag && read_en && write_en) ? empty_read_write : read_data_normal;

endmodule