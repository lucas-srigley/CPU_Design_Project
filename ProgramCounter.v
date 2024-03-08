module ProgramCounter #(parameter qInitial) (input clock, input IncPC, input conOut, input enablePC, input [31:0] PCin, output reg [31:0] PCout);

initial
begin
	PCout = qInitial;
end

always@(posedge clock)
	begin
		if(IncPC == 1 && enablePC == 1)
			PCout = PCout + 1;
			
		else if (enablePC == 1 && conOut == 1)
			PCout <= PCin;
    end

endmodule