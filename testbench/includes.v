
// ENABLE SYNTHETIZED MODULES
`define SYNTH = 1

// ENABLE BEHAVOURIAL ASSERTIONS
`define BEHAVOURIAL = 1

`ifdef SYNTH
  // LIB
  `ifdef COMPILACION
    // `include "lib/osu05_stdcells.v"
    `include "lib/osu018_stdcells.v"
    // `include "lib/osu025_stdcells.v"
    // `include "lib/osu035_stdcells.v"
  `endif
`endif