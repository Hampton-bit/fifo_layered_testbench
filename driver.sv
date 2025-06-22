`define DRIV_IF vif.DRIVER
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
        // #1;
        gen_drv.get(t_rx);
        t=t_rx.clone();
        // drv_scb.put(t);    
        // if(got_t) begin
        //@(negedge vif.clk);
        // $display("driver started2");

        @(negedge vif.clk);       
        if(!t.rst_n) begin 
            vif.rst_n= t.rst_n;
            $display("rst_n value=%0d", vif.rst_n);
        end 
        if(t.w_en) begin 
            `DRIV_IF.w_en     <=t.w_en;
            `DRIV_IF.r_en     <=t.r_en;
            `DRIV_IF.data_in  <=t.data_in;
             
        end 
        else if(t.r_en) begin 
            `DRIV_IF.w_en<=t.w_en;
            `DRIV_IF.r_en<=t.r_en;
        end 
        $display("[%0t][%0d] Driver:  DataIn=%h, Data_out=%h, r_en=%d, w_en=%d, rst_n=%d", $time, (txns_received+1), t.data_in, t.data_out, t.r_en, t.w_en, t.rst_n);

       

        txns_received++;

    end 
endtask
endclass 