// code for uvm_driver

class axi_narrow_driver extends uvm_driver #(axi_narrow_seq_item);
  `uvm_component_utils(axi_narrow_driver)

  // Declare intf handles
  virtual axi_narrow_intf axi_narrow_intf_h;

  // Declare a seq item handle
  axi_narrow_seq_item req;

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
    axi_narrow_intf_h.i_narrow_struct_h <= req.i_narrow_struct_h;
    axi_narrow_intf_h.o_narrow_struct_h <= req.o_narrow_struct_h;
  endtask

endclass
