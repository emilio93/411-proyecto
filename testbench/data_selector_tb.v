`timescale 1ns/1ps

`include "rtl/data_selector.v"

module data_selector_tb;
  initial begin
    $display ("data_selector_tb");
    $dumpfile("tests/data_selector_tb.vcd");
    $dumpvars(0, data_selector_tb);
  end

  reg clk, rst;
  reg wBusy;
  reg wSelecOrigin;
  reg [63:0] wData;
  reg [255:0] wRegs;
  reg [3:0] wSelecMain;
  reg [175:0] wSelec;
  wire [3:0] r;

  always #1 clk = ~clk;

  data_selector data_selector1 (
    .clk(clk),
    .rst(rst),
    .wBusy(wBusy),
    .wSelec(wSelec),
    .wData(wData),
    .wRegs(wRegs)
  );

  initial begin

    # 2

    wData <= 64'h0123456789abcdef;
    wRegs <= 256'h6789abcdef0123456789abcdef0123456789abcdef0123456789abcdef012345;

    wSelec[10:0] <= {11'b00110011001};
    wSelec[21:11] <= {11'b10011001100};
    wSelec[32:22] <= {11'b10011001100};

    wBusy <= 0;


    # 300 $finish;
  end

endmodule