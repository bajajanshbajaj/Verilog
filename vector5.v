module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    wire [24:0] one;
    wire [24:0] two; 
    assign one = {{5{a}},{5{b}},{5{c}},{5{d}},{5{e}}};
    assign two = {{5{a,b,c,d,e}}};
    assign out = ~ one ^ two;

endmodule