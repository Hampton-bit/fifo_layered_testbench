class test_writing_when_full extends transaction;
    static int count_n;

    function pre_randomize();
        r_en.rand_mode(0);
        w_en.rand_mode(0);
        r_en=0;
        rst_n=1;
        if(count_n < DEPTH) begin 
            w_en=1;
            count_n++;
            $display("Filling FIFO: write count = %0d", count_n);
        end 
        else begin 
            w_en=1;
            r_en = 0;
            $display("Attempting write when FIFO is full");
        end 



    endfunction
endclass 

program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    test_writing_when_full rt;
    env environment;
   // int trans_driven;

    initial begin 
        rt=new();
        rt.count_n=0;
        //trans_driven=rt.DEPTH+1;

        environment=new(10, f_int);
        $cast(environment.gen.t,rt);

        environment.run();
  
    end 

endprogram