module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg [31:0] x, p;
    assign out = p;
    
    always @(posedge clk )begin 
        p <= (x)&(~in)|p; 
        if (reset) begin
            p <= 0;
        end
        else begin
            x <= in;
           
        end
    end
endmodule


