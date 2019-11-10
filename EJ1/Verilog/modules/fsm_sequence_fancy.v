//--------------------------------------------------------------------------------
// Module: fsm_sequence
//
// Implementation for a fsm that detects a serial sequence of bits 1-1-0-1, 
// using a behavioral pattern/style for the module's code. It is a Mealy Machine.
//--------------------------------------------------------------------------------

module fsm_sequence(
    clock,              // Clock input of the synchronous sequential design
    reset,              // Active high, synchronous reset input
    level_sensors,      // Input sensors for the fsm
    pumps               // Output controlling the pumps
);

    //----------------- INPUT PORTS -----------------------------
    input wire clock;
    input wire reset;
    input wire [1:0] level_sensors;  // First bit is I sensor, second bit is S sensor

    //----------------- OUTPUT PORTS ----------------------------
    output reg [1:0] pumps;         // First bit is B1 pump, second bit is B2 pump

    //----------------- INTERNAL VARIABLES ----------------------
    reg current_state;
    reg next_state;

    //----------------- FSM STATES ------------------------------
    parameter LAST_1 = 1'b0;
    parameter LAST_2 = 1'b1;

    /* Initialization of the FSM */ 
    initial begin: INITIALIZATION
        current_state = LAST_1;
        next_state = LAST_1;
        pumps = 2'00;
    end
    
    /* Combinational part of the FSM, calculates the next state and the output */
    always @ (current_state or I or S) begin: COMBINATIONAL_CODE
        next_state = current_state;

        case(current_state)
            /* Current state is LAST_1, which is the next state?*/
            LAST_1: begin
                case(level_sensors)
                    // Water is below both sensors, then both pumps are off, and the pump that has to run by itself changes (state changes)
                    2'b00: begin
                        pumps = 2'b00;
                        next_state = LAST_2;
                    end
                    // Water is inbetween the senors, then, since current state is LAST_1, B1 continues to be on
                    2'b01: begin
                        pumps = 2'b01;
                        next_state = LAST_1;
                    end
                    // Water is above both sensors, then both pumps are on, and the pump that has to run by itself changes (state changes)
                    2'b11: begin
                        pumps = 2'11;
                        next_state = LAST_2;
                    end
                    // Impossible case when the sensors indicate water is above S and below I, for safety, both pumps are shut down
                    2'b10: begin
                        pumps = 2'b00;
                        next_state = LAST_1;
                    end
            end

            /* Current state is LAST_2, which is the next state?*/
            LAST_2: begin
                case(level_sensors)
                    // Water is below both sensors, then both pumps are off, and the pump that has to run by itself changes (state changes)
                    2'b00: begin
                        pumps = 2'b00;
                        next_state = LAST_1;
                    end
                    // Water is inbetween the senors, then, since current state is LAST_2, B2 continues to be on
                    2'b01: begin
                        pumps = 2'b10;
                        next_state = LAST_2;
                    end
                    // Water is above both sensors, then both pumps are on, and the pump that has to run by itself changes (state changes)
                    2'b11: begin
                        pumps = 2'11;
                        next_state = LAST_1;
                    end
                    // Impossible case when the sensors indicate water is above S and below I, for safety, both pumps are shut down
                    2'b10: begin
                        pumps = 2'b00;
                        next_state = LAST_2;
                    end
            end

            /* Error, not defined the state, go to reset */
            default: begin
                current_state = LAST_1;
                pumps = 2'b00;
            end
        endcase
    end

    /* Sequential part of the FSM, updates the next state of the FSM */
    always @(posedge clock) begin: SEQUENTIAL_CODE
        if (reset) begin
            current_state = LAST_1;
        end else begin
            current_state = next_state;
        end
    end

endmodule