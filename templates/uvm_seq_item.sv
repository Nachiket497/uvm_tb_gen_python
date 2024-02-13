// code for uvm seq item

class agnt_name_seq_item extends uvm_sequence_item;

    `uvm_object_utils(agnt_name_seq_item)

    // constructor
    function new(string name = "agnt_name_seq_item");
        super.new(name);
    endfunction

    // add constrains here
    
endclass
