module Mux_32to1 (
	input wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
	BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
	BusMuxInHI, BusMuxInLO, BusMuxInZHigh, BusMuxInZLow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, C_sign_extended,
	input wire [4:0] encOut,
	output reg [31:0] BusMuxOut
);

always@(*)
	begin
		case(encOut)
			5'd0: BusMuxOut <= BusMuxInR0[31:0];
			5'd1: BusMuxOut <= BusMuxInR1[31:0];
			5'd2: BusMuxOut <= BusMuxInR2[31:0];
			5'd3: BusMuxOut <= BusMuxInR3[31:0];
			5'd4: BusMuxOut <= BusMuxInR4[31:0];
			5'd5: BusMuxOut <= BusMuxInR5[31:0];
			5'd6: BusMuxOut <= BusMuxInR6[31:0];
			5'd7: BusMuxOut <= BusMuxInR7[31:0];
			5'd8: BusMuxOut <= BusMuxInR8[31:0];
			5'd9: BusMuxOut <= BusMuxInR9[31:0];
			5'd10: BusMuxOut <= BusMuxInR10[31:0];
			5'd11: BusMuxOut <= BusMuxInR11[31:0];
			5'd12: BusMuxOut <= BusMuxInR12[31:0];
			5'd13: BusMuxOut <= BusMuxInR13[31:0];
			5'd14: BusMuxOut <= BusMuxInR14[31:0];
			5'd15: BusMuxOut <= BusMuxInR15[31:0];
			5'd16: BusMuxOut <= BusMuxInHI[31:0];
			5'd17: BusMuxOut <= BusMuxInLO[31:0];
			5'd18: BusMuxOut <= BusMuxInZHigh[31:0];
			5'd19: BusMuxOut <= BusMuxInZLow[31:0];
			5'd20: BusMuxOut <= BusMuxInPC[31:0];
			5'd21: BusMuxOut <= BusMuxInMDR[31:0];
			5'd22: BusMuxOut <= BusMuxIn_InPort[31:0];
			5'd23: BusMuxOut <= C_sign_extended[31:0];
			default: BusMuxOut <= 32'd0;
		endcase
	end
endmodule