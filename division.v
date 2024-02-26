module division(input signed [31:0] A, B, output reg [31:0] Zlowout, Zhighout);
	reg [31:0] upper, lower;
	always @ (*)
	begin
		upper = A % B;
		lower = (A - upper) / B;
		begin
			Zlowout = lower;
			Zhighout = upper;
			//result = {upper, lower};
		end
	end
				
endmodule