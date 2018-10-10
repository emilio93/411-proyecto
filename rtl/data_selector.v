
`include "rtl/input_selector.v"

`ifndef data_selector_module
`define data_selector_module

module data_selector #(parameter DATA_WIDTH=4, parameter MAIN_INPUTS=16, parameter REGS_INPUTS=64, OUTPUTS=4, OUTPUTS_PER_BUS=4) (
  input clk, rst,
  input wBusy,
  input [175:0] wSelec,
  input [MAIN_INPUTS*DATA_WIDTH-1:0] wData,
  input [REGS_INPUTS*DATA_WIDTH-1:0] wRegs,
  output wire [DATA_WIDTH-1:0] r
);

  genvar i;
  generate

    for (i = 0; i<OUTPUTS*OUTPUTS_PER_BUS; i=i+1) begin
      input_selector input_selector (
        .wBusy(wBusy),

        .wSelecOrigin(wSelec[i*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS))]),

        .wData(wData),

        .wDataRegs(wRegs),

        .wSelecMain(wSelec[i*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS))+$clog2(MAIN_INPUTS):i*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS))+1]),

        .wSelecRegs(wSelec[i*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS))+$clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS):i*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS))+1+$clog2(MAIN_INPUTS)]),

        .r(r)
      );
    end

  endgenerate

endmodule

`endif