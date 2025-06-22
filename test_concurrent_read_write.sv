class concurrent_read_write extends transaction;

 function pre_randomize();
    r_en.rand_mode(0);
    w_en.rand_mode(0);
    rd_wr.constraint_mode(0);

        rst_n=1;
        r_en=1;
        w_en=1;

        $display("Concurrent read write fifo");

endfunction

endclass 


program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    concurrent_read_write rt;
    env environment;

    initial begin 
        rt=new();
        environment=new(12, f_int);
        $cast(environment.gen.t,rt);
        
        
        environment.run();
        
    end 

endprogram