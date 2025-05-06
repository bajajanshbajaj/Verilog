module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output reg [3:1] ena,
    output reg [15:0] q);
    
    assign ena[1] = q[0]&q[3];
    assign ena[2] = q[4]&q[7]&q[0]&q[3];
    assign ena[3] = q[8]&q[11]&q[4]&q[7]&q[0]&q[3];
    
    always @(posedge clk)begin

        if(reset) begin
            q <= 16'h0000 ;
        end
        else begin
            
            if (q[3:0] == 4'b1001)begin
                if (q[7:4] == 4'b1001)begin
                    if (q[11:8] == 4'b1001)begin
                        if (q[15:12] == 4'b1001)begin
                            q <= 16'h0000;
                        end
                        else begin
                            q<= q+ 12'b011001100111;
                            //ena <= 3'b111;
                        end
                    end
                    else begin
                        q<= q+ 8'b01100111; 
                        //ena <= 3'b011;
                    end
                end
                else begin
                    q<= q+ 4'b0111;
                    //ena <= 3'b001;
                end
            end
			else begin
                q <= q + 1;
                //ena <= 3'b000;
            end 
        end
    end
                 

endmodule
