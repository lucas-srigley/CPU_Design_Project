module ProgramCounter (
    input wire clear,
    input wire clock,
    input wire enable,
    output reg [31:0] pc
);

    always @(posedge clock) begin
        if (clear) begin
            pc <= 32'h0; // Reset to 0 on clear
        end
        else if (enable) begin
            pc <= pc + 1; // Increment the program counter
        end
    end

endmodule
