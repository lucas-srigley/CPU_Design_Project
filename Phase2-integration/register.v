module register #(parameter qInitial = 0)(
	input clear, clock, enable, 
	input wire [31:0] d,
	output reg [31:0] q
);

initial 
begin
	q = qInitial;
end

always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {31{1'b0}};
			end
			else if (enable) begin
				q <= d;
			end
		end
endmodule
