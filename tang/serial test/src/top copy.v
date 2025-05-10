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
    reg [15:0] uartcount;
    reg x = 0;

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
        if (uartcount > 16'd8)begin
            out <= 1'b1;
            if (uartcount == 16'd20000)
                uartcount <= 0;
        end
        else if (uartcount == 0)begin
            out <= 1'b0;
            uartcount <= uartcount+1;
        end
        else begin
            out <= 1;
            
            uartcount <= uartcount+1;
        end
        
    end




    
endmodule
