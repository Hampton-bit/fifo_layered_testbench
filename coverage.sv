class coverage#(parameter WIDTH=8, DEPTH=8);

    virtual fifo_interface vif;

    int data_in;
    bit full, empty;
    covergroup cg;
        option.per_instance = 1;
        data_range: coverpoint data_in{
                    bins low = { [0: (2**WIDTH/4-1)]};
                    bins mid = { [(2**WIDTH/4) : (2**WIDTH/2-1)]};
                    bins high ={ [(2**WIDTH/2) : (2**WIDTH-1  )]};
                    }
        gets_full: coverpoint vif.full{
            bins e_low2high= (0=>1);
        }
        gets_empty: coverpoint vif.empty{
            bins f_low2high= (0=>1);
        }
        // read_after_write: coverpoint vif.r_en{
        //     bins w_r= ()
        // }
        // read_after_write_cp : cover property (
        //     vif.w_en ##1 vif.r_en
        // );
    endgroup

    function new(virtual fifo_interface vif);
        this.vif=vif;
        cg=new();
        data_in=vif.data_in;
        full=vif.full;
        empty=vif.empty;
    endfunction


endclass 