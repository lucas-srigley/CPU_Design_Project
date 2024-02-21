module ALU(
	input wire [31:0] A, B, Y,  
	input wire [31:0] op, 
	
	output reg[31:0] C
	
	);
	
	always @(*) begin
		//the op code only looks at the 5 most significant bits to check the op code 
		case(op[31:27])
		
			5'b01011	:	C <= A | B; 	// OR
			5'b01010	:	C <= A & B; 	// AND
			5'b10010 :  C <= ~A;		// NOT
			5'b00011	:	C <= A + B;	// ADD adder
			5'b00100	:	C <= A - B;	// SUB adder
		
			5'b01111 : C <= booth(A, B); //MUL
			//5'b10000 : //DIV
			5'b00101 : C <= shr(A, B); //SHR
			//5'b00110 : //SHRA
			5'b00111 : C <= shl(A, B); //SHL
			//5'b01000 : //ROR
			//5'b01001 : //ROL
			5'b10001 : C <= negate(A, B); //NEGate
			
		endcase
	end
	
endmodule
