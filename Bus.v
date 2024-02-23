module Bus (
	//Mux
	input wire[31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, 
	BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
	BusMuxInHI, BusMuxInLO, BusMuxInY, BusMuxInZhigh, BusMuxInZlow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, BusMuxInCsignextended,
	//Encoder
	input PCout, Zhighout, Zlowout, MDRout, R2out, R3out,
	
	output wire [31:0]BusMuxOut
);

reg [31:0]q;

always @ (*) begin
	if(PCout) q = BusMuxInPC;
	if(Zhighout) q = BusMuxInZhigh;
	if(Zlowout) q = BusMuxInZlow;
	if(MDRout) q = BusMuxInMDR;
	if(R2out) q = BusMuxInR2;
	if(R3out) q = BusMuxInR3;

end
assign BusMuxOut = q;
endmodule
