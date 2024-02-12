// code for uvm_driver

class agnt_name_driver extends uvm_driver #(agnt_name_seq_item);
    `uvm_component_utils(uvm_driver)
    
    // Declare intf handles

    // Declare a seq item handle
    agnt_name_seq_item req;

    // Constructor
    function new(string name = "uvm_driver", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // get all intf using uvm config db
        
    endfunction
    
    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        seq_item_port.get_next_item(req);
        drive();
        seq_item_port.item_done(); 

    endtask

    task drive();

    endtask

endclass
