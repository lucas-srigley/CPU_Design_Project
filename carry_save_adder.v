module carry_save_adder(A, B, Sum, CarryOut);

    input [31:0] A, B;
    output [31:0] Sum;
    output CarryOut;

    reg [31:0] Sum;
    reg CarryOut;

    reg [8:0] LocalCarry;

    integer i;

    always @(A or B)
    begin
        LocalCarry = 9'd0;
        for (i = 0; i < 8; i = i + 1)
        begin
            Sum[i] = A[i] ^ B[i] ^ LocalCarry[i];
            LocalCarry[i + 1] = (A[i] & B[i]) | (LocalCarry[i] & (A[i] | B[i]));
        end
        CarryOut = LocalCarry[8]; // The carry-out is the MSB of LocalCarry
    end

endmodule
