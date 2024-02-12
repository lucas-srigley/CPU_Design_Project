module mux_2to1(BusMuxOut, Mdatain, Read, D);

input BusMuxOut, Mdatain, Read;

output D;

assign D = (Read == 1) ? Mdatain : BusMuxOut;

endmodule
