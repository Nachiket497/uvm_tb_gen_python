

import struct_pkg::*;

`include "cere_noc_env.sv"

class cere_noc_base_test extends uvm_test;

`uvm_component_utils(cere_noc_base_test)

cere_noc_env cere_noc_env_h;

// Declare intf handles
virtual axi_narrow_intf axi_narrow_intf_h;
virtual axi_wide_intf axi_wide_intf_h;
virtual clk_reset_if clk_reset_intf;


// Declare sequence handles
axi_narrow_sequence axi_narrow_sequence_h;
axi_wide_sequence axi_wide_sequence_h;

    function new(string name = "cere_noc_base_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction: new

// Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

// Get all intf
       if(!uvm_config_db#(virtual axi_narrow_intf)::get(this,"*",$sformatf("axi_narrow_intf"), axi_narrow_intf_h))
`uvm_error("base test", "not able to get axi_narrow interface")
       if(!uvm_config_db#(virtual axi_wide_intf)::get(this,"*",$sformatf("axi_wide_intf"), axi_wide_intf_h))
`uvm_error("base test", "not able to get axi_wide interface")
        if(!uvm_config_db#(virtual clk_reset_if)::get(this,"*",$sformatf("clk_reset_if"), clk_reset_intf))
`uvm_error("base_test", "not able to get clk reset interface")


// Create all sequences
axi_narrow_sequence_h = axi_narrow_sequence::type_id::create("axi_narrow_sequence_h", this);
axi_wide_sequence_h = axi_wide_sequence::type_id::create("axi_wide_sequence_h", this);
    endfunction


// Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
