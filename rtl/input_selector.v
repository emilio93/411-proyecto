`ifndef input_selector_module
`define input_selector_module

/**
 *  Bloque input_selector
 *  El bloque input_selector se encarga de acomodar datos de dos
 *  entradas distintas.
 *
 */
module input_selector #(
  parameter DATA_WIDTH = 4,
  parameter MAIN_INPUTS = 16,
  parameter REGS_INPUTS = 64
) (
  input wBusy, wSelecOrigin,
  input [MAIN_INPUTS*DATA_WIDTH-1:0] wData,
  input [REGS_INPUTS*DATA_WIDTH-1:0] wDataRegs,
  input [$clog2(MAIN_INPUTS)-1:0] wSelecMain,
  input [$clog2(REGS_INPUTS)-1:0] wSelecRegs,
  output wire [DATA_WIDTH-1:0] r
);
  wire [DATA_WIDTH-1:0] chunksMain [MAIN_INPUTS-1:0];
  wire [DATA_WIDTH-1:0] chunksRegs [REGS_INPUTS-1:0];

  genvar i, j;
  generate
    for (i = 0; i < MAIN_INPUTS; i=i+1) begin
      assign chunksMain[i] = wData[i*DATA_WIDTH+DATA_WIDTH-1:i*DATA_WIDTH];
    end
    for (j = 0; j < REGS_INPUTS; j=j+1) begin
      assign chunksRegs[j] = wDataRegs[j*DATA_WIDTH+DATA_WIDTH-1:j*DATA_WIDTH];
    end
  endgenerate

  assign r = (~wBusy & wSelecOrigin) ?
             chunksRegs[wSelecRegs] :
             chunksMain[wSelecMain];
endmodule

`endif