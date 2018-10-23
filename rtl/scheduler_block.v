`include "rtl/adapter_4_to_1.v"
`include "rtl/scheduler.v"

`ifndef scheduler_block_module
`define scheduler_block_module

/**
 *  El bloque scheduler_block une los bloques adapter_4_to_1 y scheduler de
 *  manera que se tenga un bloque con 4 entradas y una salida, permitiendo un
 *  diseño parametrizable en las estructuras internas.
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
 *    r0, r1, r2, r3 : señales de datos a arbitrar. Son señales de tamaño
 *           DATA_WIDTH cada una.
 *
 *  Puertos de salida
 *    darta_out : es la señal que el arbitro ha seleccionado, es de tamaño
 *               DATA_WIDTH.
 */
module scheduler_block #(
  parameter DATA_WIDTH=16,
  parameter N_INPUTS=4
) (
  input clk, rst,
  input [DATA_WIDTH-1:0] r0,r1,r2,r3,
  output [DATA_WIDTH-1:0] data_out
);

  // cable que une los bloques.
  wire [N_INPUTS*DATA_WIDTH-1:0] r;

  adapter_4_to_1 #(
    DATA_WIDTH,
    N_INPUTS
  ) adapter_4_to_1 (
    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r(r)
  );

  scheduler #(
    DATA_WIDTH,
    N_INPUTS
  ) scheduler(
    .clk(clk),
    .rst(rst),
    .r_in(r),
    .data_out(data_out)
  );

endmodule

`endif