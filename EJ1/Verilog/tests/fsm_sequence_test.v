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
    reg [1:0] sensors;
    reg reset;
    wire [1:0] pumps;

    wire next_state;
    wire current_state;

    integer count;
    integer i;

    //----------------- CONSTANT VALUES -----------------------
    parameter BIT_MASK = 4'b1000;
    
    //----------------- MODULE INSTANCES -----------------------
    clock_gen #(.PERIOD(2)) my_clk(clock);
    fsm_sequence my_fsm(clock, reset, sensors, pumps, next_state, current_state);

    /* ¡Testing code! */
    initial begin: TESTING
        sensors = 2'b00;
        #2 reset = 1;
        #2 reset = 0;
        #2 $display("Testing I=0 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);

        #2 sensors = 2'b01;
        #2 
        #2 $display("Testing I=1 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);

        #2 sensors = 2'b11;
        #2 
        #2 $display("Testing I=1 S=1. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);

        #2 sensors = 2'b01;
        #2 
        #2 $display("Testing I=1 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b00;
        #2 
        #2 $display("Testing I=0 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b01;
        #2 
        #2 $display("Testing I=1 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b00;
        #2 
        #2 $display("Testing I=0 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b11;
        #2 
        #2 $display("Testing I=1 S=1. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b00;
        #2 
        #2 $display("Testing I=0 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b01;
        #2 
        #2 $display("Testing I=1 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b10;
        #2 
        #2 $display("Testing impossible situation. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);
        
        #2 sensors = 2'b01;
        #2 
        #2 $display("Testing I=1 S=0. Output: %b%b. Next state is %b. Current state is %b", pumps[1], pumps[0], next_state, current_state);

        #5

        $finish;
    end

    /* ¡Creating GTKWave File! */
    initial begin: GTKWAVE_FILE
        $dumpfile("bin/output.vcd");
        $dumpvars(0, fsm_sequence_test);
    end
endmodule