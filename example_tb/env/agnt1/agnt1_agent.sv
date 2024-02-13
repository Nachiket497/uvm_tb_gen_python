// code for uvm_agent

class agnt1 extends uvm_agent;
    `uvm_component_utils(agnt1)
    
    // Declare the sequencer
    agnt1_seqr m_seqr;
    
    // Declare the driver
    agnt1_driver m_driver;
    
    // Declare the monitor
    agnt1_mon m_monitor;
    
    // Constructor
    function new(string name = "agnt1", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create the sequencer
        m_seqr = agnt1_seqr::type_id::create("m_seqr", this);
        if (m_seqr == null) `uvm_fatal("agnt1", "Error creating m_seqr")
        
        // Create the driver
        m_driver = agnt1_driver::type_id::create("m_driver", this);
        if (m_driver == null) `uvm_fatal("agnt1", "Error creating m_driver")
        
        // Create the monitor
        m_monitor = agnt1_mon::type_id::create("m_monitor", this);
        if (m_monitor == null) `uvm_fatal("agnt1", "Error creating m_monitor")
    endfunction
    
   // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect the sequencer to the driver
        m_driver.seq_item_port.connect(m_seqr.seq_item_export);
        
    endfunction
    
   

endclass

