module top_UART_TX (
    input clk,          // 27 MHz clock input
    output tx           // UART TX output
);

    reg [5:0] clk_count = 0;
    reg load = 0;

    wire rst = 0;
    wire send = 1;
    wire [7:0] data = 8'h61; // ASCII 'a'

    // Generate load signal: high for 1 cycle every 50 cycles
    always @(posedge clk) begin
        if (clk_count == 49) begin
            clk_count <= 0;
            load <= 1;
        end else begin
            clk_count <= clk_count + 1;
            load <= 0;
        end
    end

    UART_TX uart_tx_inst (
        .clk(clk),
        .data(data),
        .send(send),
        .load(load),
        .rst(rst),
        .tx(tx)
    );

endmodule
