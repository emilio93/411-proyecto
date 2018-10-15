`include "rtl/adapter_4_to_1.v"
`include "rtl/scheduler.v"

`ifndef scheduler_block_module
`define scheduler_block_module

module scheduler_block #(
  parameter DATA_WIDTH=16,
  parameter N_INPUTS=4
) (
  input clk, rst,
  input [DATA_WIDTH-1:0] r0,r1,r2,r3,
  output [DATA_WIDTH-1:0] data_out
);

  wire [N_INPUTS*DATA_WIDTH-1:0] r;

  adapter_4_to_1 #(
    DATA_WIDTH,
    N_INPUTS
  ) adapter_4_to_1 (
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r(r)
  );

  scheduler #(
    DATA_WIDTH,
    N_INPUTS
  ) scheduler(
    .clk(clk),
    .rst(rst),
    .r_in(r),
    .data_out(data_out)
  );

endmodule

`endif