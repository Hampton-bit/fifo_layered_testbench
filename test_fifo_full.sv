class read_after_write_trans extends transaction;
static bit count_n;



function post_randomize();
    if(count_n!=DEPTH) begin 
        w_en=1;
        r_en=0;
        rst_n=1;

        count_n++;
        $display("write");
    end 
    else if(count_n==DEPTH) begin 
        if()
    end 
 endfunction

endclass 


program test_read_after_write(fifo_interface f_int);//.fifo_testBench

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