module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
); //
    reg [1:0] state ;
    reg [2:0] counter; 
    localparam idle = 0, started = 1, stopcondition =2 , errorwait= 3; 
    
    always @(posedge clk ) begin
        if (reset) begin
            state <= idle ;
            counter <= 3'b000;
            done <= 1'b0;
        end
        else begin
            case(state)
                idle:begin 
                    if (in == 1'b0)begin
                        state <= started ;
                        
                    end
                    done <= 1'b0;
                    counter <= 3'b000;
                    
                end
                started:begin
                    out_byte <= {in , out_byte[7:1]};
                    if (counter == 3'b111)begin
                        state <= stopcondition;
                    end
                    else 
                        counter <= counter + 1'b1 ;
                    
                end
                stopcondition:begin
                    if (in == 1'b1)begin
                        done <= 1'b1;
                    	state <= idle;
                    end
                    else 
                        state <= errorwait;
                end
                errorwait:begin
                    if (in == 1'b1)
                    	state <= idle;
                end
            endcase
        end
    end
    

endmodule
