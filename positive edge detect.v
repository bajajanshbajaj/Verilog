module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] x, p;
    assign pedge = p;
    
    always @(posedge clk )begin 
        x <= in;
        p <= (~x)&in; 
    end
endmodule
