module uart_tx (
    input clk,          
    output reg out      
);
    reg [7:0] data = 8'b0;
    reg ena = 1'b1;

    wire [9:0] datafull ;
    reg [3:0] countToTen = 4'b0;

    assign datafull= {1'b0 , data, 1'b1};

    always @(posedge clk)begin

        if (ena) begin
            out <= datafull[countToTen];
            if (countToTen == 4'd9)begin
                countToTen <= 4'b0;
            end
            else begin
                countToTen <= countToTen +4'b1 ;
            end
        end

        else begin
            out <= 1;
        end
    end
endmodule
