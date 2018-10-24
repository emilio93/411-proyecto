`timescale 1ns/1ps

`include "testbench/includes.v"
`include "rtl/data_selector.v"

`ifdef SYNTH
`include "build/data_selector-sintetizado.v"
`endif

module data_selector_tb;
  initial begin
    $display ("data_selector_tb");
    $dumpfile("tests/data_selector_tb.vcd");
    $dumpvars(0, data_selector_tb);
  end

  parameter DATA_WIDTH = 4;
  parameter MAIN_INPUTS = 16;
  parameter REGS_INPUTS = 64;
  parameter REGS_BITS_PER_INPUT = 32;
  parameter SELECTOR_OUTPUTS = 4;
  parameter SELECTOR_OUTPUTS_PER_BUS = 4;

  reg clk, rst;
  reg wBusy;
  reg wSelecOrigin;
  reg [63:0] wData;
  reg [31:0] wRegs0, wRegs1, wRegs2, wRegs3, wRegs4, wRegs5, wRegs6, wRegs7;
  reg [3:0] wSelecMain;
  reg [175:0] wSelec;
  wire [15:0] data_out, data_outSynth;

  always #1 clk = ~clk;

  data_selector #(
  DATA_WIDTH,
  MAIN_INPUTS,
  REGS_INPUTS,
  REGS_BITS_PER_INPUT,
  SELECTOR_OUTPUTS,
  SELECTOR_OUTPUTS_PER_BUS
  ) data_selector (
    .clk(clk),
    .rst(rst),
    .wBusy(wBusy),
    .wSelec(wSelec),
    .wData(wData),
    .wRegs0(wRegs0),
    .wRegs1(wRegs1),
    .wRegs2(wRegs2),
    .wRegs3(wRegs3),
    .wRegs4(wRegs4),
    .wRegs5(wRegs5),
    .wRegs6(wRegs6),
    .wRegs7(wRegs7),
    .data_out(data_out)
  );

`ifdef SYNTH
  data_selectorSynth data_selectorSynth (
    .clk(clk),
    .rst(rst),
    .wBusy(wBusy),
    .wSelec(wSelec),
    .wData(wData),
    .wRegs0(wRegs0),
    .wRegs1(wRegs1),
    .wRegs2(wRegs2),
    .wRegs3(wRegs3),
    .wRegs4(wRegs4),
    .wRegs5(wRegs5),
    .wRegs6(wRegs6),
    .wRegs7(wRegs7),
    .data_out(data_outSynth)
  );
`endif


  initial begin
    clk <= 0;
    rst <= 0;
    wBusy <= 0;

    wData <= 64'h0123456789abcdef;
    {wRegs0, wRegs1, wRegs2, wRegs3, wRegs4, wRegs5, wRegs6, wRegs7} <= 256'h6789abcd_f0123456_789abcde_f0123456_789abcde_f0123456_789abcde_f6012345;

    wSelec[10:0] <= {11'b001100_0000_0};
    wSelec[21:11] <= {11'b100110_0001_0};
    wSelec[32:22] <= {11'b100110_0010_0};
    wSelec[43:33] <= {11'b100110_0011_0};
    wSelec[54:44] <= {11'b100110_0100_0};
    wSelec[65:55] <= {11'b100110_0101_0};
    wSelec[76:66] <= {11'b100110_0110_0};
    wSelec[87:77] <= {11'b100110_0111_0};
    wSelec[98:88] <= {11'b100110_1000_0};
    wSelec[109:99] <= {11'b100110_1001_0};
    wSelec[120:110] <= {11'b100110_1010_0};
    wSelec[131:121] <= {11'b100110_1011_0};
    wSelec[142:132] <= {11'b100110_1100_0};
    wSelec[153:143] <= {11'b100110_1101_0};
    wSelec[164:154] <= {11'b100110_1110_0};
    wSelec[175:165] <= {11'b100110_1111_0};

    # 10
    @(posedge clk);
    rst <= 1;


    # 10
    @(posedge clk);
    rst <= 0;



    # 300 $finish;
  end

endmodule