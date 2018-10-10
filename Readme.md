# Proyecto IE411

```bash
# folders necesarios
mkdir -p out
mkdir -p tests

# compilar verilog
iverilog -o out/scheduler_tb.o testbench/scheduler_tb.v
iverilog -o out/input_selector_tb.o testbench/input_selector_tb.v
# iverilog -o out/data_selector_tb.o testbench/data_selector_tb.v

# correr testbenchs
vvp out/scheduler_tb.o
vvp out/input_selector_tb.o
# vvp out/data_selector_tb.o

# abrir en GtkWave
gtkwave gtkw/scheduler_tb.gtkw
gtkwave gtkw/input_selector_tb.gtkw
# gtkwave gtkw/data_selector_tb.gtkw

```