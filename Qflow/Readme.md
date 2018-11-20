# Proyecto IE411: Entrega Final

## comprobar que ejecutables necesarios para correr make
## se encuentren en $PATH
+ which sh
+ which bash
+ which iverilog
+ which yosys
+ which graywolf
+ which qrouter
+ which magic
+ which qflow

## Para seleccionar tecnologia:
+ make tech

## Para ejecutar todas las etapas de Qflow:
+ make

## Para sintetizar con Yosys:
+ make synth

## Para Placement:
+ make place

## Para ejecutar análisis temporal estatico:
+ make sta

## Para Routing:
+ make route

## Para eliminar archivos temporales:
+ make clean

## Archivo con resultados de anális temporal:
+ sta_data.txt
- Se genera despúes de correr: make sta

## Sub-directorios:
+ layout: Contiene los "working files" y el archivo de salida DEF.
+ source: Contiene los archivos fuente de verilog.
+ synthesis: Contiene los "working files" y los archivos de salida de verilog: RTL.
+ rtl: Se encuentran los archivos fuente originales del RTL.
