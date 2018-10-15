`ifndef scheduler_module
`define scheduler_module

/**
 *  Bloque scheduler
 *
 *  El bloque scheduler arbitra según el algoritmo round robin N_INPUTS entradas
 *  de tamaño DATA_WIDTH cada uno. Para iniciar el arbitro se utiliza una señal
 *  de reset(rst). El arbitro elige unaseñal de entrada distinta cada ciclo de
 *  reloj clk.
 *
 *  Se cuenta con una única entrada de datos en la cual se encuentran las
 *  N_INPUT entradas de tamaño DATA_WIDTH cada una. Con el fin de permitir
 *  N_INPUT entradas se utiliza un adaptador específico para N_INPUT entradas
 *  a una única salida, esta salida es la entrada a este bloque.
 *
 *  Parámetros
 *    DATA_WIDTH : tamaño base de los datos.
 *    N_INPUTS : cantidad de entradas entre las cuales el arbitro selecciona la
 *               salida.
 *
 *  Puertos de entrada
 *    clk : señal de reloj, cada ciclo de reloj el arbitro cambia la selección.
 *    rst : señal de reset, reinicia el arbitro de manera que la primer salida
 *          cuando esta señal pasa de 1 a 0.
 *    r_in : señal de datos a arbitrar. Es una señal de tamaño
 *           DATA_WIDTH*N_INPUTS, de esta manera se tienen N_INPUTS entradas de
 *           tamaño DATA_WIDTH cada uno.
 *
 *  Puertos de salida
 *    data_out : es la señal que el arbitro ha seleccionado, es de tamaño
 *               DATA_WIDTH.
 */
module scheduler #(
  parameter DATA_WIDTH=16,
  parameter N_INPUTS=4
) (
  input clk, rst,
  input [DATA_WIDTH*N_INPUTS-1:0] r_in,
  output reg [DATA_WIDTH-1:0] data_out
);

  reg [$clog2(N_INPUTS)-1:0] ctr;
  wire [DATA_WIDTH-1:0] r [N_INPUTS-1:0];

  genvar i;
  generate
    for (i = 0; i < N_INPUTS; i = i+1) begin
      assign r[i] = r_in[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH];
    end
  endgenerate

  always @(posedge clk) begin
    if (rst) begin
      data_out <= r[0];
      ctr <= 0;
    end else begin
      ctr <= ctr + 1;
      data_out <= r[ctr];
    end
  end
endmodule // scheduler

`endif