
module riple_carry_adder_tb;

    parameter N = 8;

    reg [N-1:0] A;
    reg [N-1:0] B;
    reg Cin;
    wire [N-1:0] Sum;
    wire Cout;

    riple_carry_adder #(N) uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("riple_carry_adder_tb.vcd");
        $dumpvars(0, riple_carry_adder_tb);
    end

    initial begin
        // Test case 1
        A = 8'b00001111; // 15
        B = 8'b00000001; // 1
        Cin = 0;
        #10;
        $display("Test 1: A=%b, B=%b, Cin=%b => Sum=%b, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 2
        A = 8'b11111111; // 255
        B = 8'b00000001; // 1
        Cin = 0;
        #10;
        $display("Test 2: A=%b, B=%b, Cin=%b => Sum=%b, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 3
        A = 8'b10101010; // 170
        B = 8'b01010101; // 85
        Cin = 1;
        #10;
        $display("Test 3: A=%b, B=%b, Cin=%b => Sum=%b, Cout=%b", A, B, Cin, Sum, Cout);

        // Test case 4
        A = 8'b00000000; // 0
        B = 8'b00000000; // 0
        Cin = 0;
        #10;
        $display("Test 4: A=%b, B=%b, Cin=%b => Sum=%b, Cout=%b", A, B, Cin, Sum, Cout);

        $finish;
    end
endmodule