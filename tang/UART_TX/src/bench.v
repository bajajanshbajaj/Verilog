`timescale 1ns / 1ps

module UART_TX_tb;

    reg clk = 0;
    reg load = 0;
    reg send = 0;
    reg [7:0] data = 8'h41; // 'A'
    wire tx;

    // Instantiate your UART_TX with slower baud for easier debugging
    UART_TX #(
        .freq(4),  // 100 MHz clock for simulation
        .baud(2)
    ) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .send(send),
        .data(data),
        .tx(tx)
    );

    // Clock generation: 10 ns period => 100 MHz
    always #1 clk = ~clk;

    initial begin
        $dumpfile("UART_TX_tb.vcd");
        $dumpvars(0, UART_TX_tb);


        // Wait some clocks
        #3;

        // Send one byte 'A'
        load = 1;
        send = 0;
        #2;       // 1 clock cycle pulse at 100MHz = 10ns
        load = 0;
        send =1 ;

        // Wait enough time for full frame to send (1 start + 8 data + 1 stop bits)
        // At 115200 baud, bit period ~ 8.68 us
        // Total frame = 10 bits * 8.68 us = 86.8 us
        #100;  // 100 us wait

        // Send another byte 'B'
        data = 8'h42;  // 'B'
        load = 1;
        send = 1;
        #10;
        load = 0;
        send = 0;

        #100_000;

        $finish;
    end

endmodule
