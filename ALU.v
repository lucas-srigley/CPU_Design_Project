module ALU(input wire [31:0] A, B, input wire [7:0] op, output reg[31:0] result);
	
	always @(*) begin
		case(op)
			0	:	result = A | B; 	// OR
			1	:	result = A & B; 	// AND
			2  :  result = ~A;		// NOT
			3	:	result = A + B;	// ADD adder
			4	:	result = A - B;	// SUB adder
			5	: 	result = A / B;	// DIV system
		endcase
	end
	
endmodule
