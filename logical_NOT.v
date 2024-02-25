module logical_NOT(output wire [31:0] result, input wire [31:0] A);

	assign result = ~A;
	
endmodule