`timescale 1ns/10ps
module ALU_tb;

	reg[31:0] input_a, input_b;
	reg[7:0] opcode;
	
	wire[31:0] ALU_result;
	
	ALU ALU_instance(input_a, input_b, opcode, ALU_result);
	
	initial
		begin
			input_a <= 10;
			input_b <= 5;
			opcode <= 5;
			#200;
		end
	
endmodule
