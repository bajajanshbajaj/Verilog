module top_module(
    input clk,
    input in,
    input reset,
    output reg out); //
    reg [0:1] state;
    parameter A =0, B=1, C=2, D=3;
    always @(posedge clk )begin
        if (reset) state<=A;
        else case(state)
            A: state <= in?B:A;
            B: state <= in?B:C;
            C: state <= in?D:A;
            D: state <= in?B:C;
        endcase
    end
    always @(*) begin
        if(state == D) out = 1;
        else out =0 ;
    end
endmodule
