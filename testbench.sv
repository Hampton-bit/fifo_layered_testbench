module top;


env environment;

// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;
localparam depth=8;
localparam width=8;
// SYSTEMVERILOG: logic and bit data types
logic  clk;


//memory interface instantiation 
fifo_interface        #(.DEPTH(depth),.WIDTH(width))       f_int   (clk);

synchronous_fifo #(
                    .DEPTH(depth), .DATA_WIDTH(width)) 
                    fifo1 
                    (.clk(clk), 
                    .rst_n(f_int.rst_n), .w_en(f_int.w_en), .r_en(f_int.r_en), 
                    .data_in(f_int.data_in), .data_out(f_int.data_out), .full(f_int.full), 
                    .empty(f_int.empty)
                  );

test t1(.f_int);
initial begin clk=0; end 
always #5 clk = ~clk;


endmodule


