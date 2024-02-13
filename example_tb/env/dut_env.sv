// include uvm pkg and agents files
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "agnt_pkg.sv"

import uvm_pkg::*;
import agnt_pkg::*;

class dut_env extends uvm_env;
    `uvm_component_utils(dut_env)

    // Declare the agents
    agnt1 agnt1_h;
    agnt2 agnt2_h;
   
    // Constructor
    function new(string name = "dut_env", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create the agents
    agnt1_h = agnt1::type_id::create("agnt1_h", this);
    agnt2_h = agnt2::type_id::create("agnt2_h", this);

    endfunction
    
    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        // Connect the agents


    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
