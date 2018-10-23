`ifndef input_selector_module
`define input_selector_module

/**
 *  Bloque input_selector
 *  El bloque input_selector se encarga de obtener un único dato desde dos
 *  posibles entradas en base a señales de selección y ocupado.
 *
 *  Se cuenta con un tamaño de datos base DATA_WIDTH, en base a esto se escala
 *  la cantidad de entradas MAIN_INPUTS y REGS_INPUTS y se ve en los tamaños de *  los buses de entrada wData y wDataRegs respectivamente.
 *
 *  Parámetros
 *    DATA_WIDTH : tamaño base de los datos.
 *    MAIN_INPUTS : cantidad de datos de entrada principal.
 *    REGS_INPUTS : cantidad de datos de entrada del banco de registros.
 *
 *  Puertos de entrada
 *    wBusy : bit de ocupado. 1 permite el paso de entrada principal únicamente.
 *    wSelecOrigin : bit de selección de origen de los datos. 0 selecciona la
 *                   entrada principal. 1 selecciona la entrada de banco de
 *                   registros.
 *    wData : entrada principal de datos.
 *    wDataRegs : entrada de datos desde el banco de registros.
 *    wSelecMain : señal de selección de dato en entrada principal.
 *    wSelecRegs : señal de selección de dato de banco de registros.
 *
 *  Puertos de salida
 *    r : dato seleccionado.
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

  // arreglos de datos a partir de entrada principal.
  wire [DATA_WIDTH-1:0] chunksMain [MAIN_INPUTS-1:0];

  // arreglos de datos a partir de banco de registros.
  wire [DATA_WIDTH-1:0] chunksRegs [REGS_INPUTS-1:0];

  // Se asignan adecuadamente los datos a los arreglos de datos para cada
  // entrada.
  genvar i, j;
  generate
    // Para entrada principal.
    for (i = 0; i < MAIN_INPUTS; i=i+1) begin
      assign chunksMain[i] = wData[i*DATA_WIDTH+DATA_WIDTH-1:i*DATA_WIDTH];
    end
    // Para entrada de banco de registros.
    for (j = 0; j < REGS_INPUTS; j=j+1) begin
      assign chunksRegs[j] = wDataRegs[j*DATA_WIDTH+DATA_WIDTH-1:j*DATA_WIDTH];
    end
  endgenerate

  // En base a wBusy, wSelecOrigin, wSelecRegs y wSelecMain se selecciona el
  // dato.
  assign r = (~wBusy & wSelecOrigin) ?
             chunksRegs[wSelecRegs] :
             chunksMain[wSelecMain];
endmodule

`endif