// code for uvm_monitor

class axi_wide_mon extends uvm_monitor;
  `uvm_component_utils(axi_wide_mon)

  // Declare intf handles
  virtual axi_wide_intf axi_wide_intf_h;


  uvm_analysis_port #(axi_wide_seq_item) ap;
  axi_wide_seq_item req;

  // Constructor
  function new(string name = "axi_wide_mon", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap  = new("axi_wide_ap", this);
    req = axi_wide_seq_item::type_id::create("req");
    // Get the interface using uvm config db
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      @(posedge axi_wide_intf_h.clk);
      // Sample the interface
      req.i_wide_struct_h = axi_wide_intf_h.i_wide_struct_h;
      req.o_wide_struct_h = axi_wide_intf_h.o_wide_struct_h;
      // Compare the sampled data with the expected data
      // If there is a mismatch, report an error
      // Wait for a while
    end
  endtask
endclass
