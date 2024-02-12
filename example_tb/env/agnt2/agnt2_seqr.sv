// code for uvm seqr

class agnt2_seqr extends uvm_sequencer #(agnt2_seq_item);
    `uvm_component_utils(agnt2_seqr);

    function new(string name = "agnt2_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
