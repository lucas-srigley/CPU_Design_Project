module RotateRight(input [31:0] A, B, output reg [31:0] result);

integer i;

always @(*)
begin
    for(i = 0; i < 32; i = i + 1)
    begin
        result[i] = A[(i + B) % 32];
    end
end

endmodule
