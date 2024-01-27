module Phase1 (
    input wire clear,
    input wire clock,
    input wire enable,
    input wire [31:0] dataIn, Y,
	 input wire [63:0] Z,
    output wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, IR, HI, LO, MAR
	
);

    // 8 general-purpose registers

    register #(32, 32, 32'h0) gp_r0 (
        clear,
        clock,
        enable,
        dataIn,
        R0
    );
	 
    register #(32, 32, 32'h0) gp_r1 (
        clear,
        clock,
        enable,
        dataIn,
        R1
    );

    register #(32, 32, 32'h0) gp_r2 (
        clear,
        clock,
        enable,
        dataIn,
        R2
    );
	 
	 
    register #(32, 32, 32'h0) gp_r3 (
        clear,
        clock,
        enable,
        dataIn,
        R3
    );

    register #(32, 32, 32'h0) gp_r4 (
        clear,
        clock,
        enable,
        dataIn,
        R4
    );
	 
    register #(32, 32, 32'h0) gp_r5 (
        clear,
        clock,
        enable,
        dataIn,
        R5
    );

    register #(32, 32, 32'h0) gp_r6 (
        clear,
        clock,
        enable,
        dataIn,
        R6
    );
	 
	 
    register #(32, 32, 32'h0) gp_r7 (
        clear,
        clock,
        enable,
        dataIn,
        R7
    );
	 
    register #(32, 32, 32'h0) ret_r8 (
        clear,
        clock,
        enable,
        dataIn,
        R8
    );
	 
    register #(32, 32, 32'h0) ret_r9 (
        clear,
        clock,
        enable,
        dataIn,
        R9
    );

    register #(32, 32, 32'h0) arg_r10 (
        clear,
        clock,
        enable,
        dataIn,
        R10
    );
	 
	 
    register #(32, 32, 32'h0) arg_r11 (
        clear,
        clock,
        enable,
        dataIn,
        R11
    );

    register #(32, 32, 32'h0) arg_r12 (
        clear,
        clock,
        enable,
        dataIn,
        R12
    );
	 
    register #(32, 32, 32'h0) arg_r13 (
        clear,
        clock,
        enable,
        dataIn,
        R13
    );


    // Instantiate stack pointer register
    register #(32, 32, 32'h0) sp_r14 (
        clear,
        clock,
        enable,
        dataIn,
        R14
    );
	 

    register #(32, 32, 32'h0) ra_r15 (
        clear,
        clock,
        enable,
        dataIn,
        R15
    );
	 
    register #(32, 32, 32'h0) IR_r16 (
        clear,
        clock,
        enable,
        dataIn,
        IR
    );

    register #(32, 32, 32'h0) HI_r17 (
        clear,
        clock,
        enable,
        dataIn,
        HI
    );
	 
    register #(32, 32, 32'h0) LO_r18 (
        clear,
        clock,
        enable,
        dataIn,
        LO
    );
	 
    register #(32, 32, 32'h0) MAR_r19 (
        clear,
        clock,
        enable,
        dataIn,
        MAR
    );

   
endmodule