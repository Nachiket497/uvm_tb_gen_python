

`include "dut_env.sv"
class base_test extends uvm_test;


    `uvm_component_utils(base_test)

    // Handle for environment
    dut_env env;
    
    // Constructor
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // Task: build_phase
    virtual function build_phase (phase phase);
        super.build_phase(phase);
        
        // Create environment
        env = dut_env::type_id::create("env", this);
                
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect the interface
    endfunction

    // Task: run_test
    virtual task run_test();
        phase.raise_objection(this);

        phase.drop_objection(this);
    endtask


endclass
