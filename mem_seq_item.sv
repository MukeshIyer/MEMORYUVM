class mem_seq_item extends uvm_sequence_item;
rand bit [6:0]addr;
rand bit w_en;
rand bit r_en;
rand bit [7:0]wdata;
     bit [7:0]rdata;
`uvm_object_utils_begin(mem_seq_item)
`uvm_field_int(addr,UVM_ALL_ON)
`uvm_field_int(w_en,UVM_ALL_ON)
`uvm_field_int(r_en,UVM_ALL_ON)
`uvm_field_int(wdata,UVM_ALL_ON)
`uvm_object_utils_begin(mem_seq_item)

function new(string name="mem_seq_item");
	super.new(name);
endfunction


constraint rd_wr{
w_en!=r_en};
endclass
