module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output reg disc,
    output reg flag,
    output reg err);
    
    reg state ;
    localparam normal =0, errorlock = 1;
    
    reg [7:0] last8;
    localparam [6:0] _disc = 7'b0111110, _error = 7'b1111111;
    localparam [7:0]  _flag = 8'b01111110;
    
    always @(posedge clk)begin
        if (reset)begin
            last8 <= 0;
            state <= normal;
            err<= 1'b0;
            disc <= 1'b0;
            flag <= 1'b0;
        end
        else begin
            last8 <= {in, last8[7:1]};
            case (state)
                
                normal : begin
                    casez ({in, last8[7:1]})

                        {_disc,1'b? }: begin
                            disc <= 1'b1;
                        end

                        _flag:begin
                            flag<= 1'b1;
                            
                        end

                        {_error, 1'b?}: begin
                            err <= 1'b1;
                            state <= errorlock;
                            
                        end
                        default: begin
                            err<= 1'b0;
                            disc <= 1'b0;
                            flag <= 1'b0;
                        end
                    endcase
                end
                
                errorlock: begin
                    if (~in ) begin
                        err<= 0;
                        state <= normal ;
                    end
                        
                end
                
            endcase
        end
    end
endmodule
