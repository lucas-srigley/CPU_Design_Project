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
		 
		mem[0] =  32'h01000095; // ld R2, 0x95		 
		mem[1] =  32'h00100038; // ld R0, 0x38(R2)  
		 
		mem[2] =  32'h09000095; // ldi R2, 0x95	  
		mem[3] =  32'h08100038; // ldi R0, 0x38(R2) 
		 
		mem[4] =  32'h10800087; // st 0x87, R1      
		mem[5] =  32'h10880087; // st 0x87(R1), R1 
		 
		mem[6] =  32'h61A7FFFB; // addi R3, R4, -5  
		mem[7] =  32'h71A00053; // ori ori R3, R4, 0x53
		mem[8] =  32'h69A00053;	// andi R3, R4, 0x53
	 
		mem[9] =  32'h9A80000E;	 //brzr R5, 14      
		mem[10] = 32'h9A88000E; //brnz R5, 14
		mem[11] = 32'h9A90000E; //brpl R5, 14
		mem[12] = 32'h9A98000E; //brmi R5, 14
		 
		mem[13] = 32'hA3000000; //jr R6
		mem[14] = 32'hAB000000; //jal R6
										
		mem[15] = 32'hC3000000; //mfhi R6
		mem[16] = 32'hCB800000; //mflo R7
		 
		mem[17] = 32'hB9800000; //out R3
		mem[18] = 32'hB2000000; //in R4

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