#!/bin/bash

mkdir -p out
mkdir -p tests

output_extension=".o"

cd testbench
for filename in *.v; do
  cd ..

  echo "
$filename"
  echo "iverilog -g2005-sv -o out/${filename/.v/$output_extension} testbench/${filename}"
  iverilog -g2005-sv -o out/${filename/.v/$output_extension} testbench/${filename}

  vvp out/${filename/.v/$output_extension}

  cd testbench
done
