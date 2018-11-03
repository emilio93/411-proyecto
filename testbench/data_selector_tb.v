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
  reg [63:0] wData;
  reg [31:0] wRegs0, wRegs1, wRegs2, wRegs3, wRegs4, wRegs5, wRegs6, wRegs7;
  reg [3:0] wSelecMain [15:0];
  reg [5:0] wSelecRegs [15:0];
  reg wSelecOrigin [15:0];
  reg [175:0] wSelec;
  wire [15:0] data_out, data_outSynth;
  wire errorData_out;

  assign errorData_out = data_out != data_outSynth;

  assign wSelec[10:0] = {wSelecRegs[0], wSelecMain[0], wSelecOrigin[0]};
  assign wSelec[21:11] = {wSelecRegs[1], wSelecMain[1], wSelecOrigin[1]};
  assign wSelec[32:22] = {wSelecRegs[2], wSelecMain[2], wSelecOrigin[2]};
  assign wSelec[43:33] = {wSelecRegs[3], wSelecMain[3], wSelecOrigin[3]};
  assign wSelec[54:44] = {wSelecRegs[4], wSelecMain[4], wSelecOrigin[4]};
  assign wSelec[65:55] = {wSelecRegs[5], wSelecMain[5], wSelecOrigin[5]};
  assign wSelec[76:66] = {wSelecRegs[6], wSelecMain[6], wSelecOrigin[6]};
  assign wSelec[87:77] = {wSelecRegs[7], wSelecMain[7], wSelecOrigin[7]};
  assign wSelec[98:88] = {wSelecRegs[8], wSelecMain[8], wSelecOrigin[8]};
  assign wSelec[109:99] = {wSelecRegs[9], wSelecMain[9], wSelecOrigin[9]};
  assign wSelec[120:110] = {wSelecRegs[10], wSelecMain[10], wSelecOrigin[10]};
  assign wSelec[131:121] = {wSelecRegs[11], wSelecMain[11], wSelecOrigin[11]};
  assign wSelec[142:132] = {wSelecRegs[12], wSelecMain[12], wSelecOrigin[12]};
  assign wSelec[153:143] = {wSelecRegs[13], wSelecMain[13], wSelecOrigin[13]};
  assign wSelec[164:154] = {wSelecRegs[14], wSelecMain[14], wSelecOrigin[14]};
  assign wSelec[175:165] = {wSelecRegs[15], wSelecMain[15], wSelecOrigin[15]};

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

    wData <= 64'h0123_4567_89ab_cdef;
    {wRegs0, wRegs1, wRegs2, wRegs3, wRegs4, wRegs5, wRegs6, wRegs7} <= 256'hffffabef_f0123456_789abcde_f0123456_789abcde_f0123456_789abcde_aaaabbbb;


    # 10
    @(posedge clk);
    rst <= 1;

  wSelecRegs[0] <= 6'h0;
  wSelecRegs[1] <= 6'h1;
  wSelecRegs[2] <= 6'h2;
  wSelecRegs[3] <= 6'h3;
  wSelecRegs[4] <= 6'h4;
  wSelecRegs[5] <= 6'h5;
  wSelecRegs[6] <= 6'h6;
  wSelecRegs[7] <= 6'h7;
  wSelecRegs[8] <= 6'h8;
  wSelecRegs[9] <= 6'h9;
  wSelecRegs[10] <= 6'ha;
  wSelecRegs[11] <= 6'hb;
  wSelecRegs[12] <= 6'hc;
  wSelecRegs[13] <= 6'hd;
  wSelecRegs[14] <= 6'he;
  wSelecRegs[15] <= 6'hf;

  wSelecMain[0] <= 4'h0;
  wSelecMain[1] <= 4'h1;
  wSelecMain[2] <= 4'h2;
  wSelecMain[3] <= 4'h3;
  wSelecMain[4] <= 4'h4;
  wSelecMain[5] <= 4'h5;
  wSelecMain[6] <= 4'h6;
  wSelecMain[7] <= 4'h7;
  wSelecMain[8] <= 4'h8;
  wSelecMain[9] <= 4'h9;
  wSelecMain[10] <= 4'ha;
  wSelecMain[11] <= 4'hb;
  wSelecMain[12] <= 4'hc;
  wSelecMain[13] <= 4'hd;
  wSelecMain[14] <= 4'he;
  wSelecMain[15] <= 4'hf;

  wSelecOrigin[0] <= 1'b0;
  wSelecOrigin[1] <= 1'b0;
  wSelecOrigin[2] <= 1'b0;
  wSelecOrigin[3] <= 1'b0;
  wSelecOrigin[4] <= 1'b0;
  wSelecOrigin[5] <= 1'b0;
  wSelecOrigin[6] <= 1'b0;
  wSelecOrigin[7] <= 1'b0;
  wSelecOrigin[8] <= 1'b0;
  wSelecOrigin[9] <= 1'b0;
  wSelecOrigin[10] <= 1'b0;
  wSelecOrigin[11] <= 1'b0;
  wSelecOrigin[12] <= 1'b0;
  wSelecOrigin[13] <= 1'b0;
  wSelecOrigin[14] <= 1'b0;
  wSelecOrigin[15] <= 1'b0;


    # 10
    @(posedge clk);
    rst <= 0;

  # 20
    @(posedge clk);

  wSelecOrigin[0] <= 1'b1;
  wSelecOrigin[1] <= 1'b1;
  wSelecOrigin[2] <= 1'b1;
  wSelecOrigin[3] <= 1'b1;

  # 20
    @(posedge clk);
    {wRegs7} <= 32'h23456789;
  wData <= 64'hcacb_4567_89ab_cdef;

  wSelecOrigin[0] <= 1'b0;
  wSelecOrigin[1] <= 1'b0;
  wSelecOrigin[2] <= 1'b0;
  wSelecOrigin[3] <= 1'b0;

  wSelecOrigin[4] <= 1'b1;
  wSelecOrigin[5] <= 1'b1;
  wSelecOrigin[6] <= 1'b1;
  wSelecOrigin[7] <= 1'b1;

  wSelecOrigin[8] <= 1'b1;
  wSelecOrigin[9] <= 1'b1;
  wSelecOrigin[10] <= 1'b1;
  wSelecOrigin[11] <= 1'b1;
  wSelecOrigin[12] <= 1'b1;
  wSelecOrigin[13] <= 1'b1;
  wSelecOrigin[14] <= 1'b1;
  wSelecOrigin[15] <= 1'b1;

  wSelecRegs[8] <= 6'd60;
  wSelecRegs[9] <= 6'd61;
  wSelecRegs[10] <= 6'd62;
  wSelecRegs[11] <= 6'd63;

  wSelecRegs[12] <= 6'd60;
  wSelecRegs[13] <= 6'd61;
  wSelecRegs[14] <= 6'd62;
  wSelecRegs[15] <= 6'd63;



    # 300 $finish;
  end

endmodule