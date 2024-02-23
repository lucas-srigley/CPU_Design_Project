module logical_AND(input wire [31:0] Ra, Rb, output wire [31:0] Rz);
	genvar i;
	generate
		for (i=0; i<32;i=i+1) begin : loop
			assign Rz[i] = ((Ra[i]) & (Rb[i]));
		end
	endgenerate
endmodule
