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
    mem[0] = 32'h01000095; // ld R2, 0x95		  01000095  0000 0001 0000 0000 0000 0000 1001 0101
    mem[1] = 32'h00100038; // ld R0, 0x38(R2)  00100038  0000 0000 0001 0000 0000 0000 0011 1000
	 
    mem[2] = 32'h09000095; // ldi R2, 0x95	  09000095  0000 1001 0000 0000 0000 0000 1001 0101
    mem[3] = 32'h08100038; // ldi R0, 0x38(R2) 08100038  0000 1000 0001 0000 0000 0000 0011 1000
	 
    mem[4] = 32'h10100087; // st 0x87, R1      10100090  0001 0000 1000 0000 0000 0000 1000 0111
    mem[5] = 32'h10880087; // st 0x87(R1), R1  10880087  0001 0000 1000 1000 0000 0000 1000 0111
	 
	 /// MUST CHANGE EVERYTHING BELOW
	 
    mem[6] = 32'h611FFFFD; // addi R2, R3, -3
    mem[7] = 32'h71180025; // ori R2, R3, 0x25
	 
    mem[8] = 32'h9B000019; //brzr R6, 25      9B000019 =>  1001 1011 0000 0000 0000 0000 0001 1001
    mem[9] = 32'h9B080019; //brnz R6, 25
    mem[10] = 32'h9B100019; //brpl R6, 25
    mem[11] = 32'h9B180019; //brmi R6, 25
    mem[12] = 32'hA1000000; //jr R2
    mem[13] = 32'hA9000000; //jal R2
    mem[13] = 32'hA9780000; //jal R2                        1010 1001 0 111 1000 0000 0000 0000 0000
    mem[14] = 32'hC2000000; //mfhi R4
    mem[15] = 32'hCB000000; //mflo R6
    mem[16] = 32'hB1800000; //in R3
    mem[17] = 32'h00000000;
    mem[18] = 32'h00000000;
    mem[19] = 32'h69180025; // andi R2, R3, 0x25 ($25 = 0000000000000100101)
    mem[20] = 32'hB9000000; // out R2
    // DATA VALUES
    mem[70] =  32'hFFFFFFF0; // Value at 0x45 + 1
    mem[117] = 32'hFFFFFFF0; //Value at 0x75 (hex) => 117 decimal
    mem[144] = 32'h00000000; //Memory address where R1 (contains 0x43) will store its contents
    mem[247] = 32'h00000000; //Memory address where 0x90(R1) (contains 0x43) will store its contents
    RAMout = RAMinitial;
end
always @(posedge clock) begin
    if (enableWrite == 1) begin
        mem[address] <= RAMin;
    end
    if(enableRead == 1) begin
        RAMout <= mem[address]; //Read data from the memory address on every clock cycle
    end
end
endmodule