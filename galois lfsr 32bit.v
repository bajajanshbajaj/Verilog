module top_module(
    input clk,
    input reset,    
    output reg [31:0] q
); 
    wire feedback;
    assign feedback = q[0];
    reg [31:0] q_next;
    always @(*) begin 
        q_next = {q[0],
                  q[31:23],
                  q[22]^feedback,
                  q[21:3] ,
                  q[2]^feedback,
                  q[1]^feedback
                 };

	end

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
	end
	
endmodule
