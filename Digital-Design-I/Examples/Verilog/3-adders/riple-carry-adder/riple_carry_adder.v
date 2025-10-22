
module riple_carry_adder #(
    parameter N = 8
)
(
    input [N-1:0] A,
    input [N-1:0] B,
    input Cin,
    output [N-1:0] Sum,
    output Cout
);
    
    wire [N:0] C;
    assign C[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : full_adder_block
            fa full_adder (
                .a(A[i]),
                .b(B[i]),
                .cin(C[i]),
                .sum(Sum[i]),
                .cout(C[i+1])
            );
        end
    endgenerate

    assign Cout = C[N];


endmodule