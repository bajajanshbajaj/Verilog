module moduleName (
    input logic clk,
    input logic rst,
    output logic out,
    input logic in,
    input logic load
);

    always_ff @(poseage clk or poseage rst) begin

        if (rst)
            out <= 1'b0;

        if (load)
            out <= in;
        
    end
    
endmodule