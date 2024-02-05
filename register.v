module reg_files #(parameter VAL = 0)(

	input wire clr, 
	input wire clk, 
	input wire enable, 
	input wire [31:0] dIN, 
	output reg [31:0] qOut
	
); 

	always@(posedge clk or negedge clr)
		begin 
			if(clr == 0)
				qout <= 0; 
			else if (enable)
				qOut <= dIn;
			
		end
		inital qOut = VAL; 
endmodule 
	
