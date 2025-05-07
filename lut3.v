module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z 
); 
    wire [2:0] sel;
    assign sel = {A, B, C};

    reg [7:0] Q;  // 8-bit shift register

    assign Z = Q[sel];  // Select one bit from Q

    always @(posedge clk) begin
        if (enable) begin
            Q <= { Q[6:0], S };  // Shift left and insert S at MSB
        end
    end
endmodule
