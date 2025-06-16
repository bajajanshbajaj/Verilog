module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
); 
    reg [1:0] last2;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            last2 <= 2'b00;
        end
        else begin

            last2 <= {last2[0], x};
        end
    end
    
    always @(*) begin
        if (aresetn)begin
            // Check for 3-bit sequence 101
            if ({last2, x} == 3'b101)
                z <= 1;
            else
                z <= 0;
            
        end
        else
            z <= 0;
    end
                
                
        
endmodule
