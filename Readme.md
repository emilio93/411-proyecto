# Proyecto IE411

```bash
# correr make help para instrucciones de uso
make help

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