class read_after_write_trans extends transaction;
static bit count_n;

function new(int w_en=0, int r_en=0, int data_in=0, int data_out=0, int full=0, int empty=0, int rst_n=0);

    this.data_in  = data_in;
    this.data_out = data_out;
    this.empty = empty;
    this.full  = full;
    this.rst_n = rst_n;


endfunction


function post_randomize();
    if(count_n==0) begin 
        w_en=1;
        r_en=0;
        rst_n=1;

        count_n=1;
        $display("write");
    end 
    else if(count_n==1) begin 
        r_en=1;
        w_en=0;
        rst_n=1;
        count_n=0;
        data_in=0;
        $display("read");
    end 
 endfunction

endclass 


program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    read_after_write_trans rt;
    env environment;

    initial begin 
        rt=new();
        rt.count_n=0;
        environment=new(12, f_int);
        $cast(environment.gen.t,rt);
        
        
        environment.run();
        
    end 

endprogram