`include"extender.v"
`include"alu.v"
`include"MULT.v"
`include"mux2_5.v"

module EX(EX_PC,EX_op,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_imm16,EX_target,EX_busA,EX_busB,
EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump,EX_ExtOp,EX_ALUctr,
alure,EX_Reg,clk,
Mem_alure,Wr_busW,
EX_MemRead,
EX_MULT_result,
EX_hi_num,EX_lo_num,
EX_cs_num);
	input[31:2]	EX_PC;
	input[5:0]	EX_op;
	input[4:0]	EX_rs,EX_rt,EX_rd,EX_shamt;
	input[5:0]	EX_func;
	input[15:0]	EX_imm16;
	input[25:0]	EX_target;
	input[31:0]	EX_busA,EX_busB;
	input		EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump;
	input[1:0]	EX_ExtOp;
	input[4:0]	EX_ALUctr;

	input		clk;

	//input[1:0]	ALUSrcA,ALUSrcB;
	input[31:0]	Mem_alure,Wr_busW;
	input[31:0]	EX_hi_num,EX_lo_num;
	input[31:0]	EX_cs_num;

	output[31:0]	alure;//alu result
	output[4:0]	EX_Reg;//rt or rd

	output	EX_MemRead;
	output[63:0]	EX_MULT_result;	

	assign	EX_MemRead = (EX_op == 6'b100011)? 1:0;

	wire[31:0]	EX_imm32;
	wire[31:0]	B;
	wire[31:0]	G,H;
	wire		zero;

	extender extM(EX_imm16,EX_ExtOp,EX_imm32);//need
	/*assign A = (ALUSrcA == 2'b00)? EX_busA :
		(ALUSrcA == 2'b01)? Mem_alure :
		(ALUSrcA == 2'b10)? Wr_busW : 0;
	assign B = (ALUSrcB == 2'b00)? EX_busB :
		(ALUSrcB == 2'b01)? Mem_alure :
		(ALUSrcB == 2'b10)? Wr_busW :
		(ALUSrcB == 2'b11)? EX_imm32 : 0;
	assign C = (ALUSrcB == 2'b00)? EX_busB :
		(ALUSrcB == 2'b01)? Mem_alure :
		(ALUSrcB == 2'b10)? Wr_busW :
		(ALUSrcB == 2'b11)? EX_busB : 0;*/

	assign	B = (EX_ALUSrc == 1)? EX_imm32 : EX_busB;
	alu AM(EX_ALUctr,EX_busA,B,EX_imm32,EX_shamt,alure,zero,EX_lo_num,EX_hi_num,EX_cs_num);
//alu calculation
	MULT MU(EX_op,EX_busA,EX_busB,EX_rd,EX_shamt,EX_func,EX_MULT_result);
//MULT calculation
	mux2_5 mux(EX_rt,EX_rd,EX_RegDst,EX_Reg);
//choose data

endmodule
