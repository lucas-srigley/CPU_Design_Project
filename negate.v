module negate(input wire [31:0] A, output wire [31:0] result);


//invert all bits and add 1
assign result = ~A + 1;

endmodule 