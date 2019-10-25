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
    output reg z;

    //----------------- INTERNAL VARIABLES ----------------------
    reg [1:0] current_state;
    reg [1:0] next_state;

    //----------------- FSM STATES ------------------------------
    parameter [1:0] STATE_A = 2'b11;
    parameter [1:0] STATE_B = 2'b00;
    parameter [1:0] STATE_C = 2'b01;
    parameter [1:0] STATE_D = 2'b10;

    /* Initialization of the FSM */ 
    initial begin: INITIALIZATION
        current_state = STATE_A;
        next_state = STATE_A;
    end
    
    /* Combinational part of the FSM, calculates the next state and the output */
    always @ (current_state or w) begin: COMBINATIONAL_CODE
        next_state = current_state;

        case(current_state)
            /* Current state is STATE_A, which is the next state?*/
            STATE_A: begin
                z = 0;
                if (w == 1) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            /* Current state is STATE_A, which is the next state?*/
            STATE_B: begin
                z = 0;
                if (w == 1) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_A;
                end
            end

            /* Current state is STATE_A, which is the next state?*/
            STATE_C: begin
                z = 0;
                if (w == 0) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end

            /* Current state is STATE_A, which is the next state?*/
            STATE_D: begin
                next_state = STATE_A;
                z = w;
            end

            /* Error, not defined the state, go to reset */
            default: begin
                current_state = STATE_A;
                z = 0;
            end
        endcase
    end

    /* Sequential part of the FSM, updates the next state of the FSM */
    always @(posedge clock) begin: SEQUENTIAL_CODE
        if (reset) begin
            current_state = STATE_A;
        end else begin
            current_state = next_state;
        end
    end

endmodule