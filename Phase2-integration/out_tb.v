`timescale 1ns/10ps
module out_tb;
    reg PC_out, ZLow_out, ZHigh_out, HI_out, LO_out, C_out, in_port_out; 
    wire [31:0] MDR_data_out;
    reg MDR_out;
    reg MAR_enable, Z_enable, PC_enable, MDR_enable, IR_enable, Y_enable, LO_enable, HI_enable, InPort;
    reg IncPC, Read;
    reg [4:0] opcode;
    reg Clock, clr;
    wire [31:0] Mdatain;

    reg con_in, in_port_in, BA_out,Gra, Grb, Grc, out_port_enable, R_in, R_out, in_port_enable;
    reg RAM_write_enable;

    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6= 4'b1101, T7= 4'b1110;
    reg [3:0] Present_state = Default;

	DataPath DUT(
			 Mdatain, MDR_data_out,
			 PC_out, ZHigh_out, ZLow_out, HI_out, LO_out, C_out,
			 MDR_out, MDR_enable, MAR_enable, Z_enable, Y_enable, PC_enable, LO_enable, 
			 HI_enable, clr, Clock, InPort, IncPC, Read,
			 opcode,
			 con_in, out_port_enable, RAM_write_enable, IR_enable,
			 Gra, Grb, Grc, R_in, R_out, BA_out, in_port_out, in_port_enable
	);

    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;
    end

    always @(posedge Clock) begin
        case (Present_state)
            Default : Present_state = T0;
            T0 : Present_state = T1;
            T1 : #40 Present_state = T2;
            T2 : #40 Present_state = T3;
        endcase
    end

    always @(Present_state) begin
        case (Present_state)
            Default: begin
                PC_out <= 0; ZLow_out <= 0; clr <= 0;
                MAR_enable <= 0; Z_enable <= 0;
                PC_enable <= 0; MDR_enable <= 0; IR_enable = 0; Y_enable = 0;
                IncPC <= 0; Read <= 0; opcode <= 0;
                ZHigh_out <= 0; HI_out <= 0; LO_out <= 0; C_out <= 0; in_port_out <= 0;
                MDR_out <= 0;

                Gra <= 0; Grb <= 0; Grc <= 0; BA_out <= 0; RAM_write_enable <= 0; out_port_enable <= 0; 
                in_port_in <= 0; con_in <= 0; R_out <= 0; R_in <= 0;
            end
            T0: begin
                PC_out <= 1;  
            end
            T1: begin
                MAR_enable <= 1; 
                Read <= 1;
                MDR_enable <= 1; 
            end
            T2: begin
                PC_enable <= 1;
                IncPC <= 1;
                PC_out <= 0; MAR_enable <= 0; IncPC <= 0; PC_enable <= 0;
                MDR_enable <= 0;
                MDR_out <= 1; IR_enable <= 1;
            end
            T3: begin
                MDR_out <= 0; IR_enable <= 0;
                Gra <= 1; R_out <= 1; 
                out_port_enable <= 1;
            end 
        endcase
    end
endmodule
