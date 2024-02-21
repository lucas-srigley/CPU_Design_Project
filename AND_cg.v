module AND_cg(
	input wire [31:0] B, C, 
	output wire [31:0] A

);


	assign A <= B & C; 	
	
endmodule 