

module tb_top (

		clk_reset_if        clk_reset_intf
// Declare intf handles
       ,axi_narrow_intf axi_narrow_intf_h
       ,axi_wide_intf axi_wide_intf_h

    );



    initial begin
        run_test();
    end

    initial begin
        uvm_config_db#(virtual clk_reset_if )::set(uvm_root::get, "*", "clk_reset_if",  clk_reset_intf);
// Set all interface
       uvm_config_db#(virtual axi_narrow_intf )::set(uvm_root::get, "*", "axi_narrow_intf",  axi_narrow_intf_h);
       uvm_config_db#(virtual axi_wide_intf )::set(uvm_root::get, "*", "axi_wide_intf",  axi_wide_intf_h);

    end


    `ifdef DUMP_FSDB
        initial begin
            $fsdbDumpfile("top.fsdb");
            $fsdbDumpvars(0,dut_tb_wrapper);
            $fsdbDumpvars("+struct");
            $fsdbDumpvars("+mda");
            $fsdbDumpvars("+fsdb+all=on");
            $fsdbDumpon;
        end
    `endif

endmodule
