// code for uvm_monitor

class agnt_name_mon extends uvm_monitor;
    `uvm_component_utils(agnt_name_mon)
    
    // Declare intf handles
    

    uvm_analysis_port #(agnt_name_seq_item) ap;
    agnt_name_seq_item req;
    
    // Constructor
    function new(string name = "agnt_name_mon", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("agnt_name_ap", this);
        req = agnt_name_seq_item::type_id::create("req");
        // Get the interface using uvm config db
    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            @(posedge agnt_name_intf_h.clk);
            // Sample the interface
            // Compare the sampled data with the expected data
            // If there is a mismatch, report an error
            // Wait for a while
        end
    endtask
endclass
