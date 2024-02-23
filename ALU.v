module ALU(
	input clear,
	input clock,
	input IncPC,

	input wire [31:0] A,
	input wire [31:0] B,
	input wire [31:0] Y,

	input wire [4:0] opcode,

	output reg [63:0] Z 
);
	parameter Logical_AND = 5'b01010, Logical_OR = 5'b01011;

	wire [31:0] IncPC_out, and_result, or_result;
	wire [63:0] mul_out, div_out;


	always @(*) 
		begin
			if (IncPC==1) begin
					Z[31:0] <= IncPC_out[31:0];
					Z[63:32] <= 32'd0;
			end

			case (opcode)

				Logical_AND: begin
					Z[31:0] <= and_result[31:0];
					Z[63:32] <= 32'd0;
				end
				
				Logical_OR: begin
					Z[31:0] <= or_result[31:0];
					Z[63:32] <= 32'd0;
				end

			endcase
	end

	logical_AND logical_and(B, Y, and_result);
	logical_OR logical_or(B, Y, or_result);


endmodule
