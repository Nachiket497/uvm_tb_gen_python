typedef struct {
  axi_narrow_in_req_t [3:0][3:0]  chiplet_narrow_req_i;
  axi_narrow_out_rsp_t [3:0][3:0] chiplet_narrow_rsp_i;
} i_narrow_struct_s;

typedef struct {
  axi_narrow_out_req_t [3:0][3:0] chiplet_narrow_req_o;
  axi_narrow_in_rsp_t [3:0][3:0]  chiplet_narrow_rsp_o;
} o_narrow_struct_s;

