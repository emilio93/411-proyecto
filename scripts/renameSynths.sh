folder=$1

start_dir=$('pwd')
echo $start_dir
cd $folder
for file in ./*-sintetizado.v; do
  moduleName=${file/.\//}
  moduleName=${moduleName/-sintetizado.v/}
  newModuleName=${moduleName}Synth
  echo "build/${file/.\//}: ${moduleName} -> ${newModuleName}"
  echo "sed -i \"s/module ${moduleName}/module  ${newModuleName}/g\" \"${file}\""
  sed -i "s/module ${moduleName}/module  ${newModuleName}/" "${file}"
  echo ""
done

cd $start_dir