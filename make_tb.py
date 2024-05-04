import os
import sys
import shutil
import subprocess
from make_struct import *
from make_file_list import *
folder_list = ['env', 'sequences','sim', 'tb', 'vips', 'tests']


template_files_list = ['uvm_seq_item.sv','uvm_driver.sv', 'uvm_mon.sv', 'uvm_seqr.sv', 'uvm_agent.sv', 'uvm_sequence.sv' ]

template_folder = '../templates/'

def verible_format(string: str) -> str:
    """Format the string using verible-verilog-format."""
    if shutil.which("verible-verilog-format") is None:
        raise RuntimeError(
            "verible-verilog-format not found. Please install it to use the --format option."
        )
    # Format the output using verible-verilog-format, by piping it into the stdin
    # of the formatter and capturing the stdout
    return subprocess.run(
        ["verible-verilog-format", "-"],
        input=string,
        capture_output=True,
        text=True,
        check=True,
    ).stdout


def write_lines(f, data):
    for line in data :
        f.write(verible_format(line))

def make_env_file(cwd, env_folder, sub_sys_name, agnt_data):
    # take a template from template folder and copy to env folder change env_name to sub_sys_name_env

    template_file = os.path.join(template_folder, 'uvm_env.sv')
    env_file = os.path.join(env_folder, sub_sys_name + '_env.sv')

    with open(template_file, 'r') as f:
        new_data = []
        # code to delare & create agents
        for line in f.readlines() :
            line = line.replace('env_name', sub_sys_name + '_env')
            line = line.replace('sub_system_name', sub_sys_name )
            new_data.append(line)
            # find the // Declare the agents string, and add new lines for making handles of agnts
            if line.find('// Declare the agents') != -1 :
                for agnt in agnt_data.keys() :
                    agnt += "_agent"
                    new_data.append('    ' + agnt + ' ' + agnt + '_h;\n')
            # find the // Create the agents string, and add new lines for making handles of agnts
            if line.find('// Create the agents') != -1 :
                for agnt in agnt_data.keys() :
                    agnt += "_agent"
                    new_data.append('        ' + agnt + '_h = ' + agnt + '::type_id::create("'+agnt+'_h", this);\n')

            if( line.find('// Declare intf handles') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append('    virtual '+agnt+"_intf "+ agnt+"_intf_h;\n")

            if( line.find('// Connect the intf') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append("        "+agnt + "_agent_h."+agnt+"_intf_h = "+agnt+"_intf_h;\n"  )

            if( line.find('// Connect the agents') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f"        {agnt}_agent_h.m_monitor.ap.connect({sub_sys_name}_scoreboard_h.{agnt}_port.analysis_export);\n"  )


            if( line.find('// Get all intf') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'       if(!uvm_config_db#(virtual {agnt}_intf)::get(this,"*",$sformatf("{agnt}_intf"), {agnt}_intf_h))\n')
                    new_data.append(f'           `uvm_error("env", "not able to get {agnt} interface")\n')



    # write new data in env file
    with open(env_file, 'w') as f:
        write_lines(f, new_data)

def make_scoreboard(cwd, env_folder, sub_sys_name, agnt_data):
    template_file = os.path.join(template_folder, 'uvm_scoreboard.sv')
    env_file = os.path.join(env_folder, sub_sys_name + '_scoreboard.sv')

    with open(template_file, 'r') as f:
        new_data = []
        # code to delare & create agents
        for line in f.readlines() :
            line = line.replace('sub_system_name', sub_sys_name )
            new_data.append(line)
            if line.find('//Declare analysis export here') != -1 :
                for agnt in agnt_data.keys() :
                    new_data.append(f'    uvm_tlm_analysis_fifo #({agnt}_seq_item) {agnt}_port;\n')

            if line.find('//Declare seq item handles here') != -1 :
                for agnt in agnt_data.keys() :
                    new_data.append(f'    {agnt}_seq_item {agnt}_seq_item_h;\n')

            if( line.find('//Create analysis fifo') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'    {agnt}_port = new("{agnt}_port",this);\n')

            if( line.find('//Create seq item here') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'    {agnt}_seq_item_h =  {agnt}_seq_item::type_id::create("{agnt}_seq_item_h", this);\n')

            if( line.find('// get seq item from  port') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'    {agnt}_port.get({agnt}_seq_item_h);\n')



    # write new data in env file
    with open(env_file, 'w') as f:
        write_lines(f, new_data)



def make_agnt_pkg_file(cwd, env_folder, sub_sys_name, agnt_data):
    # open a empty file
    agnt_pkg_file = os.path.join(env_folder, 'agnt_pkg.sv')
    with open(agnt_pkg_file, 'w') as f:
        # loop over agnts and include and import all agnts pkgs
        new_data = [] 
        new_data.append('package ' + 'agnt_pkg;\n')
        new_data.append('import uvm_pkg::*;\n ')
        new_data.append('import struct_pkg::*;\n ')
        new_data.append('`include  "uvm_macros.svh"\n ')
        for agnt in agnt_data.keys() :
            # new_data.append(f'`include  "{agnt}_struct.sv"\n ')
            for  template in template_files_list :
                new_data.append('`include "' + template.replace("uvm",agnt) + '"\n')
        new_data.append('endpackage\n')
        write_lines(f, new_data)



def make_agent(agnt_path, agnt, agnt_data):
    # take a template from template folder and copy to agnt folder change agnt_name to agnt

    agnt_pkg_data = []
    for template_file in template_files_list :
        agnt_file = os.path.join(agnt_path, agnt + template_file.replace('uvm', ''))
        agnt_pkg_data.append("`include "+'"' + agnt + template_file.replace('uvm', '') +'"'+ "\n")
        template_file = os.path.join(template_folder, template_file)
        with open(template_file, 'r') as f:
            new_data = []
            for line in f.readlines():
                line = line.replace('agnt_name', agnt)
                new_data.append(line)

                if( line.find('// Declare Struct handles') != -1) :
                    for struct_name in agnt_data[agnt] :
                        new_data.append("    "+struct_name + '_s ' +struct_name + "_h;\n"  )
                if( line.find('// Declare intf handles') != -1) :
                    new_data.append('    virtual '+agnt+"_intf "+ agnt+"_intf_h;\n")

                if( line.find('//drive the intf') != -1) :
                    for struct_name in agnt_data[agnt] :
                        new_data.append("       "+agnt+"_intf_h."+struct_name+"_h <= req." +struct_name+"_h ; \n" )

                if( line.find('// Sample the interface') != -1) :
                    for struct_name in agnt_data[agnt] :
                        new_data.append("            "+"req."+struct_name+"_h" + " = "+agnt+"_intf_h."+struct_name+"_h" + ";\n" )


                if( line.find('// Connect the intf') != -1) :
                    new_data.append("        m_driver."+agnt+"_intf_h = "+agnt+"_intf_h;\n"  )
                    new_data.append("        m_monitor."+agnt+"_intf_h = "+agnt+"_intf_h;\n"  )

                


        with open(agnt_file, 'w') as f:
            write_lines(f, new_data)

    os.rename(agnt_path + "/../"+agnt+"_struct.sv", agnt_path + "/"+agnt+"_struct.sv")
    os.rename(agnt_path + "/"+agnt+"_sequence.sv",agnt_path + "/../../sequences/"+agnt+"_sequence.sv" )

    agnt_pkg_file = os.path.join(agnt_path, agnt + '_pkg.sv')
    new_data = []
    with open(agnt_pkg_file, 'w') as f:
        new_data.append('package ' + agnt + '_pkg;\n')
        # new_data.append(f'`include  "{agnt}_struct.sv"\n ')
        for line in agnt_pkg_data :
            new_data.append(line)
        new_data.append('endpackage\n')
        write_lines(f, new_data)

def make_intf_file(interface_folder, sub_sys_name, agnt_data):
    intf_file = os.path.join(interface_folder, sub_sys_name + '_intf.sv')
    with open(intf_file, 'w') as f:
        new_data = []
        new_data.append('import struct_pkg::*;\n ')
        for agnt in agnt_data.keys():
            new_data.append('interface ' + agnt + '_intf(input logic clk, input logic reset_n) ;\n')
            for struct_name in agnt_data[agnt] :
                new_data.append("   "+struct_name + '_s ' +struct_name + "_h;\n"  )
            new_data.append('endinterface\n')
            new_data.append('\n')
        write_lines(f, new_data)
            
    clk_reset_intf_file = os.path.join(interface_folder, 'clk_reset_intf.sv')
    template_file = os.path.join(template_folder, 'clk_reset_intf.sv')
        

    with open(template_file, 'r') as f:
        new_data = []
        for line in f.readlines():
            line = line.replace('agnt_name', agnt)
            new_data.append(line)


    with open(clk_reset_intf_file, 'w') as f:
        write_lines(f, new_data)


def make_test(test_folder, sub_sys_name, agnt_data):
    test_path = os.path.join(test_folder, sub_sys_name + '_base_test.sv')
    template_file = os.path.join(template_folder, 'uvm_base_test.sv')

    
    with open(template_file, 'r') as f:
        new_data = []
        # code to delare & create agents
        for line in f.readlines() :
            line = line.replace('env_name', sub_sys_name + '_env')
            line = line.replace('sub_sys_name_base_test', sub_sys_name + '_base_test')
            line = line.replace('sub_sys_name_env', sub_sys_name + '_env')
            new_data.append(line)
            if( line.find('// Declare intf handles') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append('    virtual '+agnt+"_intf "+ agnt+"_intf_h;\n")

            if( line.find('// Declare sequence handles') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append('    '+agnt+"_sequence "+ agnt+"_sequence_h;\n")

            if( line.find('// Create all sequences') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'       {agnt}_sequence_h = {agnt}_sequence::type_id::create("{agnt}_sequence_h", this);\n')


            if( line.find('// Get all intf') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'       if(!uvm_config_db#(virtual {agnt}_intf)::get(this,"*",$sformatf("{agnt}_intf"), {agnt}_intf_h))\n')
                    new_data.append(f'           `uvm_error("base test", "not able to get {agnt} interface")\n')

    with open(test_path, 'w') as f:
        write_lines(f, new_data)

def make_tb_top(tb_folder, agnt_data):
    tb_top_file = os.path.join(tb_folder,  'tb_top.sv')
    template_file = os.path.join(template_folder, 'tb_top.sv')

    with open(template_file, 'r') as f:
        new_data = []
        for line in f.readlines() :
            new_data.append(line)
            if( line.find('// Declare intf handles') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append('       ,'+agnt+"_intf "+ agnt+"_intf_h\n")

            if( line.find('// Set all interface') != -1) :
                for agnt in agnt_data.keys() :
                    new_data.append(f'       uvm_config_db#(virtual {agnt}_intf )::set(uvm_root::get, "*", "{agnt}_intf",  {agnt}_intf_h);\n')

    with open(tb_top_file, 'w') as f:
        write_lines(f, new_data) 

    
    dut_tb_wrapper_file = os.path.join(tb_folder,  'dut_tb_wrapper.sv')
    new_data = []

    new_data.append("module dut_tb_wrapper;\n\n")
    new_data.append("    clk_reset_if        clk_reset_intf();\n")
    for agnt in agnt_data.keys() :
        new_data.append('       '+agnt+"_intf "+ agnt+"_intf_h(clk_reset_intf.clk, clk_reset_intf.reset_n );\n")
    new_data.append("\n")

    new_data.append("   dut_top_wrapper dut_top_wrapper_inst(\n")
    new_data.append("           .clk_reset_intf(clk_reset_intf)\n")
    for agnt in agnt_data.keys() :
        new_data.append(f"        ,.{agnt}_intf_h({agnt}_intf_h)\n")
    new_data.append(");\n\n\n")

    new_data.append("   tb_top tb_top_inst(\n")
    new_data.append("           .clk_reset_intf(clk_reset_intf)\n")
    for agnt in agnt_data.keys() :
        new_data.append(f"        ,.{agnt}_intf_h({agnt}_intf_h)\n")
    new_data.append(");\n\n\n")

    new_data.append("endmodule\n")

    with open(dut_tb_wrapper_file, 'w') as f:
        write_lines(f, new_data) 
    
    dut_top_wrapper_file = os.path.join(tb_folder,  'dut_top_wrapper.sv')
    new_data = []
    new_data.append("module dut_top_wrapper(\n")
    new_data.append("    clk_reset_if        clk_reset_intf\n")
    for agnt in agnt_data.keys() :
        new_data.append('       ,'+agnt+"_intf "+ agnt+"_intf_h\n")
    new_data.append("   );\n\n")
    new_data.append("endmodule\n")
    with open(dut_top_wrapper_file, 'w') as f:
        write_lines(f, new_data) 

def make_run_script(template_folder, common_folder):
    new_data = []
    template_file = os.path.join(template_folder, 'run.csh')
    run_file = os.path.join(common_folder, 'run.csh')
    with open(template_file, 'r') as f:
        for line in f.readlines() :
            new_data.append(line)
            
    with open(run_file, 'w') as f:
        write_lines(f, new_data)


def make_folder_struct(cwd, sub_sys_name) :

    for folder in folder_list :
        folder_path = os.path.join(cwd, folder)
        if not os.path.exists(folder_path) :
            os.makedirs(folder_path) 

    # open env folder and make agnets
    env_folder = os.path.join(cwd, 'env')
    agnt_data = get_input(env_folder,cwd + "/../input_file.txt" )
    make_env_file(cwd, env_folder, sub_sys_name, agnt_data)
    agnt_list = agnt_data.keys()
    make_agnt_pkg_file(cwd, env_folder, sub_sys_name, agnt_data)
    

    for agnt in agnt_list :
        print("Creating files for ", agnt)
        agnt_path = os.path.join(env_folder, agnt)
        if not os.path.exists(agnt_path) :
            os.makedirs(agnt_path)
            make_agent(agnt_path, agnt, agnt_data)

    os.rename(cwd + "/env/sequence_pkg.sv", cwd + "/sequences/sequence_pkg.sv")

    make_scoreboard(cwd, env_folder, sub_sys_name, agnt_data)

    # open tb folder and make interface folder
    tb_folder = os.path.join(cwd, 'tb')
    verilog_folder = os.path.join(tb_folder, 'verilog')
    if not os.path.exists(verilog_folder) :
        os.makedirs(verilog_folder)

    make_tb_top(verilog_folder, agnt_data)
    
    interface_folder = os.path.join(tb_folder, 'interface')
    if not os.path.exists(interface_folder) :
        os.makedirs(interface_folder)
    # make intf file
    make_intf_file( interface_folder, sub_sys_name, agnt_data)

    # open sim folder and make a run folder
    sim_folder = os.path.join(cwd,'sim')
    run_scripts_folder = os.path.join(sim_folder, 'run')
    common_folder = os.path.join(sim_folder, 'common')

    if not os.path.exists(run_scripts_folder) :
        os.makedirs(run_scripts_folder)
    if not os.path.exists(common_folder) :
        os.makedirs(common_folder)

    make_run_script(template_folder, common_folder)
    test_folder = os.path.join(cwd, 'tests')

    make_file_list(common_folder, agnt_list, sub_sys_name)
    # creating a base test
    make_test(test_folder, sub_sys_name, agnt_data)

  
def find_files_with_pattern(root_folder, pattern):
    found_files = []
    for root, dirs, files in os.walk(root_folder):
        for file in files:
            if pattern in file:
                found_files.append(os.path.join(root, file))
        for d in dirs:
            found_files += find_files_with_pattern(os.path.join(root, d), pattern)
    return found_files 

def format_all_files(cwd):

    flist = find_files_with_pattern(cwd + "/env/", ".sv")
    for f in flist:
        os.system(f"cat {f} | verible-verilog-format - > temp")
        os.system(f"cat temp > {f}")


if __name__ == "__main__":

    try :
        sub_sys_name = sys.argv[1]
    except :
        sub_sys_name = 'ltssm'
    cwd = os.getcwd()
    make_folder_struct(cwd, sub_sys_name)

    format_all_files(cwd)
