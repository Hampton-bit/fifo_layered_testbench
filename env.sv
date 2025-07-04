class env;

    virtual fifo_interface  vif;

    mailbox gen_drv;
    mailbox gen_scb; 
    mailbox mon_scb;

    // mailbox drv_scb;

    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;

    coverage #(32,32) c ;


    event gen_ended;
    event scb_ended;

    int repeat_count;
    int mon_transmitted;

    function new(int repeat_count, virtual fifo_interface vif);
        gen_drv = new();
        gen_scb = new();
        mon_scb = new();
        // drv_scb=new();
        c=new(vif);
 
        this.vif = vif;
        this.repeat_count = repeat_count;
        
        gen = new(gen_drv, gen_scb, repeat_count, gen_ended);
        drv = new(gen_drv, vif);
        mon = new(mon_scb, vif, mon_transmitted);
        scb = new(mon_scb, gen_scb, scb_ended, repeat_count, mon_transmitted);

    endfunction

    task sample_coverage();
        forever begin 
            @(posedge vif.clk);
            #1ns;
            c.cg.sample();
            $display("[%0t] Sampling coverage: data_in = %h", $time, vif.data_in);
        end 
    endtask

    task pre_test();

            vif.reset();
            @(posedge vif.clk);

    endtask

    task test();

        fork 
            gen.run();
            drv.run();
            mon.run();
            scb.run();
            sample_coverage();
        join_any
 
    endtask 

    task post_test();
        wait(gen_ended.triggered);
        //@(gen_ended);
        
        wait(drv.txns_received == repeat_count && scb.txns_received == repeat_count);

    endtask 

    task run();
        pre_test();
        test();
        post_test();
        $finish;
    endtask 

endclass 