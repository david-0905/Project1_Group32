`timescale 1ns/1ps
module tb();
  logic clk;
  logic rstN;
  logic write_en;
  logic read_en;
  logic [3:0] write_data;
  logic [3:0] read_data;
  logic full;
  logic empty;

  logic [3:0] queue_model [$];

  // Instantiate the FIFO module
  FIFO u_fifo (
    .clk(clk),
    .rstN(rstN),
    .write_en(write_en),
    .read_en(read_en),
    .write_data(write_data),
    .read_data(read_data),
    .full(full),
    .empty(empty)
  );


  //Clock Generation (100MHz)
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  //Test sequence
  initial begin
    rstN = 0;
    write_en = 0;
    read_en = 0;
    write_data = 4'd0;
    #20;
    rstN = 1;
    fork
      write_operation();
      read_operation();
      monitor();
      begin
        #2000000;
        $display("Test Completed");
        $finish;
      end
    join_none
  end

  //dump fsdb
  initial begin
    $fsdbDumpfile("fifo.fsdb");
    $fsdbDumpvars("+all");
  end

  //testing task
  task automatic write_operation();
    forever begin
      repeat($urandom_range(1,5)) @(posedge clk); 
        write_en <= 1;
        write_data <= $urandom_range(0, 15); // unsigned 4bit data, range from  0  to  15
        @(posedge clk);
        write_en <= 0;

        //Push data to queue
        if(write_en && (!full || read_en)) begin
          queue_model.push_back(write_data);
        end

    end 
  endtask

  task automatic read_operation();
    forever begin
      repeat($urandom_range(1,5)) @(posedge clk); 
      read_en <= 1;
      @(posedge clk);
      read_en <= 0;
    end
  endtask

  task automatic monitor();
    forever begin
      @(posedge clk);
      if(read_en && (!empty || write_en)) begin
        if(queue_model.size() == 0) begin
          $display("Underflow detected");
          $fatal;
        end else begin
          logic [3:0] expected_data = queue_model.pop_front();
          if(expected_data != read_data) begin
            $display("Data Mismatch: Got %0d, Expected %0d", read_data, expected_data);
            $fatal;
          end else begin
            $display("Data Matched: %0d", read_data);
          end
        end 
      end else if(queue_model.size() == 5) begin
          $display("Overflow detected");
          $fatal;
      end
    end
  endtask
endmodule
