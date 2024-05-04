// code for uvm seq item
import uvm_pkg::*;
`include "uvm_macros.svh"
class axi_narrow_seq_item extends uvm_sequence_item;

  `uvm_object_utils(axi_narrow_seq_item)

  // Declare Struct handles
  i_narrow_struct_s i_narrow_struct_h;
  o_narrow_struct_s o_narrow_struct_h;

  // add constrains here
  function new(string name = "axi_narrow_seq_item");
    super.new(name);
  endfunction
endclass
