`ifndef adapter_4_to_1_module
`define adapter_4_to_1_module

module adapter_4_to_1 #(
  parameter DATA_WIDTH=16,
  parameter N_INPUTS=4
) (
  input [DATA_WIDTH-1:0] r0, r1, r2, r3,
  output [(N_INPUTS*DATA_WIDTH)-1:0] r
);
  assign r = {r0, r1, r2, r3};
endmodule

`endif

