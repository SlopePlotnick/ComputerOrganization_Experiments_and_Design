`include"PC_PPL.v"
`include"IUnit.v"
`include"IF_ID.v"
`include"ID.v"
`include"ID_EX.v"
`include"EX.v"
`include"EX_Mem.v"
`include"Mem.v"
`include"Mem_Wr.v"
`include"Wr.v"
`include"Pre_Data_Hazard.v"
`include"branch_Data_Hazard.v"
`include"MULT_Data_Hazard.v"
`include"CPR_Data_Hazard.v"
`include"ERET_Data_Hazard.v"
`include"Load_use.v"

module datapath_PPL(clk,rst);

	input	clk,rst;
	
	wire[31:2]	PC,NPC;
	wire[31:2]	IF_PC,ID_PC,EX_PC,Mem_PC,Wr_PC;
	wire[31:0]	instruction,ID_instruction,pre_instruction;
	wire		sign,signal;
	wire[31:0]	E,F;
	wire	ID_Jump,EX_Jump;
	wire	ID_Branch,EX_Branch;
	wire[5:0]	ID_op,EX_op,Mem_op,Wr_op;
	wire[4:0]	ID_rs,EX_rs,Mem_rs,Wr_rs;
	wire[4:0]	ID_rt,EX_rt,Mem_rt,Wr_rt;	
	wire[4:0]	ID_rd,EX_rd,Mem_rd,Wr_rd;
	wire[4:0]	ID_shamt,EX_shamt,Mem_shamt,Wr_shamt;
	wire[5:0]	ID_func,EX_func,Mem_func,Wr_func;
	wire[15:0]	ID_imm16,EX_imm16;
	wire[25:0]	ID_target,EX_target;
	wire[31:0]	ID_busA,EX_busA,Mem_busA,Wr_busA;
	wire[31:0]	ID_busB,EX_busB,Mem_busB,Wr_busB;
	wire		ID_RegDst,EX_RegDst,Mem_RegDst,Wr_RegDst;
	wire	ID_RegWr,EX_RegWr,Mem_RegWr,Wr_RegWr;
	wire	ID_ALUSrc,EX_ALUSrc;
	wire	ID_MemWr,EX_MemWr,Mem_MemWr;
	wire	ID_MemtoReg,EX_MemtoReg,Mem_MemtoReg,Wr_MemtoReg;
	wire[1:0]	ID_ExtOp,EX_ExtOp;
	wire[4:0]	ID_ALUctr,EX_ALUctr;
	wire[31:0]	alure,Mem_alure,Wr_alure;
	wire[4:0]	EX_Reg,Mem_Reg,Wr_Reg;
	wire[31:0]	Mem_dout,Wr_dout;
	wire[31:0]	Wr_busW;
	//wire[1:0]	ALUSrcA,ALUSrcB;
	wire[31:0]	A,B;
	wire[1:0]	ALUSrcC,ALUSrcD;
	wire[1:0]	ALUSrcE,ALUSrcF;
	wire		Load_use;
	wire		EX_MemRead;
	//wire[31:0]	ID_hi_num;
	wire[31:0]	EX_hi_num;
	//wire[31:0]	ID_lo_num;
	wire[31:0]	EX_lo_num;
	wire[63:0]	EX_MULT_result,Mem_MULT_result,Wr_MULT_result;
	wire[2:0]	ALUSrcG,ALUSrcH;
	wire[31:0]	G,H;
	wire[1:0]	ALUSrcK,ALUSrcL;
	wire[31:0]	K;
	wire[31:0]	EX_cs_num;

	PC_PPL PCP(NPC,rst,clk,PC,
Load_use);
	IUnit IPP(PC,IF_PC,instruction);
	IF_ID IFIDPP(IF_PC,instruction,ID_PC,ID_instruction,ID_Jump,ID_Branch,ID_op,ID_func,clk,
pre_instruction,sign,signal,
Load_use);

	ID IDPP(ID_PC,ID_op,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,ID_imm16,ID_target,ID_busA,ID_busB,ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,
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
clk,rst);

	ID_EX IDEXPP(ID_PC,ID_op,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,ID_imm16,ID_target,ID_busA,ID_busB,ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,ID_Branch,ID_Jump,ID_ExtOp,ID_ALUctr,
G,H,K,
clk,
EX_PC,EX_op,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_imm16,EX_target,EX_busA,EX_busB,EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump,EX_ExtOp,EX_ALUctr,
EX_hi_num,EX_lo_num,EX_cs_num,
Load_use,
signal,pre_instruction,E,F,
A,B);


	EX EXPP(EX_PC,EX_op,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_imm16,EX_target,EX_busA,EX_busB,
EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump,EX_ExtOp,EX_ALUctr,
alure,EX_Reg,clk,
Mem_alure,Wr_busW,
EX_MemRead,
EX_MULT_result,
EX_hi_num,EX_lo_num,
EX_cs_num);

	EX_Mem EXMEMPP(EX_op,EX_Reg,EX_RegWr,EX_MemWr,EX_MemtoReg,EX_PC,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_RegDst,EX_busA,EX_busB,alure,clk,
Mem_op,Mem_Reg,Mem_RegWr,Mem_MemWr,Mem_MemtoReg,Mem_alure,Mem_PC,Mem_rs,Mem_rt,Mem_rd,Mem_shamt,Mem_func,Mem_RegDst,Mem_busA,Mem_busB,
EX_MULT_result,Mem_MULT_result);

	Mem MEMPP(Mem_op,Mem_Reg,Mem_busB,Mem_RegWr,Mem_MemWr,Mem_MemtoReg,Mem_alure,clk,Mem_dout);

	Mem_Wr MEMWRPP(Mem_op,Mem_Reg,Mem_RegWr,Mem_MemtoReg,Mem_alure,Mem_dout,Mem_PC,Mem_rs,Mem_rt,Mem_rd,Mem_shamt,Mem_func,Mem_RegDst,Mem_busA,Mem_busB,clk,
Wr_op,Wr_Reg,Wr_RegWr,Wr_MemtoReg,Wr_alure,Wr_dout,Wr_PC,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_RegDst,Wr_busA,Wr_busB,
Mem_MULT_result,Wr_MULT_result);

	Wr WRPP(Wr_op,Wr_Reg,Wr_RegWr,Wr_MemtoReg,Wr_alure,Wr_dout,Wr_PC,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_RegDst,Wr_busA,Wr_busB,clk,Wr_busW);

	Pre_Data_Hazard PDHPP(Mem_RegWr,Mem_Reg,ID_rs,ID_rt,EX_RegWr,EX_Reg,Wr_RegWr,Wr_Reg,ALUSrcC,ALUSrcD);

	branch_Data_Hazard BDHPP(Wr_RegWr,Wr_Reg,pre_instruction[25:21],pre_instruction[20:16],Mem_RegWr,Mem_Reg,ALUSrcE,ALUSrcF);

	MULT_Data_Hazard MDHPP(ID_op,ID_func,EX_op,EX_func,Mem_op,Mem_func,Wr_op,Wr_func,ALUSrcG,ALUSrcH);

	CPR_Data_Hazard CDHPP(ID_op,EX_op,Mem_op,Wr_op,ID_rs,EX_rs,Mem_rs,Wr_rs,ID_rd,EX_rd,Mem_rd,Wr_rd,ALUSrcK);

	ERET_Data_Hazard EDHPP(ID_op,ID_func,EX_op,Mem_op,Wr_op,EX_rs,Mem_rs,Wr_rs,EX_rd,Mem_rd,Wr_rd,ALUSrcL);

	Load_use LUPP(EX_MemRead,EX_rt,ID_rs,ID_rt,Load_use);

endmodule
