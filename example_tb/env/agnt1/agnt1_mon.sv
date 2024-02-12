// code for uvm_monitor

class agnt1_mon extends uvm_monitor #(agnt_seq_item);
    `uvm_component_utils(agnt1_mon)
    
    // Declare the interface
    

    #uvm_analysis_port #(agnt_seq_item) ap;
    agnt_seq_item trns;
    
    // Constructor
    function new(string name = "agnt1_mon", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("agnt1_ap", this);
        // Get the interface using uvm config db
    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            // Sample the interface
            // Compare the sampled data with the expected data
            // If there is a mismatch, report an error
            // Wait for a while
        end
    endtask
