class mem_monitor extends uvm_monitor;
  virtual mem_if vif;
  uvm_analysis_port #(mem_seq_item) item_collected_port;
   mem_seq_item trans_collected;

  `uvm_component_utils(mem_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);
      wait(vif.monitor_cb.w_en || vif.monitor_cb.r_en);
        trans_collected.addr = vif.monitor_cb.addr;
      if(vif.monitor_cb.w_en) begin
        trans_collected.w_en = vif.monitor_cb.wr_en;
        trans_collected.wdata = vif.monitor_cb.wdata;
        trans_collected.r_en = 0;
        @(posedge vif.MONITOR.clk);
      end
      if(vif.monitor_cb.r_en) begin
        trans_collected.r_en = vif.monitor_cb.rd_en;
        trans_collected.w_en = 0;
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        trans_collected.rdata = vif.monitor_cb.rdata;
      end
	  item_collected_port.write(trans_collected);
      end 
  endtask : run_phase

endclass : mem_monitor

