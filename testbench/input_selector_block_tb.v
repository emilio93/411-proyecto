`timescale 1ns/1ps

`include "rtl/input_selector_block.v"
`include "testbench/includes.v"

`ifdef SYNTH
  `include "build/input_selector_block-sintetizado.v"
`endif

module input_selector_block_tb;
  initial begin
    $display ("input_selector_block_tb");
    $dumpfile("tests/input_selector_block_tb.vcd");
    $dumpvars(0, input_selector_block_tb);
  end

  parameter DATA_WIDTH = 4;
  parameter MAIN_INPUTS = 16;
  parameter REGS_INPUTS = 64;
  parameter OUTPUTS = 4;
  parameter OUTPUTS_PER_BUS = 4;

  parameter single_selec_size = $clog2(REGS_INPUTS) + $clog2(MAIN_INPUTS) + 1;

  reg wBusy;
  reg [63:0] wData;
  reg [255:0] wRegs;
  reg [15:0] wSelecOrigin;
  reg [3:0] wSelecMain [15:0];
  reg [5:0] wSelecRegs [15:0];
  wire [175:0] wSelec;
  wire [15:0] r0, r1, r2, r3;
  wire [15:0] r0Synth, r1Synth, r2Synth, r3Synth;

  wire [63:0] wSelecMainFlat;

  wire [95:0] wSelecRegsFlat;

  genvar i;
  generate
    for (i = 0; i < (OUTPUTS*OUTPUTS_PER_BUS); i = i + 1) begin
      assign wSelec[(i+1)*single_selec_size-1:i*single_selec_size] = {wSelecRegs[i], wSelecMain[i], wSelecOrigin[i]};

      assign wSelecMainFlat[(i+1)*$clog2(MAIN_INPUTS)-1:i*$clog2(MAIN_INPUTS)] = wSelecMain[i];

      assign wSelecRegsFlat[(i+1)*$clog2(REGS_INPUTS)-1:i*$clog2(REGS_INPUTS)] = wSelecRegs[i];

    end
  endgenerate

  input_selector_block #(
    DATA_WIDTH,
    MAIN_INPUTS,
    REGS_INPUTS,
    OUTPUTS,
    OUTPUTS_PER_BUS
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

  `ifdef SYNTH
    input_selector_blockSynth #(
      DATA_WIDTH,
      MAIN_INPUTS,
      REGS_INPUTS,
      OUTPUTS,
      OUTPUTS_PER_BUS
    ) input_selector_blockSynth (
      .wBusy(wBusy),
      .wSelec(wSelec),
      .wData(wData),
      .wRegs(wRegs),
      .r0(r0Synth),
      .r1(r1Synth),
      .r2(r2Synth),
      .r3(r3Synth)
    );
  `endif

  initial begin

    wBusy <= 0;
    wData <= 64'h0123456789abcdef;
    wRegs <= 256'h6789abcdef0123456789abcdef0123456789abcdef0123456789abcdef012345;

    wSelecOrigin <= 16'h0000;

    wSelecMain[0] <= 4'h0;
    wSelecMain[1] <= 4'h4;
    wSelecMain[2] <= 4'h8;
    wSelecMain[3] <= 4'hc;
    wSelecMain[4] <= 4'h1;
    wSelecMain[5] <= 4'h6;
    wSelecMain[6] <= 4'h9;
    wSelecMain[7] <= 4'hf;
    wSelecMain[8] <= 4'h4;
    wSelecMain[9] <= 4'h3;
    wSelecMain[10] <= 4'h7;
    wSelecMain[11] <= 4'h3;
    wSelecMain[12] <= 4'h8;
    wSelecMain[13] <= 4'h6;
    wSelecMain[14] <= 4'hd;
    wSelecMain[15] <= 4'hb;

    wSelecRegs[0] <= 6'h17;
    wSelecRegs[1] <= 6'h1b;
    wSelecRegs[2] <= 6'h1f;
    wSelecRegs[3] <= 6'h13;
    wSelecRegs[4] <= 6'h13;
    wSelecRegs[5] <= 6'h13;
    wSelecRegs[6] <= 6'h13;
    wSelecRegs[7] <= 6'h17;
    wSelecRegs[8] <= 6'h1b;
    wSelecRegs[9] <= 6'h1f;
    wSelecRegs[10] <= 6'h23;
    wSelecRegs[11] <= 6'h25;
    wSelecRegs[12] <= 6'h28;
    wSelecRegs[13] <= 6'h23;
    wSelecRegs[14] <= 6'h24;
    wSelecRegs[15] <= 6'h29;

    # 10
	`assert({r0,r1,r2,r3} == {r0Synth,r1Synth,r2Synth,r3Synth});
	$display("INFO: Logical equivalence checked for %m.");
	$finish;
  end

endmodule
