`timescale 1ns/10ps

module ld_tb;
	reg clock, clear;
	reg IncPC, CON_enable; 
	reg [31:0] Mdatain;
	wire [31:0] bus_contents;
	reg RAM_write, MDR_enable, MDRout, MAR_enable, IR_enable;
	reg MDR_read;
	reg R_enable, Rout;
	reg [15:0] R0_R15_enable, R0_R15_out;
	reg Gra, Grb, Grc;
	reg HI_enable, LO_enable, ZHighIn, ZLowIn, Y_enable, PC_enable, InPort_enable, OutPort_enable;
	reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
	wire [4:0] opcode;
	wire[31:0] OutPort_output;
	reg [31:0] InPort_input;
			
	parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;

	DataPath DUT(PCout, ZHighout, ZLowout, MDRout, MARin, MDRin, PCin, IRin, Yin, IncPC, Read, clock, 
	MDatain, clear, HIin, LOin, HIout, LOout, ZHighIn, ZLowIn, Cout, RAM_write_en, GRA, GRB, GRC, 
	R_in, R_out, Baout, enableCon, R_enableIn, Rout_in, enableInputPort, enableOutputPort, InPortout, 
	InPort_input, OutPort_output, bus_contents, operation);


initial
	begin
		clock = 0;
		clear = 0;
end

always
		#10 clock <= ~clock;

always @(posedge clock) 
	begin
		case (Present_state)
			Default			:	#40 Present_state = T0;
			T0					:	#40 Present_state = T1;
			T1					:	#40 Present_state = T2;
			T2					:	#20 Present_state = T3;
			T3					:	#40 Present_state = T4;
			T4					:	#40 Present_state = T5;
			T5					:	#40 Present_state = T6;
			T6					:	#40 Present_state = T7;
		endcase
end

always @(Present_state) 
	begin
	#10 
		case (Present_state) //assert the required signals in each clockcycle
			Default: begin // initialize the signals
				PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MAR_enable <= 0; ZHighIn <= 0; ZLowIn <= 0; CON_enable<=0; 
				InPort_enable<=0; OutPort_enable<=0;
				InPort_input<=32'd0;
				PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; 
				Y_enable <= 0;
				IncPC <= 0; RAM_write<=0;
				Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0;
				BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HI_enable<=0; LO_enable<=0;
				Rout<=0;R_enable<=0;MDR_read<=0;
				R0_R15_enable<= 16'd0; R0_R15_out<=16'd0;
			end	
						
			//first test:  (ld r1, 7) where r1 is initially 8. Address 7 has value 15. Instruction is = 00800007
			//second test: ld r1, 2(r2), where r2 is 2 and address 4 has 15. Instruction is 00900002.

T0: begin 
	PCout <= 1; MAR_enable <= 1; 
end

T1: begin //Loads MDR from RAM output
		PCout <= 0; MAR_enable <= 0;  
		MDR_enable <= 1; MDR_read<=1; ZLowout <= 1; 
end

T2: begin
	MDR_enable <= 0; MDR_read<=0;ZLowout <= 0; 
	MDRout <= 1; IR_enable <= 1; PC_enable <= 1; IncPC <= 1;			
end

T3: begin
	MDRout <= 0; IR_enable <= 0;			
	Grb<=1;BAout<=1;Y_enable<=1;
end

T4: begin
	Grb<=0;BAout<=0;Y_enable<=0;
	Cout<=1;ZHighIn <= 1;  ZLowIn <= 1;
end

T5: begin
	Cout<=0; ZHighIn <= 0;  ZLowIn <= 0;
	ZLowout <= 1;MAR_enable<=1;
end

T6: begin
	ZLowout <= 0; MAR_enable <= 0;
	MDR_read <= 1; MDR_enable <= 1;
end
T7: begin
	MDR_read <= 0; MDR_enable <= 0;
	MDRout <= 1; Gra <= 1; R_enable <= 1;
end

endcase

end

endmodule