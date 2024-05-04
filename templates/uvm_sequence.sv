class agnt_name_sequence extends uvm_sequence#(agnt_name_seq_item);   
    `uvm_object_utils(agnt_name_sequence)

    agnt_name_seq_item req;

    function new(string name="agnt_name_sequence");
        super.new(name);
        req = new();
    endfunction

    virtual task body();
        start_item(req);
        finish_item(req);
    endtask: body


endclass 

