class scoreboard; 
transaction t1,t2, gen, mon;
//transaction t2;

mailbox mon_scb;
mailbox gen_scb;
// mailbox drv_scb;

int txns_received;
int gen_txns_received;

int ref_model [$];
int expected;
// typedef struct {
//   int data;
//   int ref_model;
// } error_data_t;
// error_data_t error_list[$];

int error_count;
event scb_ended;
int repeat_count;
int mon_transmitted;
function new(mailbox mon_scb, gen_scb, event scb_ended, int repeat_count, int mon_transmitted );
    this.mon_scb=mon_scb;
    this.gen_scb=gen_scb;
    // this.drv_scb=drv_scb;
    

    this.scb_ended=scb_ended;
    this.repeat_count=repeat_count;
    this.mon_transmitted=mon_transmitted;
    // t1=new();
    // t2=new();
endfunction

task run();
    //txns_received=0;
    forever begin 
        // t1=new();  //gen
        // t2=new();  //mon
        //$dis
        // bit got_gen_scb, got_mon_scb;
    //if (gen_scb.num() > 0) begin
        #10ns;
        gen_scb.get(t1);
        gen=t1.clone();
        // if(got_gen_scb) begin 
            if(gen.w_en) begin 
                ref_model.push_back(gen.data_in);
            end 
    //end 
        // got_mon_scb=
    //if (mon_scb.num() > 0) begin
        mon_scb.get(t2);
        mon=t2.clone();
        if(!mon.rst_n) begin 
            if(!mon.full && !mon.data_out) begin 
                $display("reset test passed");
                
            end
            else begin 
                $display("reset test failed");
                error_count++;
            end
        
        end
        // if(got_mon_scb) begin 
        if(mon.r_en) begin   
            expected=ref_model.pop_front();
            if(mon.data_out != expected) begin 
                    
                error_count++;
                    // error_list.data=t2.data_in;
                    // error_list[t2.addr].ref_model=ref_model[t2.addr];
                $display("Mismatch | fifo: %h | ref_model: %0h ",mon.data_out, expected);
                 
            end
            else begin 

                $display("Match | fifo: %h | ref_model: %0h ",mon.data_out, expected);

            end
        end

        txns_received++;
        
       // $display("[%0t][%0d] Scoreboard[mon]: DataIn=%h, Data_out=%h, r_en=%d, w_en=%d, rst_n=%d, full=%b, empty=%b ", $time, txns_received,mon.data_in, mon.data_out, mon.r_en, mon.w_en, mon.rst_n, mon.full, mon.empty);
    //end 
        // $display("mon_scb.num()=%0d | gen_scb.num()=%0d",mon_scb.num(),gen_scb.num());

        if(txns_received >= repeat_count && mon_scb.num()==0 && gen_scb.num()==0) begin 
            if(!error_count) 
            begin
                $display("Test Passed");

            end
        
            else  begin 
                $display("Test Failed with %0d erorrs", error_count);
                // foreach(error_list[i]) begin 
                //     $display("error  | address: %0d\t| data : %0d\t| ref_model: %0d ", i, error_list[i].data,error_list[i].ref_model);
                // end 
            
            end
            //->scb_ended;
        end 
        
    end 
    #1;


endtask 

endclass 
