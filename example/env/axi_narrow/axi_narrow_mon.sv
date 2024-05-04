// code for uvm_monitor

class axi_narrow_mon extends uvm_monitor;
  `uvm_component_utils(axi_narrow_mon)

  // Declare intf handles
  virtual axi_narrow_intf axi_narrow_intf_h;


  uvm_analysis_port #(axi_narrow_seq_item) ap;
  axi_narrow_seq_item req;

  // Constructor
  function new(string name = "axi_narrow_mon", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap  = new("axi_narrow_ap", this);
    req = axi_narrow_seq_item::type_id::create("req");
    // Get the interface using uvm config db
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      @(posedge axi_narrow_intf_h.clk);
      // Sample the interface
      req.i_narrow_struct_h = axi_narrow_intf_h.i_narrow_struct_h;
      req.o_narrow_struct_h = axi_narrow_intf_h.o_narrow_struct_h;
      // Compare the sampled data with the expected data
      // If there is a mismatch, report an error
      // Wait for a while
    end
  endtask
endclass
