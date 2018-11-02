yosys -import

set curDir         "$::env(CUR_DIR)"
set vlogModuleName "$::env(VLOG_MODULE_NAME)"
set vlogFileName   "$::env(VLOG_FILE_NAME)"
set cellLib        "$::env(SYNTH_TECH)"
set pdfOut         "$::env(PDF_OUT)"
set synthOut       "$::env(SYNTH_OUT)"
set libSrc         "$::env(LIB_SRC)"

# Sufijo para archivo sintetizado
set synthSuffix "-sintetizado"

yosys read_verilog -sv $vlogFileName

hierarchy -check -top $vlogModuleName
show -prefix $pdfOut$vlogModuleName-original -colors 3 -viewer echo $vlogModuleName

yosys proc
show -prefix $pdfOut$vlogModuleName-proc -colors 3 -viewer echo $vlogModuleName

opt
show -prefix $pdfOut$vlogModuleName-proc_opt -colors 3 -viewer echo $vlogModuleName

fsm
show -prefix $pdfOut$vlogModuleName-fsm -colors 3 -viewer echo $vlogModuleName

opt
show -prefix $pdfOut$vlogModuleName-fsm_opt -colors 3 -viewer echo $vlogModuleName

memory
show -prefix $pdfOut$vlogModuleName-memory -colors 3 -viewer echo $vlogModuleName

opt
show -prefix $pdfOut$vlogModuleName-memory_opt -colors 3 -viewer echo $vlogModuleName

techmap
show -prefix $pdfOut$vlogModuleName-techmap -colors 3 -viewer echo $vlogModuleName

opt
show -prefix $pdfOut$vlogModuleName-techmap_opt -colors 3 -viewer echo $vlogModuleName

write_verilog $synthOut$vlogModuleName-rtlil.v

dfflibmap -liberty $libSrc$cellLib.lib

show -prefix $pdfOut$vlogModuleName-dff_seq -lib $libSrc$cellLib.v -colors 3 -viewer echo $vlogModuleName

abc -liberty $libSrc$cellLib.lib
stat -liberty $libSrc$cellLib.lib
show -prefix $pdfOut$vlogModuleName-abc_comb -lib $libSrc$cellLib.v -colors 3 -viewer echo $vlogModuleName

clean

show -prefix $pdfOut$vlogModuleName-synth -lib $libSrc$cellLib.v -viewer echo -colors 3 -viewer echo $vlogModuleName
write_verilog $synthOut$vlogModuleName$synthSuffix.v