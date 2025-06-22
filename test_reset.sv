class reset_trans extends transaction;

 function post_randomize();
    rst_n=0;
    r_en=0;
    w_en=0;
    data_in=0;
 endfunction

endclass 


program test(fifo_interface f_int);//.fifo_testBench
    timeunit 1ns;
    timeprecision 1ns;
    reset_trans rt;
    env environment;

    initial begin 
        rt=new();
        environment=new(10, f_int);
        environment.gen.t=rt;
        environment.run();
    end 

endprogram