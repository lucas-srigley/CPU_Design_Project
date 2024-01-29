module add_sub (input wire [31:0] A, B, input wire selection, output wire [31:0] result);

	assign result = (selection == 3) ? A + B : A - B;

endmodule
