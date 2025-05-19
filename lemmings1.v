module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);  

    parameter LEFT = 0, RIGHT = 1;
    reg state, next_state;

    always @(*) begin
        if (bump_left & bump_right)
            next_state = ~state;
        else begin
            case (state)
                LEFT:  next_state = bump_left ? RIGHT : LEFT;
                RIGHT: next_state = bump_right ? LEFT : RIGHT;
            endcase
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
