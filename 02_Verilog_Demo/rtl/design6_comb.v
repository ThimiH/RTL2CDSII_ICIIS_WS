// Combinational implementation of Design 6 adder.
module design6_comb #(parameter WIDTH = 4) (
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [WIDTH-1:0] C,
    input  wire [WIDTH-1:0] D,
    output wire [WIDTH+1:0] F
);
    assign F = A + B + C + D;
endmodule
