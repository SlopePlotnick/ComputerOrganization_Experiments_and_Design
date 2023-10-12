`include"ctrl.v"
`include"datapath.v"

module mips(clk, rst);

input clk;
input rst;

wire[5:0] 	op;
wire[4:0]	rs,rt,rd,shamt;
wire[5:0]	func;
wire		RegDst;
wire		RegWr;
wire		ALUSrc;
wire		MemWr;
wire		MemtoReg;
wire[1:0]	ExtOp;
wire[4:0]	ALUctr;
wire		Branch;
wire		Jump;	
wire[31:0]	instruction;

assign 		op = instruction[31:26];
assign 		func = instruction[5:0];
assign		rs = instruction[25:21];
assign		rt = instruction[20:16];
assign		rd = instruction[15:11];
assign		shamt = instruction[10:6];

ctrl CTRL(op, func, RegDst, RegWr, ALUSrc, MemWr, MemtoReg, ExtOp, ALUctr, Branch, Jump);
datapath DPU(RegDst, RegWr, ALUSrc, MemWr, MemtoReg, ExtOp, ALUctr, Branch, Jump, clk, rst, instruction);

endmodule
