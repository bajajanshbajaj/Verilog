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
            state <= zero;
        end
        else begin
            case (state)
                zero:begin
                    if(x)
                        state <= one;
                end
                one:begin
                end
            endcase
        end
    end
    
    always @(*) begin
        case (state)
            zero: z = x;
            one:  z = ~x;
        endcase
    end
            
            
            

endmodule
