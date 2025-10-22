module dff (
    input clk,
    input rst_n,
    input en,
    input  d,
    output q,
    output qn
);

    reg q_reg;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            q_reg <= 1'b0;
        end else begin
            if (en) begin
                q_reg <= d; 
            end
        end
    end

    assign q = q_reg;
    assign qn = ~q_reg;
    
endmodule