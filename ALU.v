module ALU(
	
	input clk, reset,
	
	input wire [31:0] A, B, Y,  
	input wire [31:0] op, 
	
	output reg[31:0] C
	
	);
	
	//instantiating functions (maybe pass Y through instead of A)
	
	booth multiply (A, B); 
	shr shift_r (C, A, B, clk, reset);
	shra shift_r_a (C, A, B, clk, reset);
	shl shift_l (C, A, B, clk, reset);
	ror roll_r (C, A, B, clk, reset);
	rol roll_l (C, A, B, clk, reset);
	negate negate(C, B); 
	
	always @(*) begin
		//the op code only looks at the 5 most significant bits to check the op code 
		case(op[31:27])
		
			5'b01011	:	C <= A | B; 	// OR
			5'b01010	:	C <= A & B; 	// AND
			5'b10010 :  C <= ~A;		// NOT
			5'b00011	:	C <= A + B;	// ADD adder
			5'b00100	:	C <= A - B;	// SUB adder
		
			5'b01111 : C <= multiply; //MUL
			//5'b10000 : //DIV
			5'b00101 : C <= shift_l; //SHR
			5'b00110 : C <= shift_r_a; //SHRA
			5'b00111 : C <= shift_l; //SHL
			5'b01000 : C <= roll_r; //ROR
			5'b01001 : C <= roll_l;//ROL
			5'b10001 : C <= negate; //NEGate
			
		endcase
	end
	
endmodule
