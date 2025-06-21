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

  clocking driver_cb @(posedge clk);
   //default input #1 output #2;
    output w_en,r_en;
    output data_in;

   // input data_out;
    //input full,empty;

  endclocking 

  clocking monitor_cb @(posedge clk);
    default input #1ns;
    input w_en,r_en;
    input data_in;
    input data_out;
    input full,empty;

  endclocking 

  modport DRIVER(clocking driver_cb, input clk, rst_n);
  modport MONITOR(clocking monitor_cb, input clk,rst_n);


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
