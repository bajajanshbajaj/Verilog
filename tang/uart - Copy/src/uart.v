  module uart_tx(
   input       clk, // clock input
   input       reset_n, // synchronous reset input, low active 
   input [7:0] tx_data, // data to send
   input       tx_send, // trigger for sending data
   output      tx_ready, // tx module ready
   output      tx_out    // serial data output
   );

  localparam CLK_FRQ   = 27000000; //clock frequency(Mhz)
  localparam BAUD_RATE = 115200 ; //serial baud rate
  localparam   CYCLE  = CLK_FRQ / BAUD_RATE;
  localparam   S_IDLE = 2'd0; // wait for tx_send asserted
  localparam   S_SEND = 2'd1; // send start, data, stop bits
  localparam   S_WAIT = 2'd2; // wait for tx_send deasserted

  reg [1:0]    state;
  reg [15:0]   cycle_cnt;  // baud counter
  reg [3:0]    bit_cnt;
  reg [9:0]    send_buf;
  // reg [7:0] tx_data = 8'd55;z
  

  assign tx_out   = (state == S_SEND) ? send_buf[0] : 1'b1;
  assign tx_ready = (state == S_IDLE);
  
  always@(posedge clk or negedge reset_n)
    if(reset_n == 1'b0)
      state <= S_IDLE;
    else
      case(state)
	S_IDLE:
	  if(tx_send == 1'b1) begin
	     send_buf <= {1'b1, tx_data[7:0], 1'b0}; // stop + data + start
	     cycle_cnt <= 16'd0;
	     bit_cnt <= 4'd0;
	     state <= S_SEND;
	  end
	S_SEND:
	  if(cycle_cnt == CYCLE - 1) begin
	     if(bit_cnt == 4'd9)
	       state <= S_WAIT;
	     else begin
		send_buf[9:0] <= {1'b1, send_buf[9:1]};
		bit_cnt <= bit_cnt + 3'd1;
	     end
	     cycle_cnt <= 16'd0;
	  end
	  else 
	    cycle_cnt <= cycle_cnt + 16'd1;	
	S_WAIT:
	  if( tx_send == 1'b0 ) // wait for tx_send deasserted
	    state <= S_IDLE;
	default:;
      endcase
endmodule 