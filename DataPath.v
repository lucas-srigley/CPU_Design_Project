 module DataPath(
	input wire clock, clear,
	input wire [31:0] RegisterAImmediate,
	input wire RZout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, 
					R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, MDRout,
					
	input wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, 
					R10in, R11in, R12in, R13in, R14in, R15in, 
					IRin, HIin, LOin, MARin, MDRin, RZin
);

		
wire [31:0] BusMuxInrZ,  
				BusMuxInr0, BusMuxInr1, BusMuxInr2, BusMuxInr3, BusMuxInr4, BusMuxInr5, BusMuxInr6, BusMuxInr7, 
				BusMuxInr8, BusMuxInr9, BusMuxInr10, BusMuxInr11, BusMuxInr12, BusMuxInr13, BusMuxInr14, BusMuxInr15,
				BusMuxInLO, BusMuxInHI, BusMuxInMAR;

wire [31: 0] BusMuxOut;

wire [31:0] Zregin;

wire [63:0] Z;

wire [31:0] Y;

reg [31:0] Read;

reg [31:0] Mdatain;


//Bus
Bus bus(BusMuxInrZ,  
			BusMuxInr0, BusMuxInr1, BusMuxInr2, BusMuxInr3, BusMuxInr4, BusMuxInr5, BusMuxInr6, BusMuxInr7, 
			BusMuxInr8, BusMuxInr9, BusMuxInr10, BusMuxInr11, BusMuxInr12, BusMuxInr13, BusMuxInr14, BusMuxInr15,
		BusMuxInLO, BusMuxInHI, BusMuxInMDR,
			RZout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, 
			R10out, R11out, R12out, R13out, R14out, R15out, 
			HIout, LOout, MDRout,
			BusMuxOut);
		
// adder
ripple_carry_adder add(A, BusMuxOut, Zregin);


register RZ (clear, clock, RZin, Zregin, BusMuxInrZ);


//general use registers
register r0 (clear, clock, R0in, BusMuxOut, BusMuxInr0);
register r1 (clear, clock, R1in, BusMuxOut, BusMuxInr1);
register r2 (clear, clock, R2in, BusMuxOut, BusMuxInr2);
register r3 (clear, clock, R3in, BusMuxOut, BusMuxInr3);
register r4 (clear, clock, R4in, BusMuxOut, BusMuxInr4);	
register r5 (clear, clock, R5in, BusMuxOut, BusMuxInr5); 
register r6 (clear, clock, R6in, BusMuxOut, BusMuxInr6);
register r7 (clear, clock, R7in, BusMuxOut, BusMuxInr7);
register r8 (clear, clock, R8in, BusMuxOut, BusMuxInr8);
register r9 (clear, clock, R9in, BusMuxOut, BusMuxInr9);
register r10 (clear, clock, R10in, BusMuxOut, BusMuxInr10);
register r11 (clear, clock, R11in, BusMuxOut, BusMuxInr11);
register r12 (clear, clock, R12in, BusMuxOut, BusMuxInr12);
register r13 (clear, clock, R13in, BusMuxOut, BusMuxInr13);
register r14 (clear, clock, R14in, BusMuxOut, BusMuxInr14);
register r15 (clear, clock, R15in, BusMuxOut, BusMuxInr15);
	 
//special use general registers
register IR_r16 (clear, clock, IRin, BusMuxOut, BusMuxInIR);
register HI_r17 (clear, clock, HIin, BusMuxOut, BusMuxInHI);
register LO_r18 (clear, clock, LOin, BusMuxOut, BusMuxInLO);
register MAR_r19 (clear, clock, MARin, BusMuxOut, BusMuxInMAR);

//MDR register	 
MDR MDR_r20 (clear, clock, MDRin, Read, BusMuxOut, Mdatain, BusMuxInMDR);

	 
endmodule
