class timing_trans extends transaction;
static bit count_n;

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
    timing_trans rt;
    env environment;

    initial begin 
        rt=new();
        environment=new(DEPTH, f_int);
        environment.gen.t=rt;
        environment.run();
    end 

endprogram