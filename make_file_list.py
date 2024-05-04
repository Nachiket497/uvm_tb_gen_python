import os

def make_file_list( common_folder, agnt_list, sub_sys_name):

    tb_flist = os.path.join(common_folder , "tb_flist.f")
    
    data = []
    with open(tb_flist, 'w') as f:

        # including all dirs
        data.append('+incdir+$PROJDIR_TB/')
        data.append('+incdir+$PROJDIR_TB/env/')
        data.append('+incdir+$PROJDIR_TB/sequences/')
        data.append('+incdir+$PROJDIR_TB/sim/')
        data.append('+incdir+$PROJDIR_TB/tb/')
        data.append('+incdir+$PROJDIR_TB/tb/interface')
        data.append('+incdir+$PROJDIR_TB/tests/')
        data.append('+incdir+$PROJDIR_TB/vips/')


        for agnt in agnt_list :
            data.append(f'+incdir+$PROJDIR_TB/env/{agnt}')

        # append all struct files
        # for agnt in agnt_list :
        #     data.append(f'$PROJDIR_TB/env/{agnt}/{agnt}_struct.sv')

        # append all intf files
        data.append(f'$PROJDIR_TB/env/struct_pkg.sv')
        data.append(f'$PROJDIR_TB/tb/interface/{sub_sys_name}_intf.sv')
        data.append(f'$PROJDIR_TB/tb/interface/clk_reset_intf.sv')

        # append env file
        # data.append(f'$PROJDIR_TB/env/{sub_sys_name}_env.sv')
        
        # append base test file
        data.append(f'$PROJDIR_TB/tests/{sub_sys_name}_base_test.sv')
        data.append(f'$PROJDIR_TB/tb/verilog/tb_top.sv')
        data.append(f'$PROJDIR_TB/tb/verilog/dut_top_wrapper.sv')
        data.append(f'$PROJDIR_TB/tb/verilog/dut_tb_wrapper.sv')

    
    with open(tb_flist, 'w') as f:
        for line in data :
            f.write(line + "\n")


