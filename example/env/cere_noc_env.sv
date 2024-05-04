// include uvm pkg and agents files
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "agnt_pkg.sv"
import uvm_pkg::*;
import agnt_pkg::*;

`include "cere_noc_scoreboard.sv"

class cere_noc_env extends uvm_env;
  `uvm_component_utils(cere_noc_env)

  cere_noc_scoreboard cere_noc_scoreboard_h;

  // Declare the agents
  axi_narrow_agent axi_narrow_agent_h;
  axi_wide_agent axi_wide_agent_h;

  // Declare intf handles
  virtual axi_narrow_intf axi_narrow_intf_h;
  virtual axi_wide_intf axi_wide_intf_h;

  // Constructor
  function new(string name = "cere_noc_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create the agents
    axi_narrow_agent_h = axi_narrow_agent::type_id::create("axi_narrow_agent_h", this);
    axi_wide_agent_h   = axi_wide_agent::type_id::create("axi_wide_agent_h", this);

    // Get all intf
    if (!uvm_config_db#(virtual axi_narrow_intf)::get(
            this, "*", $sformatf("axi_narrow_intf"), axi_narrow_intf_h
        ))
      `uvm_error("env", "not able to get axi_narrow interface")
    if (!uvm_config_db#(virtual axi_wide_intf)::get(
            this, "*", $sformatf("axi_wide_intf"), axi_wide_intf_h
        ))
      `uvm_error("env", "not able to get axi_wide interface")
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect the intf 
    axi_narrow_agent_h.axi_narrow_intf_h = axi_narrow_intf_h;
    axi_wide_agent_h.axi_wide_intf_h = axi_wide_intf_h;

    // Connect the agents
    axi_narrow_agent_h.m_monitor.ap.connect(cere_noc_scoreboard_h.axi_narrow_port.analysis_export);
    axi_wide_agent_h.m_monitor.ap.connect(cere_noc_scoreboard_h.axi_wide_port.analysis_export);


  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);

  endtask

endclass
