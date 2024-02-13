// code for uvm seq item

class agnt2_seq_item extends uvm_sequence_item;

    `uvm_object_utils(agnt2_seq_item)

    // constructor
    function new(string name = "agnt2_seq_item");
        super.new(name);
    endfunction

    // add constrains here
    
endclass
