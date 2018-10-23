`ifndef adapter_4_to_1_module
`define adapter_4_to_1_module

/**
 *  Bloque adapter_4_to_1
 *
 *  El bloque se encarga de unir 4 buses de datos de entrada en un solo bus de
 *  salida.
 *
 *  Este bloque es generado por un script que permite variar la cantidad de
 *  entradas y el tamaño base de los datos.
 *
 *  Parámetros
 *    DATA_WIDTH : tamaño base de los datos.
 *    N_INPUTS : cantidad de entradas del módulo.
 *
 *  Puertos de Entrada
 *    r0, r1, r2, r3 : señales de entrada de tamaño DATA_WIDTH.
 *
 *  Puertos de Salida
 *    r : señal de salida de tamaño DATA_WIDTH*N_INPUTS
 */

module adapter_4_to_1 #(
  parameter DATA_WIDTH=16,
  parameter N_INPUTS=4
) (
  input [DATA_WIDTH-1:0] r0, r1, r2, r3,
  output [(N_INPUTS*DATA_WIDTH)-1:0] r
);
  assign r = {r0, r1, r2, r3};
endmodule

`endif

