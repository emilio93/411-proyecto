
module scheduler #(parameter DATA_WIDTH=16, parameter OUTPUTS=4) (
  input clk, rst,
  input [DATA_WIDTH-1:0] r0, r1, r2, r3,
  output reg [DATA_WIDTH-1:0] data_out
);

  reg [$clog2(OUTPUTS)-1:0] ctr;
  wire [DATA_WIDTH-1:0] r [OUTPUTS-1:0];

  assign r[0] = r0;
  assign r[1] = r1;
  assign r[2] = r2;
  assign r[3] = r3;

  always @(posedge clk ) begin
    if (rst) begin
      data_out <= r0;
      ctr <= 0;
    end else begin
      ctr <= ctr + 1;
      data_out <= r[ctr];
    end
  end
endmodule // scheduler