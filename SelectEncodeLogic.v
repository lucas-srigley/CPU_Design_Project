module SelectEncodeLogic(input [31:0] instr, input Gra, Grb, Grc, Rin, Rout, BAout, 
								 output [4:0] opcode, output [31:0] C_sign_extended,
								 output [15:0] RegIn, output [15:0] RegOut, 
								 output wire [3:0] decoderIn);
	
	wire [15:0] decoderOut;
	
	assign decoderIn = (instr[26:23]&{4{Gra}}) | (instr[22:19]&{4{Grb}}) | (instr[18:15]&{4{Grc}});

	Decoder_4to16 decoded(decoderIn, decoderOut);
	
	assign opcode = instr[31:27];
	assign C_sign_extended = {{13{instr[18]}},instr[18:0]};
	assign RegIn = {16{Rin}} & decoderOut;
	assign RegOut = ({16{Rout}} | {16{BAout}}) & decoderOut;

endmodule