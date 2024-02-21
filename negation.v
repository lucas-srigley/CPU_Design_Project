module negate(
    input wire [31:0] B,   
    output wire [31:0] A  
);


//invert all bits and add 1
assign A = ~B + 1;

endmodule
