module negate(
    output reg [31:0] A,
	 input wire [31:0] B 
);


//invert all bits and add 1
assign A = ~B + 1;

endmodule
