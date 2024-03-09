`timescale 1ns/10ps
module ldi_tb;
	reg PCout, Zlowout, Zhighout, HIout, LOout, Cout, in_port_out; 
	wire [31:0] BusMuxInMDR;
	reg MDRout;
	reg enableMAR, enableZ, enablePC, enableMDR, enableIR, enableY, enableLO, enableHI, InPort;
	reg IncPC, Read;
	reg [4:0] opcode;
	reg Clock, clear;
	wire [31:0] Mdatain;

	reg conIn, inPortIn, BAout, Gra, Grb, Grc, enableOutPort, Rin, Rout, enableInPort;
	reg enableRAM;

	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
	Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
	T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6= 4'b1101, T7= 4'b1110;
	reg [3:0] Present_state = Default;

	DataPath DUT(
		 Mdatain, BusMuxInMDR,
		 PCout, Zhighout, Zlowout, HIout, LOout, Cout,
		 MDRout, enableMDR, enableMAR, enableZ, enableY, enablePC, enableLO, 
		 enableHI, clear, Clock, InPort, IncPC, Read,
		 opcode,
		 conIn, enableOutPort, enableRAM, enableIR,
		 Gra, Grb, Grc, Rin, Rout, BAout, in_port_out, enableInPort
	);
		
	initial
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
	end

	always @(posedge Clock)
	begin
		case (Present_state)
			Default : Present_state = T0;
			T0 : #40 Present_state = T1;
			T1 : #40 Present_state = T2;
			T2 : #40 Present_state = T3;
			T3 : #40 Present_state = T4;
			T4 : #40 Present_state = T5;
		endcase
	end

	always @(Present_state)
   begin
		case (Present_state)
				Default: begin
				PCout <= 0; Zlowout <= 0; MDRout <= 0; clear<=0;
				enableMAR <= 0; enableZ <= 0;
				enablePC <=0; enableMDR <= 0; enableIR= 0; enableY= 0;
				IncPC <= 0; Read <= 0; opcode <= 0;
				Zhighout <= 0; HIout <= 0; LOout <= 0; Cout <= 0; in_port_out <= 0;
				Gra <= 0; Grb<= 0; Grc<=0; BAout <=0; enableRAM <=0; enableOutPort <=0; inPortIn <=0; conIn<=0; Rout <= 0; Rin <=0;
				end
				
				T0: begin
				   PCout <= 1; enableMAR <= 1; 
			   end
				
				T1: begin
					PCout <= 0; enableMAR <= 0; 
					Read <= 1;
					enableMDR <= 1; 
				end
				
				T2: begin
					enableMDR <= 0; 
					MDRout <= 1; enableIR <= 1;
				end
				
				T3: begin
					MDRout <= 0; enableIR <= 0;
					Grb <= 1; BAout <= 1; enableY <= 1; 
				end
				
				T4: begin
					Grb <= 0; BAout <= 0; enableY <= 0;
					Cout<= 1; enableZ <= 1; opcode <= 5'b00001; 
				end
				
				T5: begin
					Cout<= 0; enableZ <= 0; 
					Zlowout <= 1; Gra<= 1; Rin <=1; 
				end

		endcase
	end
endmodule
