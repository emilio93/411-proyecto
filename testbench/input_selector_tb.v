`timescale 1ns/1ps

`include "rtl/input_selector.v"
`include "testbench/includes.v"
`ifdef SYNTH
  `include "build/input_selector-sintetizado.v"
`endif

module input_selector_tb;
  initial begin
    $display ("input_selector_tb");
    $dumpfile("tests/input_selector_tb.vcd");
    $dumpvars(0, input_selector_tb);
  end

  reg wBusy;
  reg wSelecOrigin;
  reg [63:0] wData;
  reg [255:0] wDataRegs;
  reg [3:0] wSelecMain;
  reg [5:0] wSelecRegs;
  wire [3:0] r, rSynth;

  input_selector input_selector1 (
    .wBusy(wBusy),
    .wSelecOrigin(wSelecOrigin),
    .wData(wData),
    .wDataRegs(wDataRegs),
    .wSelecMain(wSelecMain),
    .wSelecRegs(wSelecRegs),
    .r(r)
  );

  input_selectorSynth input_selectorSynth (
    .wBusy(wBusy),
    .wSelecOrigin(wSelecOrigin),
    .wData(wData),
    .wDataRegs(wDataRegs),
    .wSelecMain(wSelecMain),
    .wSelecRegs(wSelecRegs),
    .r(rSynth)
  );

  initial begin

    # 2

    wData <= 64'h0123456789abcdef;
    wDataRegs <= 256'h6789abcdef0123456789abcdef0123456789abcdef0123456789abcdef012345;

    wBusy <= 0;
    wSelecOrigin <= 0;
    wSelecMain <= 0;
    wSelecRegs <= 0;
    # 10
	`assert(r == rSynth);

	wSelecOrigin <= 1;
    # 10
	`assert(r == rSynth);

	wBusy <= 1;
    # 10
	`assert(r == rSynth);

    wSelecMain <= 1;
    # 10
	`assert(r == rSynth);

    wSelecRegs <= 4;
    # 10
	`assert(r == rSynth);

    wBusy <= 0;
    # 10
	`assert(r == rSynth);

    wSelecRegs <= $urandom%63;
    # 10
	`assert(r == rSynth);

    wSelecMain <= 10;
    # 10
	`assert(r == rSynth);

    wSelecOrigin <= 0;
    # 100
	`assert(r == rSynth);
	$display("INFO: Logical equivalence checked for %m.");

	$finish;
  end

endmodule
