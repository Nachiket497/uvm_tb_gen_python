// code for uvm_agent

class agnt1 extends uvm_agent;
    `uvm_component_utils(agnt1)
    
    // Declare the sequencer
    agnt1_seqr m_sequencer;
    
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
        m_sequencer = agnt1_seqr::type_id::create("m_sequencer", this);
        if (m_sequencer == null) `uvm_fatal("agnt1", "Error creating m_sequencer")
        
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
        m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        
        // Connect the monitor to the driver
        m_monitor.ap.connect(m_driver.ap);
    endfunction
    
    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        // Start the sequencer
        m_sequencer.start(m_sequencer);
    endtask

endclass

