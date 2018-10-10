`timescale 1ns/1ps

`include "rtl/input_selector.v"

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
  wire [3:0] r;

  input_selector input_selector1 (
    .wBusy(wBusy),
    .wSelecOrigin(wSelecOrigin),
    .wData(wData),
    .wDataRegs(wDataRegs),
    .wSelecMain(wSelecMain),
    .wSelecRegs(wSelecRegs),
    .r(r)
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
    wSelecOrigin <= 1;

    # 10
    wBusy <= 1;

    # 10
    wSelecMain <= 1;

    # 10
    wSelecRegs <= 4;

    # 10
    wBusy <= 0;

    # 10
    wSelecRegs <= $urandom%63;

    # 10
    wSelecMain <= 10;

    # 10
    wSelecOrigin <= 0;

    # 100 $finish;
  end

endmodule