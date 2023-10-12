`include"ctrl.v"
`include"RegFile_PPL.v"
`include"MULTFile.v"
`include"CPRFile.v"
`include"NPC.v"

module ID(ID_PC,ID_op,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,ID_imm16,ID_target,ID_busA,ID_busB,ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,
ID_Branch,ID_Jump,ID_ExtOp,ID_ALUctr,ID_instruction,NPC,
Wr_op,Wr_PC,Wr_alure,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_busW,Wr_RegWr,Wr_RegDst,
alure,Mem_alure,Mem_dout,Mem_MemtoReg,
ALUSrcC,ALUSrcD,
PC,
sign,
pre_instruction,E,F,
ALUSrcE,ALUSrcF,
Wr_MULT_result,Wr_busA,Wr_busB,
G,H,EX_MULT_result,EX_busA,Mem_MULT_result,Mem_busA,
ALUSrcG,ALUSrcH,ALUSrcK,ALUSrcL,
A,B,K,
EX_busB,Mem_busB,
clk,reset);

	input clk,reset;
	input[31:2]	ID_PC;
	input[31:0]	ID_instruction;
	input[5:0]	Wr_op;
	input[31:2]	Wr_PC;
	input[31:0]	Wr_alure;
	input[4:0]	Wr_rs,Wr_rt,Wr_rd,Wr_shamt;
	input[5:0]	Wr_func;
	input[31:0]	Wr_busW;
	input	Wr_RegWr,Wr_RegDst;

	input[1:0]	ALUSrcC,ALUSrcD;
	input[1:0]	ALUSrcE,ALUSrcF;
	input[31:0]	alure,Mem_alure,Mem_dout;
	input	Mem_MemtoReg;

	input[31:2]	PC;
	input[31:0]	pre_instruction;
	input[63:0]	Wr_MULT_result,EX_MULT_result,Mem_MULT_result;
	input[31:0]	Wr_busA,EX_busA,Mem_busA;
	input[2:0]	ALUSrcG,ALUSrcH;
	input[1:0]	ALUSrcK,ALUSrcL;
	input[31:0]	EX_busB,Mem_busB,Wr_busB;

	output[5:0]	ID_op;
	output[4:0]	ID_rs,ID_rt,ID_rd,ID_shamt;
	output[5:0]	ID_func;
	output[15:0]	ID_imm16;
	output[25:0]	ID_target;
	output[31:0]	ID_busA,ID_busB;
	output		ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,ID_Branch,ID_Jump;
	output[1:0]	ID_ExtOp;
	output[4:0]	ID_ALUctr;
	output[31:2]	NPC;
	output		sign;
	output[31:0]	K;

	output[31:0]	E,F;
	output[31:0]	G,H;
	wire[31:0]	ID_hi_num,ID_lo_num;

	wire[31:0]	pre_busA,pre_busB;
	wire[31:2]	FormerPC;
	wire		ID_zero;
	wire[31:0]	cs_num;
	assign	FormerPC = ID_PC - 1;//Is this correct? check it later

	assign	ID_op = ID_instruction[31:26];
	assign	ID_rs = ID_instruction[25:21];
	assign	ID_rt = ID_instruction[20:16];
	assign	ID_rd = ID_instruction[15:11];
	assign	ID_shamt = ID_instruction[10:6];
	assign	ID_func = ID_instruction[5:0];
	assign	ID_imm16 = ID_instruction[15:0];
	assign	ID_target = ID_instruction[25:0];

	wire[31:2]	Wr_FormerPC;
	assign		Wr_FormerPC = Wr_PC - 1;

	wire[31:0]	CPR14;

	ctrl ctrlPPL(ID_op,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,ID_ExtOp,ID_ALUctr,ID_Branch,ID_Jump);
	RegFile_PPL REGPPL(Wr_op,Wr_FormerPC,Wr_alure,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_busW,Wr_RegWr,Wr_RegDst,ID_rs,ID_rt,ID_busA,ID_busB,pre_instruction[25:21],pre_instruction[20:16],pre_busA,pre_busB,clk,reset);
	MULTFile MFPPL(Wr_op,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_MULT_result,ID_hi_num,ID_lo_num,Wr_busA,clk);
	CPRFile CPRPPL(Wr_op,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,ID_rd,cs_num,Wr_busB,Wr_FormerPC,CPR14,clk);
//some operations with data in other segments, mainly the write register operation

	output[31:0]	A,B;

	assign	A = (ALUSrcC == 2'b00)? ID_busA :
		(ALUSrcC == 2'b01)? alure :
		(ALUSrcC == 2'b10 && Mem_MemtoReg == 0)? Mem_alure :
		(ALUSrcC == 2'b10 && Mem_MemtoReg == 1)? Mem_dout : 
		(ALUSrcC == 2'b11)? Wr_busW : 0;
	assign	B = (ALUSrcD == 2'b00)? ID_busB :
		(ALUSrcD == 2'b01)? alure :
		(ALUSrcD == 2'b10 && Mem_MemtoReg == 0)? Mem_alure :
		(ALUSrcD == 2'b10 && Mem_MemtoReg == 1)? Mem_dout : 
		(ALUSrcD == 2'b11)? Wr_busW : 0; 
//Pre_data_hazard

	assign	E = (ALUSrcE == 2'b00)? pre_busA :
		(ALUSrcE == 2'b10)? Wr_busW : 0;

	assign	F = (ALUSrcF == 2'b00)? pre_busB :
		(ALUSrcF == 2'b10)? Wr_busW : 0;
//branch_data_hazard

	assign	G = (ALUSrcG == 3'b000)? ID_lo_num :
		(ALUSrcG == 3'b001)? EX_busA :
		(ALUSrcG == 3'b010)? EX_MULT_result[31:0] :
		(ALUSrcG == 3'b011)? Mem_busA : 
		(ALUSrcG == 3'b100)? Mem_MULT_result[31:0] : 
		(ALUSrcG == 3'b101)? Wr_busA : 
		(ALUSrcG == 3'b110)? Wr_MULT_result[31:0] :0;

	assign	H = (ALUSrcH == 3'b000)? ID_hi_num :
		(ALUSrcH == 3'b001)? EX_busA :
		(ALUSrcH == 3'b010)? EX_MULT_result[63:32] :
		(ALUSrcH == 3'b011)? Mem_busA : 
		(ALUSrcH == 3'b100)? Mem_MULT_result[63:32] : 
		(ALUSrcH == 3'b101)? Wr_busA : 
		(ALUSrcH == 3'b110)? Wr_MULT_result[63:32] :0;
//MULT_data_hazard

	assign	K = (ALUSrcK == 2'b00)? cs_num :
		(ALUSrcK == 2'b01)? EX_busB :
		(ALUSrcK == 2'b10)? Mem_busB :
		(ALUSrcK == 2'b11)? Wr_busB :0;
//CPR_data_hazard
	assign	ID_zero = (A == B)?1:0;

	wire[31:0]	L;
	assign	L = (ALUSrcL == 2'b00)? CPR14 :
		(ALUSrcL == 2'b01)? EX_busB :
		(ALUSrcL == 2'b10)? Mem_busB :
		(ALUSrcL == 2'b11)? Wr_busB :0;
//ERET_data_hazard

	NPC NPCPPL(PC,NPC,ID_Jump,ID_Branch,ID_zero,ID_op,ID_target,ID_imm16,A,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,sign,L);
//NPC calculation

endmodule
