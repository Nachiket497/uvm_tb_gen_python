import struct_pkg::*;
interface axi_narrow_intf(input logic clk, input logic reset_n) ;
i_narrow_struct_s i_narrow_struct_h;
o_narrow_struct_s o_narrow_struct_h;
endinterface

interface axi_wide_intf(input logic clk, input logic reset_n) ;
i_wide_struct_s i_wide_struct_h;
o_wide_struct_s o_wide_struct_h;
endinterface

