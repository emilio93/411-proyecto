`timescale 1ns/1ps

`include "rtl/scheduler.v"

module scheduler_tb;
  initial begin
    $display ("scheduler_tb");
    $dumpfile("tests/scheduler_tb.vcd");
    $dumpvars(0, scheduler_tb);
  end

  reg clk, rst;
  reg [15:0] r0, r1, r2, r3;
  wire [15:0] data_out;

  always #1 clk = ~clk;

  scheduler scheduler1 (
    .clk(clk),
    .rst(rst),
    .r0(r0), .r1(r1), .r2(r2), .r3(r3),
    .data_out(data_out)
  );

  initial begin
    rst <= 0;
    clk <= 0;
    r0 <= 16'haaaa;
    r1 <= 16'hbbbb;
    r2 <= 16'hcccc;
    r3 <= 16'hdddd;

    # 20
    @(posedge clk);
    rst <= 1;

    # 100
    @(posedge clk);
    rst <= 0;

    # 100 $finish;
  end

endmodule