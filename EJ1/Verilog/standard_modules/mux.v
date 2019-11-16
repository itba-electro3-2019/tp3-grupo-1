module mux(x, sel, y);
    input [1:0] x;
    input sel;                      // sel selects the exit (x[3], x[2], x[1], x[0]).
    output wire y;

    assign y = (x[0] & ~sel) | (x[1] & sel);

endmodule