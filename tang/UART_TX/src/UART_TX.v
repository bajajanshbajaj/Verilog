module UART_TX (
    input clk,
    input [7:0] data,
    input send,
    input load,
    input rst,
    output reg tx
);

    reg [1:0] currentState = 2'b0;
    reg [9:0] dataShift = 10'b1111111111;
    reg [3:0] dataShiftCount = 0;

    parameter freq = 27000000;
    parameter baud = 3000000;
    localparam waitClocks = freq / baud;
    reg [7:0] waitClockCount = 0; 

    localparam _Idle = 2'h0;
    localparam _Send = 2'h1;
    localparam _Wait = 2'h2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            dataShiftCount <= 0;
            waitClockCount <= 0;
            dataShift <= {10{1'b1}};
            tx <= 1;
            currentState <= _Idle;
        end else begin
            case(currentState)
                _Idle: begin
                    tx <= 1;
                    if (load) begin
                        dataShift <= {1'b1, data, 1'b0}; // stop, data, start
                        dataShiftCount <= 0;
                        waitClockCount <= 0;
                        currentState <= _Send;
                    end
                end

                _Send: begin
                    tx <= dataShift[0];
                    currentState <= _Wait;
                end

                _Wait: begin
                    waitClockCount <= waitClockCount + 1'b1;
                    if (waitClockCount == waitClocks - 2) begin
                        waitClockCount <= 0;
                        dataShift <= {1'b1, dataShift[9:1]};
                        dataShiftCount <= dataShiftCount + 1;

                        if (dataShiftCount == 9) begin
                            currentState <= _Idle;
                        end else begin
                            currentState <= _Send;
                        end
                    end
                end
            endcase
        end
    end

endmodule
