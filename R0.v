module R0 (
	input clear, clock, enable
	input [31:0]BusMuxOut,
	output wire [31:0]BusMuxIn
);

reg [31:0]q;
reg [31:0]BAout;
reg [31:0]BusMuxIn_R0;

always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {31{1'b0}};
			end
			else if (enable) begin
				q <= BusMuxOut;
			end
		end
	assign BusMuxIn = q[31:0];
	logical_AND(!BAout, q, BusMuxIn_R0);
	
endmodule
