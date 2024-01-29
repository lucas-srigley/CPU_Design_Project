 module DataPath(
	input wire clock, clear,
	input wire [31:0] A, 
	input wire [31:0] RegisterAImmediate,
	input wire RZout, RAout, RBout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, MDRout,
	input wire RAin, RBin, RZin
	
);

wire [31:0] BusMuxOut, BusMuxInRZ, BusMuxInRA, BusMuxInRB, BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, BusMuxInLO, BusMuxInHI, BusMuxInMDR;

wire [31:0] Zregin;

wire [63:0] Z;

wire [31:0] Y;

//Devices
register RA(clear, clock, RAin, RegisterAImmediate, BusMuxInRA);
register RB(clear, clock, RBin, BusMuxOut, BusMuxInRB);

wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, IR, HI, LO, MAR, MDR;

wire enable16, enable17, enable18, enable19;

// adder
ripple_carry_adder add(A, BusMuxOut, Zregin);
register RZ(clear, clock, RZin, Zregin, BusMuxInRZ);

//Bus
Bus bus(BusMuxInRZ, BusMuxInRA, BusMuxInRB, BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, BusMuxInLO, BusMuxInHI, BusMuxInMDR,RZout, RAout, RBout, BusMuxOut, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, MDRout);

register #(32, 32, 32'h0) IR_r16 (
        clear,
        clock,
        enable16,
        BusMuxOut,
        IR
    );

    register #(32, 32, 32'h0) HI_r17 (
        clear,
        clock,
        enable17,
        BusMuxOut,
        HI
    );
	 
    register #(32, 32, 32'h0) LO_r18 (
        clear,
        clock,
        enable18,
        BusMuxOut,
        LO
    );
	 
    register #(32, 32, 32'h0) MAR_r19 (
        clear,
        clock,
        enable19,
        BusMuxOut,
        MAR
    );
	 
    register #(32, 32, 32'h0) MDR_r20 (
        clear,
        clock,
        MDRin,
        BusMuxOut,
        MDR
    );
	 
reg_files reg_init(clear, clock, RZin, BusMuxOut, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, IR, HI, LO, MAR);

endmodule
