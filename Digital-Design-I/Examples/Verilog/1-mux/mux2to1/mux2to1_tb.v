module mux2to1_tb;

reg   s0_X0   ;
reg   s0_X1   ;
reg   s0_sel  ;
wire   s0_Y    ;        


reg   s1_X0   ;
reg   s1_X1   ;
reg   s1_sel  ;
wire   s1_Y    ; 


reg   s2_X0   ;
reg   s2_X1   ;
reg   s2_sel  ;
wire   s2_Y    ; 

integer s0_idx ;
integer s1_idx ;



mux2to1_v0 MUX0 (
.i_X0(s0_X0), 
.i_X1(s0_X1),
.i_sel(s0_sel),
.o_Y(s0_Y));

mux2to1_v1 MUX1 (
.i_X0(s1_X0), 
.i_X1(s1_X1),
.i_sel(s1_sel),
.o_Y(s1_Y));

initial begin
    $dumpfile("mux2to1_tb.vcd"); 
    $dumpvars (0,mux2to1_tb);
end

integer vals;
initial begin
    s0_sel = 1'b0;
    for(vals=0;vals<4;vals=vals+1) begin
        s0_X0 = vals[0];
        s0_X1 = vals[1];
        #10;
        if (s0_Y==vals[0]) begin
            $info("Condition met.");
        end else begin
            $error("Assertion failed: Condition not met!");
        end
    end
    s0_sel = 1'b1;
    vals = 0;
    #1;
    for(vals=0;vals<4;vals=vals+1) begin
        s0_X0 = vals[0];
        s0_X1 = vals[1];
        #10;
        if (s0_Y==vals[1]) begin
            $info("Condition met.");
        end else begin
            $error("Assertion failed: Condition not met!");
        end
    end
end

integer valss;
initial begin
    s1_sel = 1'b0;
    for(valss=0;valss<4;valss=valss+1) begin
        s1_X0 = valss[0];
        s1_X1 = valss[1];
        #10;
        if (s1_Y==valss[0]) begin
            $info("Condition met.");
        end else begin
            $error("Assertion failed: Condition not met!");
        end
    end
    s1_sel = 1'b1;
    valss = 0;
    #1;
    for(valss=0;valss<4;valss=valss+1) begin
        s1_X0 = valss[0];
        s1_X1 = valss[1];
        #10;
        if (s1_Y==valss[1]) begin
            $info("Condition met.");
        end else begin
            $error("Assertion failed: Condition not met!");
        end
    end
end
endmodule;


