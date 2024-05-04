#!/bin/csh -f


#Loading modules
module load synopsys_lic/cadmgr_prod_new
module load vcs-mx/U-2023.03 
module load verdi/U-2023.03


setenv PROJDIR_TB ../../
setenv PROJDIR    ../../

set RTL_FILE_LIST = ""
set TB_FILE_LIST = " -f ${PROJDIR_TB}/sim/common/tb_flist.f "


unsetenv LD_LIBRARY_PATH
setenv LD_LIBRARY_PATH /tools1/modulefiles/tools/license/synopsys_lic

set test_name = "$1"
shift 

echo "Compiling test : $test_name"
cp ../../tests/$test_name.sv ./curr_test.sv

set VCS_OPTS = ""

set i = 1;
set num_arg  = $#
while ($i <= $num_arg)
    echo "Processing arg :$argv[$i] $i"
    if ($argv[$i]  == "vdump" )then
        set VCS_OPTS = "${VCS_OPTS} +define+DUMP_FSDB -kdb  $VERDI_HOME/share/PLI/VCS/LINUX64/pli.a  -P $VERDI_HOME/share/PLI/VCS/LINUX64/novas.tab "
    else  
        set VCS_OPTS = "${VCS_OPTS} +define+$argv[$i] "
    endif
    @ i = $i + 1
end

if ( -f run_command ) then
  rm run_command
endif
echo "source run.csh $*" > run_command


set VCS_OPTS = "${VCS_OPTS}   +define+UVM_NO_DEPRECATED   " 

set compile_cmd = "vcs -ntb_opts uvm  ${VCS_OPTS}  -l comp.log -debug_all -debug_region=cell+lib -lca +v2k -ntb_opts dtm +vcs+lic+wait -notice  -sverilog -timescale=1ns/1ps +notimingcheck +nospecify +define+UVM_PACKER_MAX_BYTES=1600000 +define+UVM_DISABLE_AUTO_ITEM_RECORDING  ${RTL_FILE_LIST}  ${TB_FILE_LIST} +vpi -debug_pp +plusarg_save +UVM_TESTNAME=$test_name  +plusarg_ignore -full64 -partcomp=adaptive_sched +UVM_VERBOSITY=UVM_HIGH +fsdb+all=on"


set simulation_cmd = "./simv -l run.log +licq +UVM_TESTNAME=$test_name ${VCS_OPTS} +ntb_random_seed=2001 +UVM_VERBOSITY=UVM_HIGH +fsdb+all=on"
   echo "\n\n         --------------------------------------------------------- \
         UVM Testcase              : $test_name  \
         Command                   : $compile_cmd \
         Command                   : $simulation_cmd \
         --------------------------------------------------------- \n\n" 

echo "\ncompilation command: \n"$compile_cmd "\nsimulation command: \n"$simulation_cmd > vcs_commands_executed


$compile_cmd
$simulation_cmd

# Call status script
../common/check_status.csh run.log

rm -rf ../reports/$test_name
mkdir -p ../reports
mkdir -p ../reports/$test_name
set temp = `\cp run.log ../reports/$test_name/run.log `
set temp = `\cp comp.log ../reports/$test_name/comp.log `

sleep 0.5

