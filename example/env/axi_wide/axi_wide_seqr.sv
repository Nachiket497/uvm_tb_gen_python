// code for uvm seqr

class axi_wide_seqr extends uvm_sequencer #(axi_wide_seq_item);
  `uvm_component_utils(axi_wide_seqr);

  function new(string name = "axi_wide_seqr", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
