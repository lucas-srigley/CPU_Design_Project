`timescale 1ns/10ps
module datapath_tb();
	reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, 
	R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout;
	reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, 
	LOin, Zhighin, Zlowin, PCin, MDRin, InPortin, Cin;
	reg BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, 
	BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, BusMuxInHI, 
	BusMuxInLO, BusMuxInZhigh, BusMuxInZlow, BusMuxInPC, BusMuxInMDR, BusMuxInInPort, BusMuxInCsignextended;
	reg Clock, Clear, Read;
	reg [31:0] Mdatain;
	parameter Default = 4'b0000, Reg_loadR2 = 4'b0010, Reg_loadR3 = 4'b0011, Reg_loadR4 = 4'b0100, Reg_loadMDR = 4'b0001, Reg_loadR5 = 4'b0101;
	
	reg [3:0] Present_state = Default;
	DataPath DUT(Clock, Clear, Mdatain, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, 
	R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, 
		Zhighin, Zlowin, PCin, MDRin, InPortin, Cin, Read);
	
	initial 
		begin
			Clock = 0;
			forever #10 Clock = ~Clock;
	  end
	
	always @(posedge Clock)
		begin
		 case(Present_state)
			default 	: 	Present_state = Reg_loadMDR;
			Reg_loadMDR  : Present_state = Reg_loadR2;
			Reg_loadR2 	: 	Present_state = Reg_loadR3;
			Reg_loadR3 : Present_state = Reg_loadR4;
			Reg_loadR4 : Present_state = Reg_loadR5;
			endcase
		end
		
	always @(Present_state)
		begin
			case(Present_state)
				Default: begin 
								R0out<=0; R1out <=0; R2out <=0; R3out <=0; R4out <=0; R5out <=0; R6out <=0; R7out <=0; R8out <=0; R9out <=0; R10out <=0; R11out <=0; R12out <=0; R13out <=0; R14out <=0; R15out <=0; HIout <=0; LOout <=0; Zhighout <=0; Zlowout <=0; PCout <=0; MDRout <=0; InPortout <=0; Cout <=0;
								 R0in <=0;  R1in <=0;  R2in <=0;  R3in <=0;  R4in <=0;  R5in <=0;  R6in <=0;  R7in <=0;  R8in <=0;  R9in <=0;  R10in <=0;  R11in <=0;  R12in <=0;  R13in <=0;  R14in <=0;  R15in <=0;  HIin <=0;  LOin <=0;  Zhighin <=0;  Zlowin <=0;  PCin <=0;  MDRin <=0;  InPortin <=0;  Cin <=0;
								 Clear <= 0; Read <= 0;
								 Mdatain <= 32'h00000000;
								 BusMuxInR0 <=0; BusMuxInR1 <=0; BusMuxInR2 <=0; BusMuxInR3 <=0; BusMuxInR4 <=0; BusMuxInR5 <=0; BusMuxInR6 <=0; BusMuxInR7 <=0; BusMuxInR8 <=0; BusMuxInR9 <=0; BusMuxInR10 <=0; BusMuxInR11 <=0; BusMuxInR12 <=0; BusMuxInR13 <=0; BusMuxInR14 <=0; BusMuxInR15 <=0; BusMuxInHI <=0; BusMuxInLO <=0; BusMuxInZhigh <=0; BusMuxInZlow <=0; BusMuxInPC <=0; BusMuxInMDR <=0; BusMuxInInPort <=0; BusMuxInCsignextended <=0; 
							end
				Reg_loadMDR: begin
								 Read <= 1; Mdatain <= 32'h00000007; MDRin <=1;
								end
				Reg_loadR2:begin
								MDRin <= 0; Read <= 0;
								MDRout <= 1; R1in <= 1;
							end
			
				Reg_loadR3: begin
							MDRout <= 0; R1in <= 0;
							R1out <= 1; R2in <= 1;
						
							end
				Reg_loadR4: begin
							R1out <= 0; R2in <= 0;
						   R2out <= 1; R3in <= 1;
							end
				Reg_loadR5: begin
							R2out <=0; R3in <=0;
						end
						endcase
					end
				endmodule
								
				
								
	//Encoder