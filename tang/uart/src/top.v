module uart_tx_top (
    input clk, 
    input reset_n, // if this gets low then signal is sent 
    output tx_out  ,        
    output reg led             
);
    wire tx_ready;
    reg tx_send;
    reg [7:0] tx_data;

    // ASCII for "hello\n"
    reg [7:0] message [0:5];
    initial begin
        message[0] = "h";
        message[1] = "e";
        message[2] = "l";
        message[3] = "l";
        message[4] = "o";
        message[5] = "\n"; // newline for readability
    end

    reg [2:0] msg_index;
    reg [23:0] delay_cnt;

    uart_tx uart (
        .clk(clk),
        .reset_n(reset_n),
        .tx_data(tx_data),
        .tx_send(tx_send),
        .tx_ready(tx_ready),
        .tx_out(tx_out)
    );

    // simple state machine to send characters one by one
    always @(posedge clk or negedge reset_n) begin


        if (!reset_n) begin 
            led <= 1;
            tx_data <= 8'd0;
            tx_send <= 1'b0;
            msg_index <= 3'd0;
            delay_cnt <= 0;                             // button press => reset n is low, when button not pressed, reset_n = 1, tf tf 

        end else begin

            if (tx_ready) begin
                led <= 0;
                if (msg_index < 6) begin
                    if (delay_cnt == 24'd10) begin
                        tx_data <= message[msg_index];
                        tx_send <= 1'b1;
                        msg_index <= msg_index + 1'b1;
                        delay_cnt <= 0;
                    end else begin
                        delay_cnt <= delay_cnt + 1'b1;
                        tx_send <= 1'b0;
                    end
                end else begin
                    tx_send <= 1'b0;
                end
            end else begin
                tx_send <= 1'b0;
            end
        end
    end

endmodule
