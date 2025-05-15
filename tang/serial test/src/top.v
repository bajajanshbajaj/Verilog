module x (
    input clk,          
    output reg out      
);

    // Baud rate parameters
    localparam CLK_FREQ = 27000000;
    localparam BAUD_RATE = 9600;
    localparam BAUD_DIV = 1406;  
    reg clk2 = 0 ;
    reg [10:0] counter = 11'b0;
    

    reg [7:0] data = 8'b0;
    reg ena = 1'b1;

    wire [9:0] datafull ;
    reg [3:0] countToTen = 4'b0;

    assign datafull= {1'b1 , data, 1'b0};



    always @(posedge clk)begin
        if(counter == BAUD_DIV -1)begin
            clk2 <= ~clk2;
            counter <= 11'b0;

        end

        else begin
            counter <= counter +1 ;
        end
        
    end


    always @(posedge clk2)begin

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


    