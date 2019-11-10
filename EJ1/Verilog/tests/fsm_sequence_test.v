//---------------------------------------
// Module: fsm_sequence_test
//
// Testbench of the fsm_sequence module.
//---------------------------------------

// Using the timescale directive to be used in the ticks
`timescale 100us / 100us

module fsm_sequence_test();

    //----------------- INTERNAL VARIABLES ---------------------
    wire clock;
    wire z;

    reg reset;
    reg w;

    integer count;
    integer i;

    //----------------- CONSTANT VALUES -----------------------
    parameter BIT_MASK = 4'b1000;
    
    //----------------- MODULE INSTANCES -----------------------
    clock_gen #(.PERIOD(2)) u_clk(clock);
    fsm_sequence u_fsm(clock, reset, w, z);

    /* ¡Testing code! */
    initial begin: TESTING
        w = 0;
        #2 reset = 1;
        #2 reset = 0;

        #2 w = 0;
        #2 w = 1;
        #2 w = 0;
        #2 $display("Testing 0-1-0. Output: %b", z);

        #2 w = 1;
        #2 w = 1;
        #2 w = 1;
        #2 w = 0;
        #2 w = 0;
        #2 $display("Testing 1-1-1-0-0. Output: %b", z);

        #2 w = 1;
        #2 w = 1;
        #2 w = 0;
        #2 w = 1;
        #1 $display("Testing 1-1-0-1. Output: %b", z);
        #5

        $finish;
    end

    /* ¡Creating GTKWave File! */
    initial begin: GTKWAVE_FILE
        $dumpfile("bin/output.vcd");
        $dumpvars(0, fsm_sequence_test);
    end
endmodule