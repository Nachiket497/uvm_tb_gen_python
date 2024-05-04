// code for uvm seqr

class axi_narrow_seqr extends uvm_sequencer #(axi_narrow_seq_item);
  `uvm_component_utils(axi_narrow_seqr);

  function new(string name = "axi_narrow_seqr", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
