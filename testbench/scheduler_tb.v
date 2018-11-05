`timescale 1ns/1ps

`include "rtl/scheduler.v"
`include "testbench/includes.v"
`ifdef SYNTH
  `include "build/scheduler-sintetizado.v"
`endif

module scheduler_tb;
  initial begin
    $display ("scheduler_tb");
    $dumpfile("tests/scheduler_tb.vcd");
    $dumpvars(0, scheduler_tb);
  end

  parameter DATA_WIDTH = 16;
  parameter N_INPUTS = 4;

  reg clk, rst;
  reg [N_INPUTS*DATA_WIDTH-1:0] r_in;
  wire [DATA_WIDTH-1:0] data_out, data_outSynth;

  always #1 clk = ~clk;
  always @(negedge clk) begin `assert(data_out == data_outSynth); end


  scheduler #(DATA_WIDTH, N_INPUTS) scheduler (
    .clk(clk),
    .rst(rst),
    .r_in(r_in),
    .data_out(data_out)
  );
  `ifdef SYNTH
    schedulerSynth #(DATA_WIDTH, N_INPUTS) schedulerSynth (
      .clk(clk),
      .rst(rst),
      .r_in(r_in),
      .data_out(data_outSynth)
    );
  `endif
  initial begin
    rst <= 0;
    clk <= 0;

    r_in <= 64'haaaa_bbbb_cccc_dddd;

    # 5
    @(posedge clk);
    rst <= 1;

    # 10
    @(posedge clk);
    rst <= 0;

    # 40
	$display("INFO: Logical equivalence checked for %m.");
    $finish;
  end

endmodule
