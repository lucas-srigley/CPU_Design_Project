module division(input signed [31:0] A, B, output reg [31:0] Zlow, Zhigh);
	reg [31:0] upper, lower;
	always @ (*)
	begin
		upper = A % B;
		lower = (A - upper) / B;
		begin
			Zhigh = upper;
			Zlow = lower;
		end
	end
				
endmodule