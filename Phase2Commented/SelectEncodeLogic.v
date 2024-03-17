module SelectEncodeLogic(
	input [31:0] IR, 
	input wire Gra, Grb, Grc, Rin, Rout, BAout,  
	output reg [31:0] C_sign_extended,
	output reg [15:0] RegIn, RegOut
);
	// register for the input of the decoder; set all 4 bits to 0 in binary
	reg [3:0] decoderIn = 4'b0000;
	// register for the output of the 16-bit decoder
	reg [15:0] decoderOut;

	initial
			
	begin
		// register in and out, setting all 16 bits to 0
		RegOut = 16'b0;
		RegIn = 16'b0;	 
	end

	reg BAout_or_Rout;
	
	// registers that are used to store the IR's masked bits
	reg [3:0] RA_GRA, RB_GRB, RC_GRC;

   always@(*)
	begin
		// register to store the OR of Rout and BAOout
		BAout_or_Rout = (Rout | BAout);
   end
	 
   always@(*)
	begin
			// finding the masked values of the IR and storing them respectively
        RA_GRA = (IR[26:23] & (Gra? 4'b1111: 4'b0000));
        RB_GRB = (IR[22:19] & (Grb? 4'b1111: 4'b0000));
        RC_GRC = (IR[18:15] & (Grc? 4'b1111: 4'b0000));
		  
		  // using the OR of the masked values to calculate the input for the decoder
        decoderIn = (RA_GRA | RB_GRB | RC_GRC);  
   end

   always@(*) 
   begin
		case(decoderIn)
			// assigning values from 1 to 16 to decoderOut based on the values of decorderIn
			// ranging from input values of 0 to 15
			4'b0000 : decoderOut <= 16'b0000000000000001; 
			4'b0001 : decoderOut <= 16'b0000000000000010;
			4'b0010 : decoderOut <= 16'b0000000000000100; 
			4'b0011 : decoderOut <= 16'b0000000000001000; 
			4'b0100 : decoderOut <= 16'b0000000000010000; 
			4'b0101 : decoderOut <= 16'b0000000000100000; 
			4'b0110 : decoderOut <= 16'b0000000001000000;  
			4'b0111 : decoderOut <= 16'b0000000010000000;  
			4'b1000 : decoderOut <= 16'b0000000100000000;  
			4'b1001 : decoderOut <= 16'b0000001000000000;  
			4'b1010 : decoderOut <= 16'b0000010000000000;  
			4'b1011 : decoderOut <= 16'b0000100000000000;  
			4'b1100 : decoderOut <= 16'b0001000000000000;  
			4'b1101 : decoderOut <= 16'b0010000000000000;  
			4'b1110 : decoderOut <= 16'b0100000000000000;  
			4'b1111 : decoderOut <= 16'b1000000000000000; 
			
			// assigned 0 to decoderOut as a default
			default: decoderOut  <= 16'b0000000000000000;
				
		endcase
		  
    end

	
	always@(*)
   begin
		case(decoderOut)
			// assign a value for RegIn, based on the value of decorderOut, ranging from 1-16
			// will be set tp the first value if Rin is high, else (if it's low) it's set to 0
			16'b0000000000000001: RegIn <= 16'b0000000000000001 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000000000010: RegIn <= 16'b0000000000000010 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000000000100: RegIn <= 16'b0000000000000100 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000000001000: RegIn <= 16'b0000000000001000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000000010000: RegIn <= 16'b0000000000010000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000000100000: RegIn <= 16'b0000000000100000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000001000000: RegIn <= 16'b0000000001000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000010000000: RegIn <= 16'b0000000010000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000000100000000: RegIn <= 16'b0000000100000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000001000000000: RegIn <= 16'b0000001000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000010000000000: RegIn <= 16'b0000010000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0000100000000000: RegIn <= 16'b0000100000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0001000000000000: RegIn <= 16'b0001000000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0010000000000000: RegIn <= 16'b0010000000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b0100000000000000: RegIn <= 16'b0100000000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
			16'b1000000000000000: RegIn <= 16'b1000000000000000 & (Rin ? 16'b1111111111111111: 16'b0000000000000000); 
		   
			// set RegIn to 0 as a default case
			default: RegIn <=  16'b0000000000000000;
		  
		endcase 
			  
    end
   
    always@(*)
    begin
		case(decoderOut) 
			// assign a value for RegOut based on the value of decorderOut, ranging from 1-16
			// will be set to the first value if the or of BAout and Rout is high, and if it's low it's set to 0
		  16'b0000000000000001: RegOut <= 16'b0000000000000001 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);
		  16'b0000000000000010: RegOut <= 16'b0000000000000010 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);
		  16'b0000000000000100: RegOut <= 16'b0000000000000100 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);
		  16'b0000000000001000: RegOut <= 16'b0000000000001000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000); 
		  16'b0000000000010000: RegOut <= 16'b0000000000010000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000); 
		  16'b0000000000100000: RegOut <= 16'b0000000000100000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000); 
		  16'b0000000001000000: RegOut <= 16'b0000000001000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0000000010000000: RegOut <= 16'b0000000010000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0000000100000000: RegOut <= 16'b0000000100000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0000001000000000: RegOut <= 16'b0000001000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0000010000000000: RegOut <= 16'b0000010000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0000100000000000: RegOut <= 16'b0000100000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0001000000000000: RegOut <= 16'b0001000000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0010000000000000: RegOut <= 16'b0010000000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b0100000000000000: RegOut <= 16'b0100000000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  
		  16'b1000000000000000: RegOut <= 16'b1000000000000000 & (BAout_or_Rout? 16'b1111111111111111: 16'b0000000000000000);  

		  // assigned 0 to decoderOut as a default
		  default: RegOut <= 16'b0000000000000000;
			  
		endcase   
    end

	always@(IR)
   begin
		// take the least significant 19 bits of the IR signal and extend them
		// if the 18th bit is 1, it extends with all 1s, else, it extends with all 0s
		C_sign_extended = $signed(IR[18:0]);
	end
	 
endmodule 
