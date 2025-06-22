class generator;

transaction t, t_tx;
mailbox gen_drv;
mailbox gen_scb;
int repeat_count;
event gen_ended;


function new(mailbox gen_drv, gen_scb, int repeat_count, event gen_ended);

    this.gen_drv=gen_drv;
    this.gen_scb= gen_scb;
    this.repeat_count=repeat_count;
    this.gen_ended= gen_ended;
    t= new();

endfunction

task run();
int count = 0;
   
    repeat(repeat_count) begin 

        //t.cg.start();
        //t=new();
    
        
        assert(t.randomize()) else $fatal("randomization failed");
        $display("[%0t][%0d] Generator: DataIn=%h, Data_out=%h, r_en=%d, w_en=%d, rst_n=%d, full=%b, empty=%b", $time, (count+1), t.data_in, t.data_out, t.r_en, t.w_en, t.rst_n, t.full, t.empty);
        //t.cg.sample();
        t_tx=t.clone(); 
        gen_drv.put(t_tx);
        gen_scb.put(t_tx);
        count +=1;

       // t.cg.stop();

    end
    $display("generator ended");
    ->gen_ended;
    
endtask 

endclass 