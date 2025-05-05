module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    reg ff;
    assign Q =ff;
    always @(posedge clk) ff <= j&k?~ff:(~(j|k)?ff:(j&~k));
endmodule
