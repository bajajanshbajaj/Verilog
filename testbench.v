`timescale 1ns / 1ps

module testbench;
    // Declare inputs as reg type (to drive values)
    reg a, b;
    
    // Declare outputs as wire type (to monitor values)
    wire y;

    // Instantiate the device under test (DUT)
    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    // Initial block to apply stimulus to the DUT
    initial begin
        // Create the VCD file for GTKWave
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);  // Dump all variables in testbench module

        // Apply test vectors to the inputs
        a = 0; b = 0; #10;  // 0 & 0
        a = 0; b = 1; #10;  // 0 & 1
        a = 1; b = 0; #10;  // 1 & 0
        a = 1; b = 1; #10;  // 1 & 1

        // Finish simulation
        $finish;
    end
endmodule
