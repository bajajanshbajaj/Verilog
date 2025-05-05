module top_module (
    input d, 
    input ena,
    output q);
    
    reg latch ;
    assign q = latch;
    
    always @(*)begin
        
        latch <= ena?d:latch;
    end
    
    

endmodule
