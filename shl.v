`timescale 1ns/1ns

module shl(C, A, B, clock, reset);
	output [31:0] C;
	input A, B;
	input clock, reset;
	
	reg [31:0] X;
	integer i;
	
	always @(posedge clock) begin
		if (reset == 1)
			X <= 32'h00000000;
		else if (A == 1) begin
			X[31] <= B;
			for (i = 30; i > 0; i=i-1) begin
				X[i] <= X[i-1];
			end
			X[0] <= 0; // Set the LSB to 0 for shift-left
		end
	end
	
	assign C = X;
	
endmodule
