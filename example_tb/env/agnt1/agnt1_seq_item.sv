// code for uvm seq item

class agnt1_seq_item extends uvm_sequence_item;

    `uvm_component_utils(agnt1_seq_item)

    // constructor
    function new(string name = "agnt1_seq_item");
        super.new(name);
    endfunction

    // add constrains here
    
endclass
