// code for uvm_agent

class axi_wide_agent extends uvm_agent;
  `uvm_component_utils(axi_wide_agent)

  // Declare the sequencer
  axi_wide_seqr m_seqr;

  // Declare the driver
  axi_wide_driver m_driver;

  // Declare the monitor
  axi_wide_mon m_monitor;

  // Declare intf handles
  virtual axi_wide_intf axi_wide_intf_h;

  // Constructor
  function new(string name = "axi_wide", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the sequencer
    m_seqr = axi_wide_seqr::type_id::create("m_seqr", this);
    if (m_seqr == null) `uvm_fatal("axi_wide", "Error creating m_seqr")

    // Create the driver
    m_driver = axi_wide_driver::type_id::create("m_driver", this);
    if (m_driver == null) `uvm_fatal("axi_wide", "Error creating m_driver")

    // Create the monitor
    m_monitor = axi_wide_mon::type_id::create("m_monitor", this);
    if (m_monitor == null) `uvm_fatal("axi_wide", "Error creating m_monitor")
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect the intf 
    m_driver.axi_wide_intf_h  = axi_wide_intf_h;
    m_monitor.axi_wide_intf_h = axi_wide_intf_h;
    // Connect the sequencer to the driver
    m_driver.seq_item_port.connect(m_seqr.seq_item_export);

  endfunction

endclass

