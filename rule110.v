module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q );
    reg [513:0] p;
    assign p = {1'b0, q, 1'b0};
    integer i;
    always @(posedge clk)begin
        if (load)
            q<=data;
        else begin
            for (i=0; i<512; i=i+1)begin
                case(p[(i+2)-:3]) // BIT SPLICING WORKS BUT NORMAL RANGE DOESNT WITH  CONSTANTS
                    3'b111 : q[i]<= 0;
                    3'b110 : q[i]<= 1;
                    3'b101 : q[i]<= 1;
                    3'b100 : q[i]<= 0;
                    3'b011 : q[i]<= 1;
                    3'b010 : q[i]<= 1;
                    3'b001 : q[i]<= 1;
                    3'b000 : q[i]<= 0;
                endcase
            end
        end
    end
endmodule
