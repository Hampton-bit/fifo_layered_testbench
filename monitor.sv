`define MON_IF vif.MONITOR.monitor_cb
class monitor;
transaction t;
virtual fifo_interface vif;
mailbox mon_scb;
int count;

function new(mailbox mon_scb, virtual fifo_interface vif, int count);
    this.vif=vif;
    this.mon_scb=mon_scb;
    this.count=count;
    t=new();
endfunction

task run();

    forever begin 
       @(posedge vif.clk);
       
       //#2ns;
    //    if(!vif.rst_n) continue;
        // @(posedge vif.clk);
        // #2ns;
        // t=new();
        
        // Capture all interface signals

        t.data_in  = `MON_IF.data_in;
        t.data_out = `MON_IF.data_out;
        t.empty    = `MON_IF.empty;
        t.full     = `MON_IF.full;
    
        t.r_en     = `MON_IF.r_en;
        t.w_en     = `MON_IF.w_en;
        //@(posedge vif.clk);

        // if (t.data_out === 'x) begin
        //     $fatal("[%0t] WARNING: Read uninitialized memory at address %0d", $time, t.addr);
        // end
        $display("[%0t][%0d] Monitor: DataIn=%h, Data_out=%h, r_en=%d, w_en=%d, rst_n=%d, full=%b, empty=%b", $time,count, t.data_in, t.data_out, t.r_en, t.w_en, t.rst_n, t.full, t.empty);
        mon_scb.put(t.clone());
        count++;
    end 

endtask

endclass 