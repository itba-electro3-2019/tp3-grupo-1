//-------------------------------------
// Module: flip_flop_d
//
// Flip Flop D with asynchronous reset
//-------------------------------------

module flip_flop_d(
    d,      // Flip Flop D input
    reset,  // High level asynchronous reset
    clk,    // Clock
    q       // Output
);

    // Input Port declaration
    input wire reset;
    input wire clk;
    input wire d;

    // Output Port declaration
    output reg q;
    
    initial begin
        q = 0;
    end

    always @(posedge clk or reset) begin
        if (reset) begin
            q = 0; 
        end else begin
            q = d;
        end
    end
endmodule