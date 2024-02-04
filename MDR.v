module MDR (
    input wire clear,
    input wire clock,
    input wire MDRin,
    input wire [31:0] BusMuxOut, Mdatain,
    output wire [31:0] Q, D
);

mux mux2to1(BusMuxOut, Mdatain, Read, D);

assign Q = mux2to1.Q;