// code for uvm seqr

class agnt_name_seqr extends uvm_sequencer #(agnt_name_seq_item);
    `uvm_component_utils(agnt_name_seqr);

    function new(string name = "agnt_name_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
