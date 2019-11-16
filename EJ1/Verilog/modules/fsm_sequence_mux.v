//--------------------------------------------------------------------------------
// Module: fsm_sequence
//
// Implementation for a fsm that commands two pumps B1 and B2, given the signals 
// of two sensors I (lower) and S (upper) that are high when water in a tank 
// reaches their level.
// This module uses a behavioral pattern/style for the module's code.
// It is a Mealy Machine.
//--------------------------------------------------------------------------------

module fsm_sequence(
    clock,              // Clock input of the synchronous sequential design
    reset,              // Active high, synchronous reset input
    level_sensors,      // Input sensors for the fsm
    pumps,              // Output controlling the pumps
    next_state,         // Next state, for debugging
    current_state      // Current state, for debugging
);

    //----------------- INPUT PORTS -----------------------------
    input wire clock;
    input wire reset;
    input wire [1:0] level_sensors;  // First bit is I sensor, second bit is S sensor

    //----------------- OUTPUT PORTS ----------------------------
    output wire [1:0] pumps;         // First bit is B1 pump, second bit is B2 pump
    output wire next_state;
    output wire current_state;

    //----------------- INTERNAL VARIABLES ----------------------

    //----------------- MODULE INSTANCES ------------------------
    fsm_next_state my_next_state(current_state, level_sensors, next_state);
    flip_flop_d my_ffd(next_state, reset, clock, current_state);
    fsm_output_B1 my_B1(current_state, level_sensors, pumps[0]);
    fsm_output_B2 my_B2(current_state, level_sensors, pumps[1]);


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
    input wire current_state;
    input wire [1:0] in;

    //----------------- OUTPUT PORTS ----------------------
    output wire next_state;

    //----------------- AUX MODULES -----------------------
    wire [1:0] mux_inputs;
    mux my_mux(mux_inputs, in[0], next_state);

    /* Output gate connection */
    assign mux_inputs[0] = (in[1] ^ current_state) ^ 1;
    assign mux_inputs[1] = in[1] ^ current_state;

endmodule

//--------------------------------------------------
// Module: fsm_output
//
// Combinational logic to set the output B1 of the fsm
//---------------------------------------------------

module fsm_output_B1(
    current_state,  // Current state of the fsm
    in,     // Current input of the fsm
    B1      // Output of the fsm
);

    //----------------- INPUT PORTS -----------------------
    input wire current_state;
    input wire [1:0] in;

    //----------------- OUTPUT PORTS ----------------------
    output wire B1;

    //----------------- AUX MODULES -----------------------
    wire [1:0] mux_inputs;
    mux my_mux(mux_inputs, in[0], B1);

    /* Output gate connection */
    assign mux_inputs[0] = ~(in[1] | in[1]);
    assign mux_inputs[1] = ~(current_state | in[1]);

endmodule

//--------------------------------------------------
// Module: fsm_output
//
// Combinational logic to set the output B2 of the fsm
//---------------------------------------------------

module fsm_output_B2(
    current_state,  // Current state of the fsm
    in,     // Current input of the fsm
    B2      // Output of the fsm
);

    //----------------- INPUT PORTS -----------------------
    input wire current_state;
    input wire [1:0] in;

    //----------------- OUTPUT PORTS ----------------------
    output wire B2;

    //----------------- AUX MODULES -----------------------
    wire [1:0] mux_inputs;
    mux my_mux(mux_inputs, in[0], B2);

    /* Output gate connection */
    assign mux_inputs[0] = ~(in[1] | in[1]);
    assign mux_inputs[1] = ~(in[1] | ~(current_state | current_state));

endmodule