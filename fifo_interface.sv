interface fifo_interface #(parameter DEPTH=8, WIDTH=8) (
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



  // property full_test;
  //   @(negedge clk)
  //   !full && w_en |=> w_en[*DEPTH-1] ##1 full;
  // endproperty
  // assert property(full_test) else $error("FIFO FULL test failed!");

  // property empty_test;
  //   @(negedge clk)
  //   r_en |=> r_en[*0:DEPTH-1] ##1 empty;
  // endproperty
  // assert property(empty_test) else $error("FIFO FULL test failed!");


endinterface : fifo_interface
