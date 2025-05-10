/*
    UART Transmitter with baud_tick approach
    - No routed clock
    - 27 MHz input clock
    - 9600 baud
    - Single byte transmitted repeatedly
    - Includes synchronous reset
*/
module top_module (
    input  wire clk,        // 27 MHz input clock
    input  wire reset_n,    // active-low reset
    output reg  out         // UART TX output
);

    // Baud rate generator parameters
    localparam integer CLK_FREQ  = 27_000_000;
    localparam integer BAUD_RATE = 9_600;
    // BAUD_DIV = CLK_FREQ / BAUD_RATE = 2812.5; use nearest integer for half-bit count
    localparam integer BAUD_DIV  = CLK_FREQ / BAUD_RATE;

    // fixed byte to transmit (e.g., 0x5F)
    localparam [7:0] DATA_BYTE = 8'h5F;

    // Baud counter
    reg [11:0] baud_cnt;
    wire       baud_tick = (baud_cnt == BAUD_DIV - 1);

    // Shift register and bit counter
    reg [9:0] shift_reg;
    reg [3:0] bit_cnt;

    // Baud counter logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            baud_cnt <= 0;
        end else if (baud_tick) begin
            baud_cnt <= 0;
        end else begin
            baud_cnt <= baud_cnt + 1;
        end
    end

    // UART transmit state machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            shift_reg <= {1'b1, DATA_BYTE, 1'b0}; // Idle high, data, start low
            bit_cnt   <= 0;
            out       <= 1'b1;                     // Idle state: line high
        end else if (baud_tick) begin
            if (bit_cnt == 0) begin
                // Load new frame and send first start bit
                shift_reg <= {1'b1, DATA_BYTE, 1'b0};
                out       <= shift_reg[0];
                bit_cnt   <= 10;  // total bits: start + 8 data + stop
            end else begin
                // Shift out next bit
                out       <= shift_reg[0];
                shift_reg <= shift_reg >> 1;
                bit_cnt   <= bit_cnt - 1;
            end
        end
    end

endmodule
