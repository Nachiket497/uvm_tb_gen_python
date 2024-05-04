

module tb_top (
    
		clk_reset_if        clk_reset_intf
        // Declare intf handles

    );
    


    initial begin
        run_test();
    end

    initial begin
        uvm_config_db#(virtual clk_reset_if )::set(uvm_root::get, "*", "clk_reset_if",  clk_reset_intf);
        // Set all interface

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
