module registerZ (
	input clear, clock, enable,
	input [63:0] Zin,
	output reg [31:0] Zlowout, 
	output reg [31:0] Zhighout
);
		  
	wire [63:0] tempZout;
	
	register64 Z(clear, clock, enable, Zin, tempZout);

	always@(*)
	begin
		Zhighout = tempZout[63:32];
		Zlowout = tempZout[31:0];
	end
	
endmodule