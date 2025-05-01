module andtest;

    // Declare inputs as registers and output as wire
    reg input_a, input_b;  // More descriptive names for inputs
    wire output_y;         // More descriptive name for output

    // Instantiate the AND gate
    and_gate uut (
        .a(input_a),
        .b(input_b),
        .y(output_y)
    );

    // Test stimulus
    initial begin
        $dumpfile("andtest.vcd");     // Name of the VCD file to generate
        $dumpvars(0, andtest);        // Dump all variables in the module 'andtest'
        // Monitor the inputs and output with meaningful labels
        $monitor("input_a = %b, input_b = %b, output_y = %b", input_a, input_b, output_y);

        // Test different combinations of inputs
        input_a = 0; input_b = 0;
        #10;  // Wait 10 time units
        input_a = 0; input_b = 1;
        #10;
        input_a = 1; input_b = 0;
        #10;
        input_a = 1; input_b = 1;
        #10;
    end

endmodule
