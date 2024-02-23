`timescale 1ns/1ns

module rol(output [31:0] reg C, input A, B, clock, reset);
	
	reg [31:0] X;
	integer i;
	reg [31:0] temp;
	
	always @(posedge clock) begin
		if (reset == 1)
			X <= 32'h00000000;
		else if (A == 1) begin
			temp <= X[31];
			for (i = 30; i > 0; i=i-1) begin
				X[i] <= X[i-1];
			end
			X[0] <= temp; 
		end
	end
	
	assign C = X;
	
endmodule 