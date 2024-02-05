module reg_files (
    input wire clear,
    input wire clock,
    input wire enable0, enable1, enable2, enable3, enable4, enable5, enable6, enable7, enable8, enable9, enable10, enable11, enable12, enable13, enable14, enable15,
    input wire [31:0] dataIn,
    output wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15
);


    // 8 general-purpose registers

    register #(32, 32, 32'h0) gp_r0 (
        clear,
        clock,
        enable0,
        dataIn,
        R0
    );
	 
    register #(32, 32, 32'h0) gp_r1 (
        clear,
        clock,
        enable1,
        dataIn,
        R1
    );

    register #(32, 32, 32'h0) gp_r2 (
        clear,
        clock,
        enable2,
        dataIn,
        R2
    );
	 
	 
    register #(32, 32, 32'h0) gp_r3 (
        clear,
        clock,
        enable3,
        dataIn,
        R3
    );

    register #(32, 32, 32'h0) gp_r4 (
        clear,
        clock,
        enable4,
        dataIn,
        R4
    );
	 
    register #(32, 32, 32'h0) gp_r5 (
        clear,
        clock,
        enable5,
        dataIn,
        R5
    );

    register #(32, 32, 32'h0) gp_r6 (
        clear,
        clock,
        enable6,
        dataIn,
        R6
    );
	 
	 
    register #(32, 32, 32'h0) gp_r7 (
        clear,
        clock,
        enable7,
        dataIn,
        R7
    );
	 
    register #(32, 32, 32'h0) ret_r8 (
        clear,
        clock,
        enable8,
        dataIn,
        R8
    );
	 
    register #(32, 32, 32'h0) ret_r9 (
        clear,
        clock,
        enable9,
        dataIn,
        R9
    );

    register #(32, 32, 32'h0) arg_r10 (
        clear,
        clock,
        enable10,
        dataIn,
        R10
    );
	 
	 
    register #(32, 32, 32'h0) arg_r11 (
        clear,
        clock,
        enable11,
        dataIn,
        R11
    );

    register #(32, 32, 32'h0) arg_r12 (
        clear,
        clock,
        enable12,
        dataIn,
        R12
    );
	 
    register #(32, 32, 32'h0) arg_r13 (
        clear,
        clock,
        enable13,
        dataIn,
        R13
    );


    // Instantiate stack pointer register
    register #(32, 32, 32'h0) sp_r14 (
        clear,
        clock,
        enable14,
        dataIn,
        R14
    );
	 

    register #(32, 32, 32'h0) ra_r15 (
        clear,
        clock,
        enable15,
        dataIn,
        R15
    );

   
endmodule