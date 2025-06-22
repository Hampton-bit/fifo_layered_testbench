interface fifo_interface #(parameter DEPTH=32, parameter WIDTH=32) (
  input logic clk
);

timeunit 1ns;
timeprecision 1ns;
  logic w_en, r_en;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;
  logic full, empty;
  logic rst_n;

  task reset();

    @(negedge  clk);
    rst_n=0;
    @(negedge  clk);
    rst_n=1;

  endtask

  clocking driver_cb @(negedge clk);
    default output #0;


    // input data_out;
    // input full,empty;

  endclocking 

//   clocking monitor_cb @(posedge clk);
//    default input #0ns;
// ;

//   endclocking 

  modport DRIVER( output w_en,r_en, data_in, input clk, rst_n);

  modport MONITOR(    
  input w_en,r_en
        ,data_in
        ,data_out
        ,full,empty 
        ,clk,rst_n
  );


  // property full_test;
  //   @(posedge clk)
  //   empty&&!full|=> w_en[*DEPTH] ##1 full
  // endproperty    



  property full_test;
    @(posedge clk)
    full && w_en |=>  $stable(full) && !empty;
  endproperty

  assert property(full_test) else $error("FIFO FULL test failed!");

  property empty_test;
    @(posedge clk)
    empty && r_en && !w_en |=> $stable(empty) && !full;
  endproperty

  assert property(empty_test) else $error("FIFO empty test failed!");

  property depth_test;
    @(posedge clk)
    empty && w_en |=> w_en[*DEPTH-1] ##1 full; 
  endproperty

  assert property(depth_test) $display("helll FUCK"); else $error("FIFO depth test failed!");

  //cover property (@(posedge clk) w_en ##1 r_en);

endinterface : fifo_interface
