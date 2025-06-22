class timing_trans extends transaction;
static bit count_n;

    function post_randomize();
        if(count_n<DEPTH) begin 
            w_en=1;
            r_en=0;
            rst_n=1;

            count_n++;
            $display("write");
        end 
        else if(count_n==DEPTH) begin 
            r_en=1;
            w_en=0;
            rst_n=1;
            
            data_in=0;
            $display("read");
        end 
    endfunction

endclass 

program test(fifo_interface f_int);//.fifo_testBench
    timeunit 1ns;
    timeprecision 1ns;
    timing_trans rt;
    env environment;
    int  d_1;

    initial begin 
        rt=new();
        d_1=f_int.DEPTH+1;
        environment=new(d_1, f_int);
        environment.gen.t=rt;
        environment.run();
    end 

endprogram