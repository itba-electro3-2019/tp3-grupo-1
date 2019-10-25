//--------------------------------
// 1 bit select line mulltiplexer
// author: Lucas A. Kammann
//--------------------------------
module mux_1(
    in,
    out,
    select_line
);

    // Input Port declaration
    input [1:0] in;
    input select_line;

    // Output Port declaration
    output reg out;

    // Behavioral modelling code...
    always @(in, select_line) begin
        if (select_line == 0)
            out = in[0];
        else if (select_line == 1)
            out = in[1];
    end

endmodule