module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
);
    reg [2:0] state;
    reg [2:0] counter;
    reg odd;
    reg paritycheck;
    localparam idle = 0, started = 1, stopcondition = 2, errorwait = 3, paritybit = 4;

    always @(posedge clk) begin
        if (reset) begin
            state <= idle;
            counter <= 3'b000;
            done <= 1'b0;
            odd <= 0;
            paritycheck <= 0;
        end else begin
            case (state)
                idle: begin
                    done <= 1'b0;
                    counter <= 3'b000;
                    odd <= 0;
                    paritycheck <= 0;

                    if (in == 1'b0)
                        state <= started;
                end

                started: begin
                    out_byte <= {in, out_byte[7:1]};
                    if (counter == 3'b111)
                        state <= paritybit;
                    else
                        counter <= counter + 1'b1;

                    if (in)
                        odd <= ~odd;
                end

                paritybit: begin
                    state <= stopcondition;
                    paritycheck <= odd ^ in;
                end

                stopcondition: begin
                    if ((in == 1'b1) && paritycheck == 1'b1) begin
                        done <= 1'b1;
                        state <= idle;
                    end else
                        state <= errorwait;
                end

                errorwait: begin
                    if (in == 1'b1)
                        state <= idle;
                end
            endcase
        end
    end
endmodule
