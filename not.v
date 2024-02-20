module NOT(input wire [31:0] A, B, input wire selection, output wire [31:0] C);

	assign C = (selection == 1)? 0 : 1;
	
endmodule