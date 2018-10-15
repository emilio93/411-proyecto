`include "rtl/input_selector_block.v"
`include "rtl/scheduler_block.v"

`ifndef data_selector_module
`define data_selector_module

module data_selector #(
  parameter DATA_WIDTH = 4,
  parameter MAIN_INPUTS = 16,
  parameter REGS_INPUTS = 64,
  parameter REGS_BITS_PER_INPUT = 32,
  parameter SELECTOR_OUTPUTS = 4,
  parameter SELECTOR_OUTPUTS_PER_BUS = 4
) (
  input clk, rst,
  input wBusy,
  input [SELECTOR_OUTPUTS*SELECTOR_OUTPUTS_PER_BUS*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS+1))-1:0] wSelec,
  input [MAIN_INPUTS*DATA_WIDTH-1:0] wData,
  input [REGS_BITS_PER_INPUT-1:0] wRegs0, wRegs1, wRegs2, wRegs3, wRegs4, wRegs5, wRegs6, wRegs7,
  output reg [DATA_WIDTH*SELECTOR_OUTPUTS_PER_BUS-1:0] data_out
);

  reg [REGS_INPUTS*DATA_WIDTH-1:0] wRegs;
  wire [DATA_WIDTH*SELECTOR_OUTPUTS_PER_BUS-1:0] r0, r1, r2, r3;
  wire [DATA_WIDTH*SELECTOR_OUTPUTS_PER_BUS-1:0] scheduler_output;


  always @(posedge clk ) begin
    wRegs <= {wRegs7, wRegs6, wRegs5, wRegs4, wRegs3, wRegs2, wRegs1, wRegs0};
    data_out <= scheduler_output;
  end

  input_selector_block #(
    DATA_WIDTH,
    MAIN_INPUTS,
    REGS_INPUTS,
    SELECTOR_OUTPUTS,
    SELECTOR_OUTPUTS_PER_BUS
  ) input_selector_block (
    .wBusy(wBusy),
    .wSelec(wSelec),
    .wData(wData),
    .wRegs(wRegs),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3)
  );

  scheduler_block #(
    DATA_WIDTH*SELECTOR_OUTPUTS_PER_BUS,
    SELECTOR_OUTPUTS
  ) scheduler_block (
    .clk(clk),
    .rst(rst),
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .data_out(scheduler_output)
  );

endmodule

`endif