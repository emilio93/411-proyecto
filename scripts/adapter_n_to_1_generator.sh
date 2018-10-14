#!/bin/bash

#
# adapter_n_to_1_generator script generates a verilog module in a file
# adapter_${n}_to_1.v where ${n} is the first argument passed to the script
# a second arguments ${d} indicates the data width of the adapter, both
# arguments must be integers, otherwise the script will not do anything.
#
# Example
# To generate a 4 to 1 adapter with data width of 16 bits, use
#
# $ ./adapter_n_to_1_generator.sh 4 16
#
# This will generate a module with 4 16bits intputs r0, r1, r2, r3
# and a 64bits output r, being so that r = {r0, r1, r2, r3}.
#

# First argument
n=$1

# Second argument
d=$2

# Regular expression allows only integers.
#
# ^ : at beging of string.
# [0-9]+ : any number character from 0 to 9, one or more times.
# $ : ar end of string.
re='^[0-9]+$'

# check first argument is integer.
if ! [[ $n =~ $re ]] ; then
  # exit if so.
  echo "error: input value 1 ($n) is not a number" >&2; exit 1

# check if second argument is integer.
elif ! [[ $d =~ $re ]] ; then
 # exit if so.
  echo "error: input value 2 ($d) is not a number" >&2; exit 1
else
  new_filename="adapter_${n}_to_1.v";
  echo "${new_filename} will be generated/overwritten"

  # generate a string which indicates outputs
  # "r0, r1, ..., rn"
  for ((i=0; i<$n; i++)) do
    inputs="${inputs}r${i}";
    if [ $i != $((n-1)) ]; then
      inputs="$inputs, ";
    fi
  done

  # touch file to write module
  # (make sure it exists)
  touch ${new_filename}

  # overwrite module
  echo "\`ifndef adapter_${n}_to_1_module
\`define adapter_${n}_to_1_module

module adapter_${n}_to_1 #(
  parameter DATA_WIDTH=${d},
  parameter N_INPUTS=${n}
) (
  input [DATA_WIDTH-1:0] ${inputs},
  output [(N_INPUTS*DATA_WIDTH)-1:0] r
);
  assign r = {${inputs}};
endmodule

\`endif
" > ${new_filename}
fi
