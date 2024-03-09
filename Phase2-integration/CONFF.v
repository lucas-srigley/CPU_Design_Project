module CONFF #(parameter conInitial = 0)(
    output reg conOut,
    input wire conIn,
    input wire [31:0] busIn,
    input wire [1:0] IR
);

	initial
	begin
		 conOut = conInitial;
	end

	// registers for: greater than or equal to zero, less than zero, nor (not OR) zero, equal to zero,
	// and not equal zero, defined respectively
	reg greZero, lessZero, norOut, eqZero, neqZero;
	reg [3:0] decoderOut;

	always @(*) 
	begin
		if (conIn == 1)
		begin
			case(IR)
				2'b00: decoderOut <= 4'b0001;
				2'b01: decoderOut <= 4'b0010;
				2'b10: decoderOut <= 4'b0100;
				2'b11: decoderOut <= 4'b1000;
				default: decoderOut <= 4'b0000;

			endcase

			norOut = ~|busIn;
			eqZero <= decoderOut[0] & norOut;
			neqZero <= decoderOut[1] & ~(norOut);
			greZero <= decoderOut[2] & ~(busIn[31]);
			lessZero <= decoderOut[3] & busIn[31];

			// set conOut to the OR of all 4 different cases
			conOut = (neqZero | eqZero | lessZero | greZero);
		end
	end
endmodule