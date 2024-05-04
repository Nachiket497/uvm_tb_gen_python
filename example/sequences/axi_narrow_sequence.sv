class axi_narrow_sequence extends uvm_sequence#(axi_narrow_seq_item);   
`uvm_object_utils(axi_narrow_sequence)

axi_narrow_seq_item req;

    function new(string name="axi_narrow_sequence");
        super.new(name);
req = new();
    endfunction

    virtual task body();
        start_item(req);
        finish_item(req);
    endtask: body


endclass 

