

class transaction #(parameter DEPTH=8, parameter WIDTH=8);


    //-----------fifo_interface_signals-------------//
    rand bit w_en, r_en;
    rand bit [WIDTH-1:0] data_in;
    rand bit [WIDTH-1:0] data_out;
    rand bit full, empty;
    rand bit rst_n;
    //--------------------------------------------//

    function new(int w_en=0, int r_en=0, int data_in=0, int data_out=0, int full=0, int empty=0, int rst_n=0);

        this.data_in  = data_in;
        this.data_out = data_out;
        this.empty = empty;
        this.full  = full;
        this.rst_n = rst_n;

    endfunction




endclass 
