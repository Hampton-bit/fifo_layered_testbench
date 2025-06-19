class scoreboard; 
transaction t1;
transaction t2;

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
function new(mailbox mon_scb, gen_scb, event scb_ended, int repeat_count );
    this.mon_scb=mon_scb;
    this.gen_scb=gen_scb;
    // this.drv_scb=drv_scb;

    this.scb_ended=scb_ended;
    this.repeat_count=repeat_count;
    t1=new();
    t2=new();
endfunction

task run();
    forever begin 
        t1=new();  //gen
        t2=new();  //mon
        // bit got_gen_scb, got_mon_scb;
        gen_scb.get(t1);
        // if(got_gen_scb) begin 
            if(t1.w_en) begin 
                ref_model.push_back(t1.data_in);
            end 
        // end 
        // got_mon_scb=
        mon_scb.get(t2);
        // if(got_mon_scb) begin 
            if(t2.r_en) begin   
                expected=ref_model.pop_front();
                if(t2.data_out != expected) begin 
                    
                    error_count++;
                    // error_list.data=t2.data_in;
                    // error_list[t2.addr].ref_model=ref_model[t2.addr];
                    $display("Mismatch | fifo: %h | ref_model: %0h ",t2.data_out, expected);
                 
                end
            end

        txns_received++;
        
        $display("[%0t] Scoreboard[mon]: DataIn=%h, Data_out=%b, full=%b, empty=%b", $time, t2.data_in, t2.data_out, t2.full, t2.empty);
        // end 
        
        if(txns_received >= repeat_count) begin 
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
            ->scb_ended;
        end 
        
    end 
    #1;


endtask 

endclass 
