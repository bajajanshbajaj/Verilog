module UART_TX_Top (
    input clk,
    output tx
);

    parameter CLK_FREQ = 27000000;
    parameter SEND_INTERVAL = CLK_FREQ;  // 1 second

    UART_TX uart (
        .clk(clk),
        .rst(0),
        .data(data),
        .load(load),
        .send(1'b0),   // 'send' input is not used in the revised UART_TX; removed for simplicity
        .tx(tx)
    );


    

endmodule
