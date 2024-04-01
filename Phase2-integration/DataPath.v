module DataPath(
input clock, stop, clear, 
	input wire [31:0] in_port_data_in,
	output wire [31:0] out_port_data_out, BusMuxOut
);
	
	wire [31:0] Mdatain, MDR_data_out;
	wire Gra, Grb, Grc, BAout, Read, Run, IncPC;

	wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
           BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, BusMuxInMDR,
           BusMuxInHI, BusMuxInLO, BusMuxInZHigh, BusMuxInZLow, BusMuxInPC, BusMuxIn_InPort, C_sign_extended;
			  
	wire enableMDR, enableHI, enableLO, enableY, enableIR, enableMAR, enableZ, conIn, enablePC, enableInPort, enableOutPort,
	enableRAM, Rin, Rout, Cout, InPort_Out, MDRout, PCout, Zlowout, Zhighout, LOout, HIout;
			  
	wire [31:0] Yout, IR_data_out, MARout;

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
	register IR(clear, clock, enableIR, BusMuxOut, IR_data_out);
	register MAR(clear, clock, enableMAR, BusMuxOut, MARout);
	registerZ Z(clear, clock, enableZ, Zout, BusMuxInZLow, BusMuxInZHigh);

	wire conOut;

	ProgramCounter PC(clock, IncPC, conOut, enablePC, BusMuxOut, BusMuxInPC);
	
	defparam PC.qInitial = 32'b0;
	
   CONFF conff(conOut, conIn, BusMuxOut, IR_data_out[20:19]);
    
	wire [31:0] outPortOut;
	wire [31:0] inPortIn;

	register inPort(clear, clock, enableInPort, in_port_data_in, BusMuxIn_InPort);
	register outPort(clear, clock, enableOutPort, BusMuxOut, out_port_data_out);
	
	ram RAM(Mdatain, BusMuxInMDR, MARout[8:0], clock, enableRAM, Read);

	SelectEncodeLogic SEL(IR_data_out, Gra, Grb, Grc, Rin, Rout, BAout, C_sign_extended, Rins, Routs);

	MDR mdr(clear, clock, enableMDR, Read, BusMuxOut, Mdatain, BusMuxInMDR);

	Encoder_32to5 encoder(encoderOut, {{8'b0}, Cout, InPort_Out, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, 
	Routs[15], Routs[14], Routs[13], Routs[12], Routs[11], Routs[10], Routs[9], Routs[8], Routs[7], Routs[6], Routs[5], Routs[4], 
	Routs[3], Routs[2], Routs[1], Routs[0]});

	Mux_32to1 mux(BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
           BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, 
           BusMuxInHI, BusMuxInLO, BusMuxInZHigh, BusMuxInZLow, BusMuxInPC, BusMuxInMDR, BusMuxIn_InPort, C_sign_extended,
           encoderOut,
			  BusMuxOut);
	
	wire [4:0] opcode;

   ALU alu(clear, clock, opcode, Yout, BusMuxOut, Zout[31:0], Zout[63:32]);
	
	ControlUnit CU(PCout,Zhighout, MDRout,enableMAR,enablePC,enableMDR,enableIR,enableY,IncPC,Read,
	enableHI,enableLO,HIout,LOout,enableZ,Cout,enableRAM,Gra,Grb,Grc,Rin,Rout,BAout,
	conIn,enableInPort,enableOutPort,InPort_Out,Run, Zlowout, IR_data_out,clock,clear,stop);
              
endmodule