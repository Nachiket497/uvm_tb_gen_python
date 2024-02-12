// code for uvm seqr

class agnt1_seqr extends uvm_sequencer #(agnt1_seq_item);
    `uvm_component_utils(agnt1_seqr);

    function new(string name = "agnt1_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
