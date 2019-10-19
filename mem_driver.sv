`define DRIV_IF vif.DRIVER.driver_cb

class mem_driver extends uvm_driver #(mem_seq_item);
  virtual mem_if vif;
  `uvm_component_utils(mem_driver)
     
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  virtual task drive();
    `DRIV_IF.w_en <= 0;
    `DRIV_IF.r_en <= 0;
    @(posedge vif.DRIVER.clk);
    
    `DRIV_IF.addr <= req.addr;
    //WRITE
    if(req.w_en) begin 
      `DRIV_IF.w_en <= req.wr_en;
      `DRIV_IF.wdata <= req.wdata;
      @(posedge vif.DRIVER.clk);
    end
    //READ
    else if(req.r_en) begin 
      `DRIV_IF.r_en <= req.rd_en;
      @(posedge vif.DRIVER.clk);
      `DRIV_IF.r_en <= 0;
      @(posedge vif.DRIVER.clk);
      req.rdata = `DRIV_IF.rdata;
    end
    
  endtask : drive
endclass : mem_driver
