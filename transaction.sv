class transaction #(parameter DEPTH=16, parameter WIDTH=16);
    // int low_max  = 2**WIDTH / 4 - 1;
    // int mid_min  = 2**WIDTH / 4;
    // int mid_max  = 2**WIDTH / 2 - 1;
    // int high_min = 2**WIDTH / 2;
    // int high_max = 2**WIDTH - 1;

    //-----------fifo_interface_signals-------------//
    rand bit w_en, r_en;
    rand bit [WIDTH-1:0] data_in;
    bit [WIDTH-1:0] data_out;
    bit full, empty;
    bit rst_n;
    //--------------------------------------------//



    constraint rd_wr{
        !(r_en && w_en);
        rst_n-> r_en!=w_en;
    }
    // constraint rst{
    //     rst_n !=0;
    // }

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


    constraint data_range {
        data_in dist {
            [0: (     2**WIDTH/4-1       )] := 20,
            [(2**WIDTH/4) : (2**WIDTH/2-1)] := 20,
            [(2**WIDTH/2) : (2**WIDTH-1  )] := 20
        };
    }

    // covergroup cg;
    //     data_range: coverpoint data_in{
    //         bins low = {[0: (2**WIDTH/4-1)]};
    //         bins mid = { [(2**WIDTH/4) : (2**WIDTH/2-1)]};
    //         bins high ={ [(2**WIDTH/2) : (2**WIDTH-1  )]};
    //     }
    
    // endgroup
    

    function transaction clone();
        clone= new();
        clone.copy(this);
        
    endfunction

    function new(int w_en=0, int r_en=0, int data_in=0, int data_out=0, int full=0, int empty=0, int rst_n=0);

        this.data_in  = data_in;
        this.data_out = data_out;
        this.empty = empty;
        this.full  = full;
        this.rst_n = rst_n;
        //cg=new();
        //this.w_en=1;

    endfunction

endclass 
