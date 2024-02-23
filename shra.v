`timescale 1ns/1ns

module shra(output[31:0] reg C, input A, B, clock, reset);
	
	reg [31:0] X;
	integer i;
	
	always@(poseedge clock) begin
		if (reset == 1)
			X <= 32'h00000000;
		else if (A == 1) begin
			for (i = 0; i <= 30; i=i+1) begin
				X[i] <= X[i+1]
			end
			X[31] <= X[30];
		end
	end
	assign C = X;
endmodule 