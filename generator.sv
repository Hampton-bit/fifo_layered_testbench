class generator;

transaction t;
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
   
    repeat(repeat_count) begin 

        // t.cover_alpha.start();
        t= new();
            
        assert(t.randomize()) else $fatal("randomization failed");
        $display("[%0t] Generator: DataIn=%h, Data_out=%b, full=%b, empty=%b", $time, t.data_in, t.data_out, t.full, t.empty);
        // t.cover_alpha.sample();
        gen_drv.put(t);
        gen_scb.put(t);

        // t.cover_alpha.stop();

    end
    $display("generator ended");
    ->gen_ended;
    
endtask 

endclass 