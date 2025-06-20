class transaction #(parameter DEPTH=8, parameter WIDTH=8);


    //-----------fifo_interface_signals-------------//
    rand bit w_en, r_en;
    rand bit [WIDTH-1:0] data_in;
    bit [WIDTH-1:0] data_out;
    bit full, empty;
    rand bit rst_n;
    //--------------------------------------------//

    function new(int w_en=0, int r_en=0, int data_in=0, int data_out=0, int full=0, int empty=0, int rst_n=0);

        this.data_in  = data_in;
        this.data_out = data_out;
        this.empty = empty;
        this.full  = full;
        this.rst_n = rst_n;
        //this.w_en=1;

    endfunction

    constraint rd_wr{
        !(r_en && w_en);
        r_en!=w_en;
    }
    constraint rst{
        rst_n !=0;
    }

    // constraint
    function void copy(transaction txn);
        this.w_en     =txn.w_en;
        this.r_en     =txn.r_en;
        this.data_in  =txn.data_in;
        this.data_out =txn.data_out;
        this.full     =txn.full;
        this.empty    =txn.empty;
        this.rst_n    =txn.rst_n;
    endfunction

    function transaction clone();
        clone= new();
        clone.copy(this);
    endfunction

endclass 
