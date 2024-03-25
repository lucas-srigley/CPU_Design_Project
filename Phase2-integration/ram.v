module ram #(parameter RAMinitial = 0)(
    output reg [31:0] RAMout,
    input [31:0] RAMin,
    input [8:0] address,
    input wire clock,
    input enableWrite, enableRead
);
 
	reg [31:0] mem [511:0];
	initial begin
		$readmemb("mem_init.mif", mem);
		 
//		mem[0] =  32'h01000095; // ld R2, 0x95		 
//		mem[1] =  32'h00100038; // ld R0, 0x38(R2)  
//		 
//		mem[2] =  32'h09000095; // ldi R2, 0x95	  
//		mem[3] =  32'h08100038; // ldi R0, 0x38(R2) 
//		 
//		mem[4] =  32'h10800087; // st 0x87, R1      
//		mem[5] =  32'h10880087; // st 0x87(R1), R1 
//		 
//		mem[6] =  32'h61A7FFFB; // addi R3, R4, -5  
//		mem[7] =  32'h71A00053; // ori ori R3, R4, 0x53
//		mem[8] =  32'h69A00053;	// andi R3, R4, 0x53
//	 
//		mem[9] =  32'h9A80000E;	//brzr R5, 14      
//		mem[10] = 32'h9A88000E; //brnz R5, 14
//		mem[11] = 32'h9A90000E; //brpl R5, 14
//		mem[12] = 32'h9A98000E; //brmi R5, 14
//		 
//		mem[13] = 32'hA3000000; //jr R6
//		mem[14] = 32'hAB000000; //jal R6
//										
//		mem[15] = 32'hC3000000; //mfhi R6
//		mem[16] = 32'hCB800000; //mflo R7
//		 
//		mem[17] = 32'hB9800000; //out R3
//		mem[18] = 32'hB2000000; //in R4

		
		//Address ORG 0
		mem[0] = 32'h09000069; // ldi R2, 0x69 
		mem[1] = 32'h09010002; // ldi R2, 2(R2)
		mem[2] = 32'h00800047; // ld R1, 0x47
		mem[3] = 32'h08880001; // ldi R1, 1(R1)
		mem[4] = 32'h000FFFF9; // ld R0, -7(R1)
		mem[5] = 32'h09800003; // ldi R3, 3
		mem[6] = 32'h09000043; // ldi R2, 0x43
		mem[7] = 32'h99180003; // brmi R2, 3
		mem[8] = 32'h09100006; // ldi R2, 6(R2)
		mem[9] = 32'h01CBFFFE; // ld R7, -2(R2)
		mem[10] = 32'hD0000000; // nop
		mem[11] = 32'h9B900003; // brpl R7, 2
		mem[12] = 32'h0A900004; // ldi R5, 4(R2)
		mem[13] = 32'h0A2FFFFD; // ldi R4, -3(R5)
		mem[14] = 32'h19016000; // add R2, R2, R3
		mem[15] = 32'h61D80003; // addi R7, R7, 3
		mem[16] = 32'h8BB80000; // neg R7, R7
		mem[17] = 32'h93B80000; // not R7, R7
		mem[18] = 32'h6BB8000F; // andi R7, R7, 0xF
		mem[19] = 32'h4040C000; // ror R1, R0, R3
		mem[20] = 32'h71C80009; // ori R7, R1, 9
		mem[21] = 32'h302F3000; // shra R1, R7, R3
		mem[22] = 32'h2910C000; // shr R2, R2, R3
		mem[23] = 32'h1040008E; // st 0x8E, R2
		mem[24] = 32'h49006000; // rol R2, R0, R3
		mem[25] = 32'h5A8C0000; // or R4, R3, R0
		mem[26] = 32'h50280000; // and R1, R2, R0
		mem[27] = 32'h09400006; // st 0x27(R1), R4
		mem[28] = 32'h0A80006B; // sub R0, R2, R4
		mem[29] = 32'h7AAA0000; // shl R1, R2, R3
		mem[30] = 32'hC3C00000; // ldi R4, 6
		mem[31] = 32'hCB000000; // ldi R5, 0x1B
		mem[32] = 32'h82A00000; // mul R5, R4
		mem[33] = 32'h09480001; // mfhi R7
		mem[34] = 32'h0DAFFFE; // mflo R6
		mem[35] = 32'h0E300000; // div R5, R4
		mem[36] = 32'h0EAE0003; // ldi R10, 1(R4)
		mem[37] = 32'hAE000000; // ldi R11, -2(R5)
		mem[38] = 32'hD8000000; // ldi R12, 0(R6)
		mem[39] = 32'h00000000; // ldi R13, 3(R7)
		mem[40] = 32'h00000000; // jal R12
		mem[41] = 32'h00000000; // halt
		mem[42] = 32'h00000000; // subA: ORG 0xA2
		mem[43] = 32'h00000000; // add R9, R10, R12
		mem[44] = 32'h00000000; // sub R8, R11, R13
		mem[45] = 32'h00000000; // sub R9, R9, R8
		mem[46] = 32'h00000000; // jr R15


		RAMout = RAMinitial;
	end

always @(posedge clock) 
begin
	if (enableWrite == 1) begin
		mem[address] <= RAMin;
   end
   if(enableRead == 1) begin
        RAMout <= mem[address]; 
   end
end
endmodule