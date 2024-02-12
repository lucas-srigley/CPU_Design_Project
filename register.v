module register #(parameter VAL = 0)(
	input wire clr, 
	input wire clk, 
	input wire enable, 
	input wire [31:0] dIn, 
	output reg [31:0] qOut
	
); 

	always@(posedge clk or negedge clr)
		begin 
			if(clr == 0)
				qOut <= 0; 
			else if (enable)
				qOut <= dIn;
			
		end
		initial qOut = VAL; 
endmodule 
	
