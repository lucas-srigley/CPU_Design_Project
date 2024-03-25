`timescale 1ns/10ps
module ControlUnit_tb;

reg clock, clear, stop;
wire[31:0] in_port_data_in, out_port_data_out, MuxOut;
wire [4:0] opcode;

Datapath DUT(clock, stop, clear, in_port_data_in, out_port_data_out, MuxOut);


initial
begin
    clock = 0; clear = 0;
    forever #10 clock =~ clock;
end
endmodule