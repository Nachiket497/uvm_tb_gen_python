module dut_tb_wrapper;

    clk_reset_if        clk_reset_intf();
       axi_narrow_intf axi_narrow_intf_h(clk_reset_intf.clk, clk_reset_intf.reset_n );
       axi_wide_intf axi_wide_intf_h(clk_reset_intf.clk, clk_reset_intf.reset_n );

   dut_top_wrapper dut_top_wrapper_inst(
           .clk_reset_intf(clk_reset_intf)
        ,.axi_narrow_intf_h(axi_narrow_intf_h)
        ,.axi_wide_intf_h(axi_wide_intf_h)
);


   tb_top tb_top_inst(
           .clk_reset_intf(clk_reset_intf)
        ,.axi_narrow_intf_h(axi_narrow_intf_h)
        ,.axi_wide_intf_h(axi_wide_intf_h)
);


endmodule
