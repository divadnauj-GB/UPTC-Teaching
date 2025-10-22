module dff_tb;

    reg clk;
    reg rst_n;
    reg en;
    reg d;
    wire q;
    wire qn;

    // Instantiate the D flip-flop
    dff uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .d(d),
        .q(q),
        .qn(qn)
    );

    initial begin
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, dff_tb);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst_n = 0;
        en = 0;
        d = 0;

        // Release reset
        #12;
        rst_n = 1;

        // Test enabling and data input
        #10;
        en = 1; d = 1; // Enable and set d to 1
        #10;
        d = 0;         // Change d to 0
        #10;
        en = 0;       // Disable
        #10;
        d = 1;         // Change d to 1 while disabled
        #10;
        en = 1;       // Enable again
        #10;

        // Finish simulation
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | rst_n: %b | en: %b | d: %b | q: %b | qn: %b", 
                  $time, rst_n, en, d, q, qn);
    end
endmodule