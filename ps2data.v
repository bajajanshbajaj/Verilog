module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output reg done); //
    
    reg [1:0]state ;
    
    localparam free = 0, rec2= 1, rec3andsend = 2;
    
    always @(posedge clk )begin
        if (reset )begin
            done <= 0 ;
            state <= free ; 
        end
        else begin
            case (state)
                free : begin
                    if (in[3] ==1) begin 
                        state <= rec2;
                        out_bytes[23:16] <= in; 
                        
                    end 
                    done <= 0;
                end
                
                rec2 : begin
                    state <= rec3andsend ;
                    out_bytes [15:8] <= in;
                end
                
                rec3andsend : begin
                    state <= free;
                    out_bytes [7:0] <= in;
                    done <= 1;
                end
            endcase
        end
    end

    // FSM from fsm_ps2

    // New: Datapath to store incoming bytes.

endmodule
