module top_module (
    input clk,          
    output reg out,
    output reg led
);

    // Baud rate parameters
    
    localparam CLK_FREQ = 27000000;
    localparam BAUD_RATE = 9600;
    localparam BAUD_DIV = 2812;  

    reg is9600 = 0 ;
    reg [10:0] counter = 11'b0;


    reg [7:0] data = 8'b1;
    reg ena = 1'b1;

    wire [9:0] datafull ;
    reg [3:0] countToTen = 4'b0;

    assign datafull= {1'b0 , data, 1'b1};



    always @(posedge clk)begin
        if(counter == BAUD_DIV -1)begin
            is9600 <= 1;
            counter <= 11'b0;

        end

        else begin
            is9600 <= 0;
            counter <= counter + 1'b1 ;
        end
        

    
    

        if (is9600 == 1) begin

            if (ena) begin
                out <= datafull[countToTen];
                if (countToTen == 4'd9)begin
                    countToTen <= 4'b0;
                    led <= 1;
                end
                else begin
                    led <=0;
                    countToTen <= countToTen +4'b1 ;
                end
            end

            else begin
                out <= 1;
            end

        end

    end
endmodule
