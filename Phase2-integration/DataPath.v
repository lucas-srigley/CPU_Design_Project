module DataPath(
	output [31:0] Mdatain, BusMuxInMDR,
	input PCout, Zhighout, Zlowout, HIout, LOout, Cout,
	input MDRout, enableMDR, enableMAR, enableZ, enableY, enablePC, enableLO, 
	enableHI, clear, clock, InPort, IncPC, Read,
	input [4:0] opcode,
	input conIn, enableOutPort, enableRAM, enableIR,  
	input Gra, Grb, Grc, Rin, Rout, BAout, InPort_Out, enableInPort
);

	wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
           BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
           BusMuxInHI, BusMuxInLO, BusMuxInZHigh, BusMuxInZLow, BusMuxInPC, BusMuxIn_InPort, C_sign_extended,
           BusMuxOut;
			  
	wire [31:0] Yout, IRout, MARout;

	wire[4:0] encoderOut;
	wire [63:0] Zout;

	wire [15:0] Rins;
	wire [15:0] Routs;
	
	wire [31:0] qValue;
	assign BusMuxInR0 = {32{!BAout}} & qValue;
	register R0 (clear, clock, Rins[0], BusMuxOut, qValue);
	
	register R1 (clear, clock, Rins[1], BusMuxOut, BusMuxInR1);
	register R2 (clear, clock, Rins[2], BusMuxOut, BusMuxInR2);
	register R3 (clear, clock, Rins[3], BusMuxOut, BusMuxInR3);
	register R4 (clear, clock, Rins[4], BusMuxOut, BusMuxInR4);    
	register R5 (clear, clock, Rins[5], BusMuxOut, BusMuxInR5); 
	register R6 (clear, clock, Rins[6], BusMuxOut, BusMuxInR6);
	register R7 (clear, clock, Rins[7], BusMuxOut, BusMuxInR7);
	register R8 (clear, clock, Rins[8], BusMuxOut, BusMuxInR8);
	register R9 (clear, clock, Rins[9], BusMuxOut, BusMuxInR9);
	register R10 (clear, clock, Rins[10], BusMuxOut, BusMuxInR10);
	register R11 (clear, clock, Rins[11], BusMuxOut, BusMuxInR11);
	register R12 (clear, clock, Rins[12], BusMuxOut, BusMuxInR12);
	register R13 (clear, clock, Rins[13], BusMuxOut, BusMuxInR13);
	register R14 (clear, clock, Rins[14], BusMuxOut, BusMuxInR14);
	register R15 (clear, clock, Rins[15], BusMuxOut, BusMuxInR15);

	register HI(clear, clock, enableHI, BusMuxOut, BusMuxInHI);
	register LO(clear, clock, enableLO, BusMuxOut, BusMuxInLO);
	register RY(clear, clock, enableY, BusMuxOut, Yout);
	register IR(clear, clock, enableIR, BusMuxOut, IRout);
	register MAR(clear, clock, enableMAR, BusMuxOut, MARout);
	registerZ Z(clear, clock, enableZ, Zout, BusMuxInZLow, BusMuxInZHigh);

	wire conOut;

	ProgramCounter PC(clock, IncPC, conOut, enablePC, BusMuxOut, BusMuxInPC);
	
   CONFF conff(conOut, conIn, BusMuxOut, IRout[20:19]);
    
	wire [31:0] outPortOut;
	wire [31:0] inPortIn = 32'hFFFFFFFF;

	register inPort(clear, clock, enableInPort, inPortIn, BusMuxIn_InPort);
	register outPort(clear, clock, enableOutPort, BusMuxOut, outPortOut);
	
	// Test Cases
	
	//ld Case 1: ld R2, 0x95
	defparam PC.qInitial = 32'b0;
	
	//ld Case 2: ld R0, 0x38(R2) 
	//defparam PC.qInitial = 32'b1; 
	//defparam R2.qInitial = 32'h95; 
	
	//ldi Case 3: ldi R2, 0x95 
	//defparam PC.qInitial = 32'b10; 
	
	//ldi Case 4: ldi R0, 0x38(R2) 
	//defparam PC.qInitial = 32'b11; 
	//defparam R2.qInitial = 32'h95; 

	//st Case 1: st 0x87, R1
	//defparam PC.qInitial = 32'b100; 
	//defparam R1.qInitial = 32'h43;

	//st Case 2: st 0x87(R1), R1
	//defparam PC.qInitial = 32'b101;  
	//defparam R1.qInitial = 32'h43;

	// ALU Case 1: addi R3, R4, -5
	//defparam PC.qInitial = 32'b110;
	
	// ALU Case 2: ori R3, R4, 0x53
	//defparam PC.qInitial = 32'b111;
	//defparam R4.qInitial = 32'b100010100100010110;
	
	// ALU Case 3: andi R3, R4, 0x53
	//defparam PC.qInitial = 32'b1000;
	//defparam R4.qInitial = 32'b100010100100010110;
	
	// br Case 1: brzr R5, 14
	//defparam PC.qInitial = 32'b1001; 
	//defparam R5.qInitial = 32'h0;

	// br Case 2: brnz R5, 14
	//defparam PC.qInitial = 32'b1010; 
	//defparam R5.qInitial = 32'h1;
	
	// br Case 3: brpl R5, 14
	//defparam PC.qInitial = 32'b1011; 
	//defparam R5.qInitial = 32'h1;
	
	// br Case 4: brmi R5, 14
	//defparam PC.qInitial = 32'b1100; 
	//defparam R5.qInitial = 32'h80000000;
	
	//	Jump Case 1: jr R6
	//defparam PC.qInitial = 32'b1101; 
	//defparam R6.qInitial = 32'h1;
	
	//	Jump Case 2: jal R6
	//defparam PC.qInitial = 32'b1110; 
	//defparam R6.qInitial = 32'h1;
	
	// Special Case 1: mfhi R6
	//defparam PC.qInitial = 32'b1111;
	//defparam HI.qInitial = 32'hFFFFFFFF;
	
	// Special Case 2: mflo R7
	//defparam PC.qInitial = 32'b10000;
	//defparam LO.qInitial = 32'hFFFFFFFF;
	
	// Output Case 1 : out R3
	//defparam PC.qInitial = 32'b10001;
	//defparam R3.qInitial = 32'hFFFFFFFF;
	
	// Input Case 2: in R4
	//defparam PC.qInitial = 32'b10010;
	
	ram RAM(Mdatain, BusMuxInMDR, MARout[8:0], clock, enableRAM, Read);

	SelectEncodeLogic SEL(IRout, Gra, Grb, Grc, Rin, Rout, BAout, C_sign_extended, Rins, Routs);

	MDR mdr(clear, clock, enableMDR, Read, BusMuxOut, Mdatain, BusMuxInMDR);

	Encoder_32to5 encoder(encoderOut, {{8'b0}, Cout, InPort_Out, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, 
	Routs[15], Routs[14], Routs[13], Routs[12], Routs[11], Routs[10], Routs[9], Routs[8], Routs[7], Routs[6], Routs[5], Routs[4], 
	Routs[3], Routs[2], Routs[1], Routs[0]});

	Mux_32to1 mux(BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
           BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
           BusMuxInHI, BusMuxInLO, BusMuxInZHigh, BusMuxInZLow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, C_sign_extended,
           encoderOut,
			  BusMuxOut);

   ALU alu(clear, clock, opcode, Yout, BusMuxOut, Zout[31:0], Zout[63:32]);
              
endmodule