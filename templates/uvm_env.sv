// include uvm pkg and agents files
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "agnt_pkg.sv"

import uvm_pkg::*;
import agnt_pkg::*;

class env_name extends uvm_env;
    `uvm_component_utils(env_name)

    // Declare the agents
   
    // Constructor
    function new(string name = "env_name", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create the agents

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
