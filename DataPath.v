 module DataPath(
	input wire clock, clear,  
	input wire [31:0] Mdatain,
	input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, 
	R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
	input wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, 
	LOin, Zhighin, Zlowin, PCin, MDRin, InPortin, Cin, Read
);

		
wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, 
	BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
	BusMuxInHI, BusMuxInLO, BusMuxInZhigh, BusMuxInZlow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, BusMuxInCsignextended,
	BusMuxOut;

register r0 (clear, clock, R0in, BusMuxOut, BusMuxInR0);
register r1 (clear, clock, R1in, BusMuxOut, BusMuxInR1);
register r2 (clear, clock, R2in, BusMuxOut, BusMuxInR2);
register r3 (clear, clock, R3in, BusMuxOut, BusMuxInR3);
register r4 (clear, clock, R4in, BusMuxOut, BusMuxInR4);	
register r5 (clear, clock, R5in, BusMuxOut, BusMuxInR5); 
register r6 (clear, clock, R6in, BusMuxOut, BusMuxInR6);
register r7 (clear, clock, R7in, BusMuxOut, BusMuxInR7);
register r8 (clear, clock, R8in, BusMuxOut, BusMuxInR8);
register r9 (clear, clock, R9in, BusMuxOut, BusMuxInR9);
register r10 (clear, clock, R10in, BusMuxOut, BusMuxInR10);
register r11 (clear, clock, R11in, BusMuxOut, BusMuxInR11);
register r12 (clear, clock, R12in, BusMuxOut, BusMuxInR12);
register r13 (clear, clock, R13in, BusMuxOut, BusMuxInR13);
register r14 (clear, clock, R14in, BusMuxOut, BusMuxInR14);
register r15 (clear, clock, R15in, BusMuxOut, BusMuxInR15);
register HI (clear, clock, HIin, BusMuxOut, BusMuxInHI);
register LO (clear, clock, LOin, BusMuxOut, BusMuxInLO);

MDR reg_MDR (clear, clock, MDRin, Read, BusMuxOut, Mdatain, BusMuxInMDR);

//Bus
Bus bus(BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, 
	BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
	BusMuxInHI, BusMuxInLO, BusMuxInZhigh, BusMuxInZlow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, BusMuxInCsignextended,
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, 
	R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
	BusMuxOut);
		
// adder
//ripple_carry_adder add(A, BusMuxOut, Zregin);


	 
endmodule
