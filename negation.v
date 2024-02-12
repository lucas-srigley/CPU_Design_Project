module negate(
    input wire [31:0] in,   
    output wire [31:0] out  
);


//invert all bits and add 1
assign out = ~in + 1;

endmodule
