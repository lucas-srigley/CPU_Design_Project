module Bus (
	//Mux
	input [31:0] BusMuxInrZ,  
				BusMuxInr0, BusMuxInr1, BusMuxInr2, BusMuxInr3, BusMuxInr4, BusMuxInr5, BusMuxInr6, BusMuxInr7, 
				BusMuxInr8, BusMuxInr9, BusMuxInr10, BusMuxInr11, BusMuxInr12, BusMuxInr13, BusMuxInr14, BusMuxInr15,
				BusMuxInLO, BusMuxInHI, BusMuxInMAR, BusMuxInMDR,
	//Encoder
	input RZout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, 
			R10out, R11out, R12out, R13out, R14out, R15out, 
			HIout, LOout, MDRout,
	
	output wire [31:0]BusMuxOut
);

reg [31:0]q;

always @ (*) begin
	if(RZout) q = BusMuxInrZ;
	if(R0out) q = BusMuxInr0;
	if(R1out) q = BusMuxInr1;
	if(R2out) q = BusMuxInr2;
	if(R3out) q = BusMuxInr3;
	if(R4out) q = BusMuxInr4;
	if(R5out) q = BusMuxInr5;
	if(R6out) q = BusMuxInr6;
	if(R7out) q = BusMuxInr7;
	if(R8out) q = BusMuxInr8;
	if(R9out) q = BusMuxInr9;
	if(R10out) q = BusMuxInr10;
	if(R11out) q = BusMuxInr11;
	if(R12out) q = BusMuxInr12;
	if(R13out) q = BusMuxInr13;
	if(R14out) q = BusMuxInr14;
	if(R15out) q = BusMuxInr15;
	if(HIout) q = BusMuxInHI;
	if(LOout) q = BusMuxInLO;
	if(MDRout) q = BusMuxInMDR;

end
assign BusMuxOut = q;
endmodule
