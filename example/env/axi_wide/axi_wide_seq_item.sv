// code for uvm seq item
import uvm_pkg::*;
`include "uvm_macros.svh"
class axi_wide_seq_item extends uvm_sequence_item;

  `uvm_object_utils(axi_wide_seq_item)

  // Declare Struct handles
  i_wide_struct_s i_wide_struct_h;
  o_wide_struct_s o_wide_struct_h;

  // add constrains here
  function new(string name = "axi_wide_seq_item");
    super.new(name);
  endfunction
endclass
