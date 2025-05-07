module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    x x1(LEDR[2], SW[0], KEY, LEDR[0]);
    x x2(LEDR[0], SW[1], KEY, LEDR[1]);
    x x3(LEDR[1]^LEDR[2], SW[2], KEY, LEDR[2]);

endmodule
module x(
    input Qin,
    input r,
    input [1:0] key,
    output reg Qout);
    always @(posedge key[0])begin
        Qout <= key[1]?r:Qin;
    end
endmodule
    
