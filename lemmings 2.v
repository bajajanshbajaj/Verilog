module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    localparam LEFT = 0, LEFTFALL= 1, RIGHT = 2, RIGHTFALL = 3;
    
    reg [1:0] state, nextstate ;
    
    always @(*) begin
        case(state)
            LEFT: begin
                if (!ground) 
                    nextstate = LEFTFALL;
                else if (bump_left)
                    nextstate = RIGHT;
                else
                    nextstate = LEFT;
            end
            RIGHT:begin
                if (!ground) 
                    nextstate = RIGHTFALL;
                else if (bump_right)
                    nextstate = LEFT;
                else 
                    nextstate = RIGHT;
            end
            LEFTFALL: begin
                if(ground)
                    nextstate = LEFT;
                else 
                    nextstate = LEFTFALL;
            end
            
            RIGHTFALL: begin
                if(ground)
                    nextstate = RIGHT;
                else 
                    nextstate = RIGHTFALL;
            end
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= nextstate;
    end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == LEFTFALL)|(state ==RIGHTFALL);

endmodule	

