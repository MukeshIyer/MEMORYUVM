interface intf(input bit clk,rst);
logic w_en;
logic r_en;
logic en;
logic [7:0]wdata;
logic [6:0]addr;
logic ready;
logic [7:0]rdata;
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output addr;
    output w_en;
    output r_en;
    output wdata;
    input  rdata;  
  endclocking
	input ready;
	input rdata;
endclocking

clocking monitor_cb@(posedge clk);

	input wdata;
	input addr;
	input wdata;
	input addr;
	input ready;
	input rdata;

endclocking

modport MONITOR(clocking monitor_cb,input clk,rst);
endinterface
