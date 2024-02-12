module MDR #(parameter VAL = 0)(
	input wire clr, 
	input wire clk, 
	input wire enable, 
	input wire read,
	input wire [31:0] BusMuxOut,
	input wire [31:0] Mdatain, 
	output reg [31:0] qOut
	
); 

	assign dIn = (read == 1)? Mdatain : BusMuxOut;
	
	always@(posedge clk or negedge clr)
		begin 
			if(clr == 0)
				qOut <= 0; 
			else if (enable)
				qOut <= dIn;
			
		end
		initial qOut = VAL; 
endmodule 
	
