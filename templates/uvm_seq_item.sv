// code for uvm seq item
import uvm_pkg::*;
`include  "uvm_macros.svh"
class agnt_name_seq_item extends uvm_sequence_item;

    `uvm_object_utils(agnt_name_seq_item)

    // Declare Struct handles
    
    // add constrains here
    function new (string name="agnt_name_seq_item");
       super.new(name); 
    endfunction 
endclass
