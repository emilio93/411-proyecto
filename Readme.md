# Proyecto IE411

## Correr pruebas

```bash
# correr make help para instrucciones de uso
make help
# make help | head -31 # instrucciones generales
# make help | head -43 | tail -12 # make all
# make help | head -55 | tail -11 # make synth
# make help | head -72 | tail -16 # make compile
# make help | head -85 | tail -12 # make run
# make help | head -96 | tail -10 # make view
# make help | head -106 | tail -9 # make clean

# sintetizar, compilar y correr todos los bloques y pruebas.
make

# abrir gtkwave para ver la prueba data_selector
make view data_selector

# otra alternativa.

# correr script automatizado, solo compartamiento lógico, no realiza síntesis.
./scripts/build.sh

# abrir en GtkWave
gtkwave gtkw/adapter_4_to_1_tb.gtkw
gtkwave gtkw/data_selector_tb.gtkw
gtkwave gtkw/input_selector_tb.gtkw
gtkwave gtkw/input_selector_block_tb.gtkw
gtkwave gtkw/scheduler_tb.gtkw
```

## Directorios en el Repositorio

 * gtkw :  read files se  utilizan para guardar visualizaciones de señales en
 los testbench.
 * lib : archivos para tecnologías utilizadas.
 * rtl : codigo verilog que implementa el diseño planteado.
 * scripts : scripts utilizados en el flujo del proyecto.
 * testbench : módulos de prueba para el diseño implementado.

 ## ¿Que Hace Falta?

 * Módulo de prueba para una configuración de señales en la cúal la selección de
 datos de la entrada principal siempre es la misma, esto es, la señal
 ```wSelecMain``` no cambia. El direccionamiento de los datos es de manera que
 los 16 primeros bits corresponden a la primer salida del bloque
 ```input_selector_block```, los siguientes 16 bits a la segunda salida, ...
 * Documentar bloques ```data_selector``` e ```input_selector_block```.
 *