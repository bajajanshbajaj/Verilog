module ripple( 
    input [4:0] a, b,
    input cin,
    output reg [4:0] cout,
    output reg [4:0] sum );
    integer i ; 
    reg carry ;
    always @(*) begin
        carry = cin;
        for (i=0; i<5; i=i+1)begin
            sum[i] = a[i]^b[i]^carry;
            cout[i] = a[i]&b[i]|b[i]&carry|a[i]&carry;
            carry = cout[i];
        end
    end
endmodule
