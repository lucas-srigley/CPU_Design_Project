module ProgramCounter (
	output reg[31:0] newPC,
	input clock, enable, IncPC,
	input [31:0] inputPC
	);
	
always @ (posedge clock)
	begin
		if(IncPC == 1 && enable ==1)
			newPC <= newPC + 1;
		else if (enable == 1)
			newPC <= inputPC;
	end
				
endmodule