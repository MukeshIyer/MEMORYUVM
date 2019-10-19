`include "intf.sv"
`include "mem_test.sv"
`include "mem_wr_rd_test.sv"

 module tbench_top;

  bit clk;
  bit rst;
  
  
  always #5 clk = ~clk;
  
    initial begin
    rst = 1;
    #5 rst =0;
  end
  
    mem_if intf(clk,rst);
  
  memory DUT (
    .clk(intf.clk),
    .rst(intf.reset),
    .addr(intf.addr),
    .w_en(intf.w_en),
    .r_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  

  initial begin 
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","vif",intf);

    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
 initial begin 
    run_test();
  end
  
endmodule
