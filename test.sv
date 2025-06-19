program test(fifo_interface f_int);//.fifo_testBench
    timeunit 1ns;
    timeprecision 1ns;

    env environment;

    initial begin 
        environment=new(5000, f_int);
        environment.run();
    end 

endprogram