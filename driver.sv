class driver;

transaction t;
transaction t_rx;
mailbox gen_drv;
// mailbox drv_scb;

virtual fifo_interface vif;
int txns_received;

function new(mailbox gen_drv, virtual fifo_interface vif);
    this.gen_drv= gen_drv;
    // this.drv_scb=drv_scb;
    this.vif=vif;  
    txns_received=0; 
    t_rx=new();
endfunction

task run();
    $display("driver started");
    //vif.reset();
    txns_received=0;
    //#20ns;
    forever begin 
        
        //t=new();
        // if(!vif.rst_n) continue;
        #1;
        gen_drv.get(t_rx);
        t=t_rx.clone();
        // drv_scb.put(t);    
        // if(got_t) begin
        //@(negedge vif.clk);
        // $display("driver started2");
        
        vif.w_en=t.w_en;
        vif.r_en=t.r_en;

        vif.data_in  =t.data_in;
        // vif.data_out =t.data_out;

        vif.rst_n = t.rst_n;  
        // $display("[%0t][%0d] Driver:          DataIn=%h, Data_out=%h, r_en=%d, w_en=%d, rst_n=%d, full=%b, empty=%b", $time, txns_received, t.data_in, t.data_out, t.r_en, t.w_en, t.rst_n, t.full, t.empty);

        @(negedge vif.clk);

        txns_received++;

    end 
endtask
endclass 