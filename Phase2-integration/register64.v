module register64 #(parameter qInitial = 0)(
	input clear, clock, enable, 
	input wire [63:0] d,
	output reg [63:0] q
);

initial 
begin
	q = qInitial;
end

always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {63{1'b0}};
			end
			else if (enable) begin
				q <= d;
			end
		end
endmodule