//--------------------------------------------------------------------------------
// Module: fsm_sequence
//
// Implementation for a fsm that detects a serial sequence of bits 1-1-0-1, 
// using a behavioral pattern/style for the module's code. It is a Mealy Machine.
//--------------------------------------------------------------------------------

module fsm_sequence(
    clock,  // Clock input of the synchronous sequential design
    reset,  // Active high, synchronous reset input
    w,      // Serial sequence of input bits
    z       // Output of the fsm
);

    //----------------- INPUT PORTS -----------------------------
    input wire clock;
    input wire reset;
    input wire w;

    //----------------- OUTPUT PORTS ----------------------------
    output wire z;

    //----------------- INTERNAL VARIABLES ----------------------
    wire [1:0] current_state;
    wire [1:0] next_state;

    //----------------- MODULE INSTANCES ------------------------
    fsm_next_state u_next_state(current_state, w, next_state);
    flip_flop_d u_ffd_0(next_state[0], reset, clock, current_state[0]);
    flip_flop_d u_ffd_1(next_state[1], reset, clock, current_state[1]);
    fsm_output u_output(current_state, w, z);


endmodule

//------------------------------------------------------------
// Module: fsm_next_state
//
// Combinational logic to determine the next state of the fsm
//------------------------------------------------------------

module fsm_next_state(
    current_state,  // Current state of the fsm
    in,             // Current input of the fsm
    next_state      // Next state of the fsm, output
);

    //----------------- INPUT PORTS -----------------------
    input wire [1:0] current_state;
    input wire in;

    //----------------- OUTPUT PORTS ----------------------
    output wire [1:0] next_state;

    /* Next state connection */
    assign next_state[1] = ~in | current_state[1] & ~current_state[0];
    assign next_state[0] = ~current_state[0] |   in ^ current_state[1];

endmodule

//--------------------------------------------------
// Module: fsm_output
//
// Combinational logic to set the output of the fsm
//---------------------------------------------------

module fsm_output(
    state,  // Current state of the fsm
    in,     // Current input of the fsm
    z       // Output of the fsm
);

    //----------------- INPUT PORTS -----------------------
    input wire [1:0] state;
    input wire in;

    //----------------- OUTPUT PORTS ----------------------
    output wire z;

    /* Output gate connection */
    assign z = in & state[1] & ~state[0];

endmodule