// include uvm pkg and agents files
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "agnt_pkg.sv"
import uvm_pkg::*;
import agnt_pkg::*;

`include "sub_system_name_scoreboard.sv"

class env_name extends uvm_env;
    `uvm_component_utils(env_name)
    
    sub_system_name_scoreboard sub_system_name_scoreboard_h;

    // Declare the agents
    
    // Declare intf handles
   
    // Constructor
    function new(string name = "env_name", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create the agents

        // Get all intf
    endfunction
    
    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        // Connect the intf 

        // Connect the agents


    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
