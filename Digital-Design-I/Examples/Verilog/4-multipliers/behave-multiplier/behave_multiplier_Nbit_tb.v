module behave_multiplier_Nbit_tb;
    parameter N = 4;
    reg [N-1:0] A;
    reg [N-1:0] B;
    wire [2*N-1:0] P;

    // Instantiate the array multiplier
    behave_multiplier_Nbit #(N) uut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin
        $dumpfile("behave_multiplier_Nbit_tb.vcd");
        $dumpvars(0, behave_multiplier_Nbit_tb);
    end

    initial begin
        // Test case 1
        A = 4'b0011; // 3
        B = 4'b0101; // 5
        #10;
        $display("A = %b, B = %b, P = %b (Expected: 0000001111)", A, B, P);

        // Test case 2
        A = 4'b1111; // 15
        B = 4'b1111; // 15
        #10;
        $display("A = %b, B = %b, P = %b (Expected: 0011100001)", A, B, P);

        // Test case 3
        A = 4'b1010; // 10
        B = 4'b0011; // 3
        #10;
        $display("A = %b, B = %b, P = %b (Expected: 0000011110)", A, B, P);

        // Test case 4
        A = 4'b0000; // 0
        B = 4'b1111; // 15
        #10;
        $display("A = %b, B = %b, P = %b (Expected: 0000000000)", A, B, P);

        // Test case 5
        A = 4'b1001; // 9
        B = 4'b1001; // 9
        #10;
        $display("A = %b, B = %b, P = %b (Expected: 0001010001)", A, B, P);

        $finish;
    end
endmodule