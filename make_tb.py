import os
import sys

folder_list = ['env', 'sequences','sim', 'tb', 'vips', 'tests']

agnt_list = ['agnt1', 'agnt2']

template_folder = '../templates/'
template_files_list = ['uvm_seq_item.sv','uvm_driver.sv', 'uvm_mon.sv', 'uvm_seqr.sv', 'uvm_agent.sv' ]

def write_lines(f, data):
    for line in data :
        f.write(line)


def make_test(cwd, test_folder, sub_sys_name):
    # take a template from template folder and copy to test folder change test_name to sub_sys_name_test
    template_file = os.path.join(template_folder, 'uvm_test.sv')
    test_file = os.path.join(cwd + test_folder, sub_sys_name + '_test.sv')

    with open(template_file, 'r') as f:
        new_data = []
        for line in f.readlines():
            line = line.replace('env_name', sub_sys_name + '_env')
            new_data.append(line)
   
    with open(test_file, 'w') as f:
        write_lines(f, new_data)


   
def make_env_file(cwd, env_folder, sub_sys_name):
    # take a template from template folder and copy to env folder change env_name to sub_sys_name_env

    template_file = os.path.join(template_folder, 'uvm_env.sv')
    env_file = os.path.join(cwd + env_folder, sub_sys_name + '_env.sv')

    with open(template_file, 'r') as f:
        new_data = []
        # code to delare & create agents
        for line in f.readlines() :
            line = line.replace('env_name', sub_sys_name + '_env')
            new_data.append(line)
            # find the // Declare the agents string, and add new lines for making handles of agnts
            if line.find('// Declare the agents') != -1 :
                for agnt in agnt_list :
                    new_data.append('    ' + agnt + ' ' + agnt + '_h;\n')
           # find the // Create the agents string, and add new lines for making handles of agnts
            if line.find('// Create the agents') != -1 :
                for agnt in agnt_list :
                    new_data.append('    ' + agnt + '_h = ' + agnt + '::type_id::create("'+agnt+'_h", this);\n')

    # write new data in env file
    with open(env_file, 'w') as f:
        write_lines(f, new_data)


def make_agnt_pkg_file(cwd, env_folder, sub_sys_name):
    # open a empty file
    agnt_pkg_file = os.path.join(cwd + env_folder, 'agnt_pkg.sv')
    with open(agnt_pkg_file, 'w') as f:
        # loop over agnts and include and import all agnts pkgs
        f.write('package ' + 'agnt_pkg;\n')
        f.write('import uvm_pkg::*;\n')
        f.write('`include "uvm_macros.svh"\n')
        for agnt in agnt_list :
            for template in template_files_list:
                f.write('`include "' + template.replace("uvm",agnt) + '"\n')
        f.write('endpackage\n')


def make_agent(agnt_path, agnt):
    # take a template from template folder and copy to agnt folder change agnt_name to agnt
    agnt_pkg_data = []
    for template_file in template_files_list :
        agnt_file = os.path.join(agnt_path, agnt + template_file.replace('uvm', ''))
        agnt_pkg_data.append("`include " + agnt + template_file.replace('uvm', '') + "\n")
        template_file = os.path.join(template_folder, template_file)
        with open(template_file, 'r') as f:
            new_data = []
            for line in f.readlines():
                line = line.replace('agnt_name', agnt)
                new_data.append(line)

        with open(agnt_file, 'w') as f:
            write_lines(f, new_data)

    agnt_pkg_file = os.path.join(agnt_path, agnt + '_pkg.sv')
    with open(agnt_pkg_file, 'w') as f:
        f.write('package ' + agnt + '_pkg;\n')
        for line in agnt_pkg_data :
            f.write(line)
        f.write('endpackage\n')

def make_intf_file(interface_folder, sub_sys_name):
    intf_file = os.path.join(interface_folder, sub_sys_name + '_intf.sv')
    with open(intf_file, 'w') as f:
        f.write('interface ' + sub_sys_name + '_intf;\n')
        f.write('endinterface\n')


def make_folder_struct(cwd, sub_sys_name) :

    for folder in folder_list :
        folder_path = os.path.join(cwd, folder)
        if not os.path.exists(folder_path) :
            os.makedirs(folder_path) 

    # open env folder and make agnets
    env_folder = os.path.join(cwd, '/env')
    make_env_file(cwd, env_folder, sub_sys_name)
    make_agnt_pkg_file(cwd, env_folder, sub_sys_name)


    for agnt in agnt_list :
        agnt_path = os.path.join(cwd + env_folder, agnt)
        if not os.path.exists(agnt_path) :
            os.makedirs(agnt_path)
            make_agent(agnt_path, agnt)

    # open tb folder and make interface folder
    tb_folder = os.path.join(cwd, '/tb')
    interface_folder = os.path.join(tb_folder, '/interface')
    if not os.path.exists(cwd + tb_folder + interface_folder) :
        os.makedirs(cwd + tb_folder + interface_folder)
    # make intf file
    make_intf_file(cwd + tb_folder + interface_folder, sub_sys_name)
    test_folder = os.path.join(cwd, '/tests') 
    make_test(cwd, test_folder, sub_sys_name)
    # open sim folder and make a run_scripts folder
    sim_folder = os.path.join(cwd, '/sim')
    run_scripts_folder = os.path.join(sim_folder, '/run_scripts')


if __name__ == "__main__":

    try :
        sub_sys_name = sys.argvs[1]
    except :
        sub_sys_name = 'dut'
    cwd = os.getcwd()
    make_folder_struct(cwd, sub_sys_name)
    
