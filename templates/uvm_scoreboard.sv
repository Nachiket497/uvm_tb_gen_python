class sub_system_name_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(sub_system_name_scoreboard)

    //Declare analysis export here

    //Declare seq item handles here

    // new - constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction // new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //Create analysis fifo
        
        
        //Create seq item here

    endfunction // build_phase


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
            forever
            fork
                // get seq item from  port
            join 
    endtask // run_phase


endclass
