class cere_noc_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(cere_noc_scoreboard)

  //Declare analysis export here
  uvm_tlm_analysis_fifo #(axi_narrow_seq_item) axi_narrow_port;
  uvm_tlm_analysis_fifo #(axi_wide_seq_item) axi_wide_port;

  //Declare seq item handles here
  axi_narrow_seq_item axi_narrow_seq_item_h;
  axi_wide_seq_item axi_wide_seq_item_h;

  // new - constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction  // new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //Create analysis fifo
    axi_narrow_port = new("axi_narrow_port", this);
    axi_wide_port = new("axi_wide_port", this);


    //Create seq item here
    axi_narrow_seq_item_h = axi_narrow_seq_item::type_id::create("axi_narrow_seq_item_h", this);
    axi_wide_seq_item_h = axi_wide_seq_item::type_id::create("axi_wide_seq_item_h", this);

  endfunction  // build_phase


  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever
    fork
      // get seq item from  port
      axi_narrow_port.get(axi_narrow_seq_item_h);
      axi_wide_port.get(axi_wide_seq_item_h);
    join
  endtask  // run_phase


endclass
