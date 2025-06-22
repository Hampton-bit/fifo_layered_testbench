class test_reading_when_empty extends transaction;
    static bit count_n;

    function pre_randomize();
        r_en.rand_mode(0);
        w_en.rand_mode(0);
        w_en=0;
        //rst_n=1;
        if(count_n==0) begin 
            rst_n=0;
            count_n++;
            $display("Reseting fifo", count_n);
        end 


        else begin 
            rst_n=1;
            r_en=1;
            // $display("count=%0d", count_n);
            // $display("Attempting read when FIFO is empty");
        end 
    


    endfunction
endclass 

program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    test_reading_when_empty rt;
    env environment;
   // int trans_driven;

    initial begin 
        rt=new();
        rt.count_n=0;
        //trans_driven=rt.DEPTH+1;

        environment=new(12, f_int);
        $cast(environment.gen.t,rt);

        environment.run();
  
    end 

endprogram