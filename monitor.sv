class monitor;
transaction t;
virtual fifo_interface vif;
mailbox mon_scb;

function new(mailbox mon_scb, virtual fifo_interface vif);
    this.vif=vif;
    this.mon_scb=mon_scb;
    t=new();
endfunction

task run();

    forever begin 
        @(posedge vif.clk);
        #2ns;
        t=new();
        
        // Capture all interface signals

        t.data_in  = vif.data_in;
        t.data_out = vif.data_out;
        t.empty    = vif.empty;
        t.full     = vif.full;
        t.rst_n    = vif.rst_n;
        // if (t.data_out === 'x) begin
        //     $fatal("[%0t] WARNING: Read uninitialized memory at address %0d", $time, t.addr);
        // end
        // $display("[%0t] Monitor: received Addr=%0d, DataIn=%h, DataOut=%h Write=%b, Read=%b", $time, t.addr, t.data_in, t.data_out, t.write, t.read);
        mon_scb.put(t);
    end 

endtask

endclass 