//----------------------------
// Module: clock_gen
//
//
// Generates a clock waveform
//----------------------------
`timescale 100us / 100us


module clock_gen(
    clk
);
    // Output Port declaration
    output reg clk;

    // Auxiliar declarations
    parameter PERIOD = 2;

    initial begin: INITIALIZE
        clk = 0;
    end

    always begin: CLOCK_GENERATION
        #(PERIOD/2);
        clk = ~clk;
    end

endmodule