class axi_wide_sequence extends uvm_sequence#(axi_wide_seq_item);   
`uvm_object_utils(axi_wide_sequence)

axi_wide_seq_item req;

    function new(string name="axi_wide_sequence");
        super.new(name);
req = new();
    endfunction

    virtual task body();
        start_item(req);
        finish_item(req);
    endtask: body


endclass 

