module top_module(
    input in,
    input reg [1:0] state,
    output reg [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    
    always @(*) begin 
        case(state) 
            A: begin
                next_state = in?B:A;
                out = 0;
            end
            B: begin
                next_state = in?B:C;
                out = 0;
            end
            C: begin
                next_state = in?D:A;
                out = 0;
            end
            D: begin
                next_state = in?B:C;
                out = 1;
            end
            
        endcase
        
    end

    // State transition logic: next_state = f(state, in)

    // Output logic:  out = f(state) for a Moore state machine

endmodule
