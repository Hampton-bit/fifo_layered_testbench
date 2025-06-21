class test_fifo_empty extends transaction;
    static bit count_n;

    function pre_randomize();
        r_en.rand_mode(0);
        w_en.rand_mode(0);
        r_en = 1;
        w_en = 0;
    endfunction

endclass 

program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    test_fifo_empty rt;
    env environment;

    initial begin 
        rt=new();
        rt.count_n=0;
        environment=new(12, f_int);
        $cast(environment.gen.t,rt);      
        environment.run();
   
    end 

endprogram