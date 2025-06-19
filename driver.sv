class driver;

transaction t;
mailbox gen_drv;
// mailbox drv_scb;

virtual fifo_interface vif;
int txns_received;

function new(mailbox gen_drv, virtual fifo_interface vif);
    this.gen_drv= gen_drv;
    // this.drv_scb=drv_scb;
    this.vif=vif;  
    txns_received=0; 
    t=new();
endfunction

task run();
    forever begin 
        $display("driver started");
        t=new();
        
        gen_drv.get(t);
        // drv_scb.put(t);    
        // if(got_t) begin
        @(negedge vif.clk);
        $display("driver started2");
        
        vif.w_en=t.w_en;
        vif.r_en=t.r_en;

        vif.data_in  =t.data_in;
        vif.data_out =t.data_out;

        vif.rst_n = t.rst_n;  

        @(posedge vif.clk);
        $display("[%0t] Driver: DataIn=%h, Data_out=%b, full=%b, empty=%b", $time, t.data_in, t.data_out, t.full, t.empty);

        txns_received++;
        
       
    end 
endtask
endclass 