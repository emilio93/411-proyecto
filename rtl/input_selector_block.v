`include "rtl/input_selector.v"

`ifndef input_selector_block_module
`define input_selector_block_module

module input_selector_block #(
  parameter DATA_WIDTH = 4,
  parameter MAIN_INPUTS = 16,
  parameter REGS_INPUTS = 64,
  parameter OUTPUTS = 4,
  parameter OUTPUTS_PER_BUS = 4
) (
  input wBusy,
  input [OUTPUTS*OUTPUTS_PER_BUS*($clog2(MAIN_INPUTS)+$clog2(REGS_INPUTS+1))-1:0] wSelec,
  input [MAIN_INPUTS*DATA_WIDTH-1:0] wData,
  input [REGS_INPUTS*DATA_WIDTH-1:0] wRegs,
  output wire [DATA_WIDTH*OUTPUTS_PER_BUS-1:0] r0, r1, r2, r3
);
  parameter orig_selec_size = 1;
  parameter main_selec_size = $clog2(MAIN_INPUTS);
  parameter regs_selec_size = $clog2(REGS_INPUTS);
  parameter out_selec_size = main_selec_size+regs_selec_size+orig_selec_size;

  wire wSelecOrigin [OUTPUTS_PER_BUS*OUTPUTS-1:0];
  wire [$clog2(MAIN_INPUTS)-1:0] wSelecMain [OUTPUTS_PER_BUS*OUTPUTS-1:0];
  wire [$clog2(REGS_INPUTS)-1:0] wSelecRegs [OUTPUTS_PER_BUS*OUTPUTS-1:0];

  wire [DATA_WIDTH-1:0] r [OUTPUTS_PER_BUS*OUTPUTS-1:0];

  assign r0 = {r[3], r[2], r[1], r[0]};
  assign r1 = {r[7], r[6], r[5], r[4]};
  assign r2 = {r[11], r[10], r[9], r[8]};
  assign r3 = {r[15], r[14], r[13], r[12]};

  genvar g, h, i, j;
  generate

    for (g = 0; g < OUTPUTS*OUTPUTS_PER_BUS; g = g + 1) begin : selec_assign
      assign wSelecOrigin[g] = wSelec[g*out_selec_size];
      assign wSelecMain[g] = wSelec[g*out_selec_size+main_selec_size:g*out_selec_size+1];
      assign wSelecRegs[g] = wSelec[g*out_selec_size+out_selec_size-1:g*out_selec_size+main_selec_size+1];
    end

    for (i = 0; i < OUTPUTS; i = i + 1) begin : input_selector_i
      for (j = 0; j < OUTPUTS_PER_BUS; j = j + 1) begin : input_selector_j
        input_selector #(
          DATA_WIDTH,
          MAIN_INPUTS,
          REGS_INPUTS
        ) input_selector (
          .wBusy(wBusy),
          .wSelecOrigin(wSelecOrigin[i*OUTPUTS_PER_BUS+j]),
          .wData(wData),
          .wDataRegs(wRegs),
          .wSelecMain(wSelecMain[i*OUTPUTS_PER_BUS+j]),
          .wSelecRegs(wSelecRegs[i*OUTPUTS_PER_BUS+j]),
          .r(r[i*OUTPUTS_PER_BUS+j])
        );
      end
    end
  endgenerate

endmodule

`endif