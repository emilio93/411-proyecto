`timescale 1ns/1ps

`include "testbench/includes.v"
`include "rtl/adapter_4_to_1.v"

`ifdef SYNTH
`include "build/adapter_4_to_1-sintetizado.v"
`endif

module adapter_4_to_1_tb;
  initial begin
    $display ("adapter_4_to_1_tb");
    $dumpfile("tests/adapter_4_to_1_tb.vcd");
    $dumpvars(0, adapter_4_to_1_tb);
  end

  parameter DATA_WIDTH = 16;
  parameter N_INPUTS = 4;

  reg [DATA_WIDTH-1:0] r0, r1, r2, r3;

  wire [N_INPUTS*DATA_WIDTH-1:0] r;
  wire [N_INPUTS*DATA_WIDTH-1:0] rSynth;

  wire errorR;

  assign errorR = r != rSynth;

  adapter_4_to_1 #(DATA_WIDTH, N_INPUTS) adapter_4_to_1 (
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r(r)
  );

`ifdef SYNTH
  adapter_4_to_1Synth adapter_4_to_1Synth (
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r(rSynth)
  );
`endif

  initial begin

    r0 <= 16'h0123;
    r1 <= 16'h4567;
    r2 <= 16'h89AB;
    r3 <= 16'hCDEF;

    # 10

    r0 <= 16'hCDEF;
    r1 <= 16'h89AB;
    r2 <= 16'h4567;
    r3 <= 16'h0123;

    # 10


    r0 <= 16'hAAAA;
    r1 <= 16'h0AAA;
    r2 <= 16'h00BB;
    r3 <= 16'h0123;

    # 10 $finish;
  end

endmodule