#TECH_name: nombre de la libreria 
TECH_name_18 = osu018
TECH_name_35 = osu035

#Nombre del top-module del RTL, para sintetizar.
top-module_name = data_selector

OPT = -T

# ******************************************************************************
# ALL
# ******************************************************************************
# DESCRIPCION:
#	Ejecuta todas las etapas de Qflow: synth place sta route clean
#	para el top-module del RTL.
# USO:
#   make all
all:	tech synth place sta

# ******************************************************************************
# TECH
# ******************************************************************************
# DESCRIPCION:
#   Selecciona la libreria correspondiente a la tecnologia que se desea usar.
#	Se especifica un valor inicial de densidad, para etapa de placement
# ARGUMENTOS:
#	TECH_name_18: se especifica la tecnología para sintetizar.
# 	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make tech
tech:
		qflow $(OPT) $(TECH_name_18) $(top-module_name)
		echo >> project_vars.sh "set initial_density = 0.8" 
		
# ******************************************************************************
# SYNTH
# ******************************************************************************
# DESCRIPCION:
#   Sintetiza según script de yosys brindado por Qflow.
# ARGUMENTOS:
#	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make synth
synth:
		qflow synthesize $(top-module_name)

# ******************************************************************************
# PLACE
# ******************************************************************************
# DESCRIPCION:
#   Realiza el placement. Una de las etapas de Qflow.
# ARGUMENTOS:
#	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make place
place:
		qflow place $(top-module_name)

# ******************************************************************************
# STA
# ******************************************************************************
# DESCRIPCION:
#   Realiza el análisis de temporizacion estatico (static timing analysis).
#	Se guardan los datos generados en el archivo sta_data.txt
# ARGUMENTOS:
#	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make sta
sta:
		qflow sta $(top-module_name) > sta_data.txt

# ******************************************************************************
# ROUTE
# ******************************************************************************
# DESCRIPCION:
#	Ejecuta el detail router (qrouter). Una de las etapas de Qflow.
# ARGUMENTOS:
#	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make route
route:
		qflow route $(top-module_name)

#decongest:
		#qflow decongest $(top-module_name)

#display:
		#qflow display $(top-module_name)

# ******************************************************************************
# CLEAN
# ******************************************************************************
# DESCRIPCION:
#	Limpia los sub-directorios, eliminando los archivos temporales generados.
# ARGUMENTOS:
# 	top-module_name: nombre del top-module del RTL a sintetizar.
# USO:
#   make clean
clean:
		qflow clean $(top-module_name)

# ******************************************************************************
# CLEAN
# ******************************************************************************
# DESCRIPCION:
#	Elimina TODOS los archivos, tanto temporales como de salida, de cada etapa
#	de Qflow.
# USO:
#   make clear	
clear:
		rm -rf source/*.ys *.blif
		rm -rf layout/*
		rm -rf synthesis/*
		rm -rf *.log
		
