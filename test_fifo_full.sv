class test_fifo_full extends transaction;
static bit count_n;


function pre_randomize();
    r_en.rand_mode(0);
    w_en.rand_mode(0);
    r_en = 0;
    w_en = 1;
endfunction

// function post_randomize();
//     if(empty!=1)  begin 
//         w_en=0;
//         r_en=1;
//         rst_n=1;


//         $display("write");

//     end
//     if(count_n!=DEPTH) begin 
//         w_en=1;
//         r_en=0;
//         rst_n=1;

//         count_n++;
//         $display("write");
//     end 

//  endfunction


endclass 


program test(fifo_interface f_int);//.fifo_testBench

    timeunit 1ns;
    timeprecision 1ns;
    test_fifo_full rt;
    env environment;

    initial begin 
        rt=new();
        rt.count_n=0;
        environment=new(35, f_int);
        $cast(environment.gen.t,rt);
        
        
        environment.run();
        // if(rt.count_n==rt.DEPTH) begin 
        //     if(rt.full==1 && rt.empty==0) begin
        //         $display("FIFO_FULL Test passed");
        //     end
        //     else begin 
        //         $display("FIFO_FULL Test passed");
    
        //     end 
        // end 
        
        
    end 

endprogram