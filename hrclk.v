module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010;;
            mm <= 8'd0;
            ss <= 8'd0;
            pm <= 0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss < 8'b01011001) begin
                ss <= (ss[3:0] < 4'b1001)?(ss +1):{ss[7:4]+1 , 4'b0000};
            end
            else begin
                ss <= 8'd0;
                if (mm < 8'b01011001) begin
                    mm <= (mm[3:0] < 4'b1001)?(mm +1):{mm[7:4]+1 , 4'b0000};
                end
                else begin
                    mm <= 8'd0;
                    if (hh == 8'b00010001) begin
                        hh <= 8'b00010010;
                        pm <= ~pm; 
                    end
                    else if (hh == 8'b00010010) begin
                        hh <= 8'd1;
                    end
                    else begin
                        hh <= (hh[3:0] < 4'b1001)?(hh +1):{hh[7:4]+1 , 4'b0000};
                    end
                end
            end
        end
    end

endmodule
