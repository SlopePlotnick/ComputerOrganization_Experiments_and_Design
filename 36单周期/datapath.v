`include"PC.v"
`include"NPC.v"
`include"im.v"
`include"RegFile.v"
`include"extender.v"
`include"mux.v"
`include"ALU.v"
`include"dm.v"

module datapath(RegDst, RegWr, ALUSrc, MemWr, MemtoReg, ExtOp, ALUctr, Branch, Jump, clk, reset, instruction);

input RegDst, RegWr, ALUSrc, MemWr, MemtoReg, Branch, clk, reset, Jump;
input[1:0] ExtOp;
input[4:0] ALUctr;
output[31:0] instruction;

wire[31:2]	PC;
wire[31:2]	NPC;
wire		zero;
wire[31:0]	alure;     //alu result
wire[31:0]	exout;
wire[31:0]	r1,r2;
wire[31:0]	data2;
wire[31:0]	wdata;
wire[31:0]	dout;

PC pc(NPC, clk, reset, PC);
NPC npc(PC, zero, Branch, instruction[31:26], instruction[15:0], instruction[25:0], Jump, NPC, r1, instruction[25:21], instruction[20:16], instruction[15:11], instruction[10:6], instruction[5:0]);
im_4k ReOrM(PC, instruction);
RegFile RM(instruction[31:26], PC, instruction[25:21], instruction[20:16], instruction[15:11], instruction[10:6], instruction[5:0], wdata, RegWr, RegDst, r1, r2, clk, reset);
extender extM(instruction[15:0], ExtOp, exout);
mux2 mux2_32M(r2, exout, ALUSrc, data2);
ALU AM(ALUctr, r1, data2, instruction[10:6], alure, zero);
dm_4k DMM(instruction[31:26], alure, r2, dout, clk, MemWr);
mux2 mux2_M(alure, dout, MemtoReg, wdata);
	
endmodule
