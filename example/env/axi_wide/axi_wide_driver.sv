// code for uvm_driver

class axi_wide_driver extends uvm_driver #(axi_wide_seq_item);
  `uvm_component_utils(axi_wide_driver)

  // Declare intf handles
  virtual axi_wide_intf axi_wide_intf_h;

  // Declare a seq item handle
  axi_wide_seq_item req;

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
    forever begin
      super.run_phase(phase);
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask

  task drive();
    //drive the intf
    axi_wide_intf_h.i_wide_struct_h <= req.i_wide_struct_h;
    axi_wide_intf_h.o_wide_struct_h <= req.o_wide_struct_h;
  endtask

endclass
