`timescale 1us / 1ns  // Use microseconds for timing

module tb_uart_tx;

    reg clk;
    wire out;

    // Instantiate the DUT
    uart_tx uut (
        .clk(clk),
        .out(out)
    );

    // Clock generation: 9600 Hz => period ≈ 104.1667 us
    initial begin
        clk = 0;
        forever #52.08 clk = ~clk;  // Half period for 9600 Hz (approx)
    end

    // Simulation duration and waveform output
    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, tb_uart_tx);
        #20000;  // Simulate for 20 ms
        $finish;
    end

endmodule
