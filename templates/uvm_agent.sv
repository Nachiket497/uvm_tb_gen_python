// code for uvm_agent

class agnt_name extends uvm_agent;
    `uvm_component_utils(agnt_name)
    
    // Declare the sequencer
    agnt_name_seqr m_sequencer;
    
    // Declare the driver
    agnt_name_driver m_driver;
    
    // Declare the monitor
    agnt_name_mon m_monitor;
    
    // Constructor
    function new(string name = "agnt_name", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create the sequencer
        m_sequencer = agnt_name_seqr::type_id::create("m_sequencer", this);
        if (m_sequencer == null) `uvm_fatal("agnt_name", "Error creating m_sequencer")
        
        // Create the driver
        m_driver = agnt_name_driver::type_id::create("m_driver", this);
        if (m_driver == null) `uvm_fatal("agnt_name", "Error creating m_driver")
        
        // Create the monitor
        m_monitor = agnt_name_mon::type_id::create("m_monitor", this);
        if (m_monitor == null) `uvm_fatal("agnt_name", "Error creating m_monitor")
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

