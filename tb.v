`timescale 1ns/1ps

module tb_top_module;

    reg clk = 0;
    reg in = 1;
    reg reset = 1;
    wire [7:0] out_byte;
    wire done;

    // Instantiate your design
    top_module uut (
        .clk(clk),
        .in(in),
        .reset(reset),
        .out_byte(out_byte),
        .done(done)
    );

    // Clock generator
    always #5 clk = ~clk; // 100MHz clock

    // Task to send one bit per clock
    task send_bit(input bit);
        begin
            @(negedge clk);
            in = bit;
        end
    endtask

    // Task to send a full frame
    task send_frame(input [7:0] data);
        integer i;
        reg parity;
        begin
            parity = 0;
            send_bit(0); // Start bit
            for (i = 0; i < 8; i = i + 1) begin
                send_bit(data[i]);
                if (data[i]) parity = ~parity;
            end
            send_bit(1); // Odd parity bit
            send_bit(1); // Stop bit
        end
    endtask

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_top_module);

        #10 reset = 0;

        // Frame 1: all zeros → 00000000 + parity 1
        send_frame(8'b00000000);

        #100;

        // Frame 2: 10000000 → 1 one, parity 0
        send_frame(8'b10000000);

        #100;

        // Frame 3: Invalid parity
        send_bit(0); // Start
        send_bit(1); // Bit 0
        send_bit(0); send_bit(0); send_bit(0);
        send_bit(0); send_bit(0); send_bit(0); send_bit(0);
        send_bit(1); // Wrong parity
        send_bit(1); // Stop

        #100 $finish;
    end

endmodule
