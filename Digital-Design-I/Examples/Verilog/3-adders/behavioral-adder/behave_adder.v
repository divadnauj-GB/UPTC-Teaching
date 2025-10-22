
module behave_adder #(
    parameter N = 8
)
(
    input [N-1:0] A,
    input [N-1:0] B,
    input Cin,
    output [N-1:0] Sum,
    output Cout
);
    
    wire [N:0] sum_with_carry;
    assign sum_with_carry = {A[N-1],A} + {B[N-1],B} + {{(N-1){1'b0}},Cin};
    assign Sum = sum_with_carry[N-1:0];
    assign Cout = sum_with_carry[N];


endmodule