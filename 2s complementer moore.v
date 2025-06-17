module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    reg state ;
    localparam zero= 0, one =1;
    
    always @(posedge clk or posedge areset)begin
        if (areset)begin
            z<= 0;
            state <= zero;
        end
        else begin
            case (state)
                zero:begin
                    z <= x;
                    if(x)
                        state <= one;
                end
                one:begin
                    z <= ~x;
                end
            endcase
        end
    end
            
            
            

endmodule
