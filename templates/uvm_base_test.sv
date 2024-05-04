

import struct_pkg::*;

`include "sub_sys_name_env.sv"

class sub_sys_name_base_test extends uvm_test;
    
    `uvm_component_utils(sub_sys_name_base_test)

    env_name env_name_h;
    
    // Declare intf handles
    virtual clk_reset_if clk_reset_intf;


    // Declare sequence handles

    function new(string name = "sub_sys_name_base_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get all intf
        if(!uvm_config_db#(virtual clk_reset_if)::get(this,"*",$sformatf("clk_reset_if"), clk_reset_intf))
            `uvm_error("base_test", "not able to get clk reset interface")


        // Create all sequences
    endfunction
    
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
