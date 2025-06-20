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

  modport fifo(input w_en,r_en, data_in, clk, rst_n, output data_out, full, empty);
  modport fifo_testBench(output w_en,r_en, data_in, input data_out, full, empty, clk, rst_n);
  modport fifo_test_monitor(output w_en,r_en, data_in, data_out, full, empty, clk, rst_n);

endinterface : fifo_interface
