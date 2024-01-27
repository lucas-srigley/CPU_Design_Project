module ALU_not(input wire [31:0] A, input wire selection, output wire [31:0] result);

	assign result = !A;
	
endmodule