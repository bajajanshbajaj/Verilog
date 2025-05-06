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
            hh <= 8'd12;  // 12 in hex
            mm <= 8'd00;
            ss <= 8'd00;
            pm <= 1'b0;
        end
        else if (ena) begin
            if (ss == 8'd59) begin
                ss <= 8'd00;  // Reset seconds to 00
                if (mm == 8'd59) begin
                    mm <= 8'd00;  // Reset minutes to 00
                    if (hh == 8'd59) begin
                        hh <= 8'd12;  // Reset hour to 12
                        pm <= ~pm;    // Toggle PM
                    end
                    else if (hh == 8'd12) begin
                        hh <= 8'd01;  // Reset hour to 1 after 12
                    end
                    else begin
                        hh <= hh + 1;  // Increment hour
                    end
                end
                else begin
                    mm <= mm + 1;  // Increment minute
                end
            end
            else begin
                ss <= ss + 1;  // Increment second
            end
        end
    end
    
    // Display values in decimal (for debugging)
endmodule
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
            hh <= 8'd12;
            mm <= 8'd0;
            ss <= 8'd0;
            pm <= 0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss < 8'd59) begin
                ss <= ss + 1;
            end
            else begin
                ss <= 8'd0;

                // Increment minutes
                if (mm < 8'd59) begin
                    mm <= mm + 1;
                end
                else begin
                    mm <= 8'd0;

                    // Increment hours
                    if (hh == 8'd11) begin
                        hh <= 8'd12;
                        pm <= ~pm; // Flip AM/PM
                    end
                    else if (hh == 8'd12) begin
                        hh <= 8'd1;
                    end
                    else begin
                        hh <= hh + 1;
                    end
                end
            end
        end
    end

endmodule

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
            hh <= 8'd12;  // 12 in hex
            mm <= 8'd00;
            ss <= 8'd00;
            pm <= 1'b0;
        end
        else if (ena) begin
            if (ss == 8'd59) begin
                ss <= 8'd00;  // Reset seconds to 00
                if (mm == 8'd59) begin
                    mm <= 8'd00;  // Reset minutes to 00
                    if (hh == 8'd59) begin
                        hh <= 8'd12;  // Reset hour to 12
                        pm <= ~pm;    // Toggle PM
                    end
                    else if (hh == 8'd12) begin
                        hh <= 8'd01;  // Reset hour to 1 after 12
                    end
                    else begin
                        hh <= (hh[3:0] < 4'b1001)?hh +1:{ss[7:4]+1 , 4'b1001};  // Increment hour
                    end
                end
                else begin
                    mm <= (mm[3:0] < 4'b1001)?mm +1:{mm[7:4]+1 , 4'b1001};  // Increment minute
                end
            end
            else begin
                ss <= (ss[3:0] < 4'b1001)?ss +1:{ss[7:4]+1 , 4'b1001};
                // Increment second
            end
        end
    end
    
    // Display values in decimal (for debugging)
endmodule
