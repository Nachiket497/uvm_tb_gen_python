typedef struct {
  axi_wide_in_req_t [3:0][3:0]  chiplet_wide_req_i;
  axi_wide_out_rsp_t [3:0][3:0] chiplet_wide_rsp_i;
} i_wide_struct_s;

typedef struct {
  axi_wide_out_req_t [3:0][3:0] chiplet_wide_req_o;
  axi_wide_in_rsp_t [3:0][3:0]  chiplet_wide_rsp_o;
} o_wide_struct_s;

