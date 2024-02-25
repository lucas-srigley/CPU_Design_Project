module MDR(
	output wire [31:0] BusMuxIn,
	input clear, clock, enable, read,
	input [31:0] BusMuxOut,
	input [31:0] Mdatain
); 
	
reg [31:0]qOut;
always @ (posedge clock)
		begin 
			if (clear) begin
				qOut <= {31{1'b0}};
			end
			else if (enable) begin
				qOut <= read ? Mdatain : BusMuxOut;
			end
		end
	assign BusMuxIn = q[31:0];
endmodule
