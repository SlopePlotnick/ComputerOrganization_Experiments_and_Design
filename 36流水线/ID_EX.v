module ID_EX(ID_PC,ID_op,ID_rs,ID_rt,ID_rd,ID_shamt,ID_func,ID_imm16,ID_target,ID_busA,ID_busB,ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,ID_Branch,ID_Jump,ID_ExtOp,ID_ALUctr,
G,H,K,
clk,
EX_PC,EX_op,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_imm16,EX_target,EX_busA,EX_busB,EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump,EX_ExtOp,EX_ALUctr,
EX_hi_num,EX_lo_num,EX_cs_num,
Load_use,
signal,pre_instruction,E,F,
A,B);
//ID_EX segment register

	input[31:2]	ID_PC;
	input[5:0]	ID_op;
	input[4:0]	ID_rs,ID_rt,ID_rd,ID_shamt;
	input[5:0]	ID_func;
	input[15:0]	ID_imm16;
	input[25:0]	ID_target;
	input[31:0]	ID_busA,ID_busB;
	input		ID_RegDst,ID_RegWr,ID_ALUSrc,ID_MemWr,ID_MemtoReg,ID_Branch,ID_Jump;
	input[1:0]	ID_ExtOp;
	input[4:0]	ID_ALUctr;
	input		clk;		
	input		Load_use;
	input		signal;
	input[31:0]	pre_instruction;
	input[31:0]	E,F;
	input[31:0]	G,H;
	input[31:0]	A,B;
	input[31:0]	K;

	output reg[31:2]	EX_PC;
	output reg[5:0]		EX_op;
	output reg[4:0]		EX_rs,EX_rt,EX_rd,EX_shamt;
	output reg[5:0]		EX_func;
	output reg[15:0]	EX_imm16;
	output reg[25:0]	EX_target;
	output reg[31:0]	EX_busA,EX_busB;
	output reg		EX_RegDst,EX_RegWr,EX_ALUSrc,EX_MemWr,EX_MemtoReg,EX_Branch,EX_Jump;
	output reg[1:0]		EX_ExtOp;
	output reg[4:0]		EX_ALUctr;
	output reg[31:0]	EX_hi_num,EX_lo_num;
	output reg[31:0]	EX_cs_num;

	wire[5:0]	pre_op;
	wire[4:0]	pre_rs,pre_rt,pre_rd,pre_shamt;
	wire[5:0]	pre_func;
	wire[15:0]	pre_imm16;
	wire[25:0]	pre_target;
	wire		pre_RegDst,pre_RegWr,pre_ALUSrc,pre_MemWr,pre_MemtoReg,pre_Branch,pre_Jump;
	wire[1:0]	pre_ExtOp;
	wire[4:0]	pre_ALUctr;
//pre_instruction is the instruction which is deleted when branch instruction appears.
//but this only works in test code without delay slot
	assign	pre_op = pre_instruction[31:26];
	assign	pre_rs = pre_instruction[25:21];
	assign	pre_rt = pre_instruction[20:16];
	assign	pre_rd = pre_instruction[15:11];
	assign	pre_shamt = pre_instruction[10:6];
	assign	pre_func = pre_instruction[5:0];
	assign	pre_imm16 = pre_instruction[15:0];
	assign	pre_target = pre_instruction[25:0];

		ctrl CPPL(pre_op,pre_rs,pre_rt,pre_rd,pre_shamt,pre_func,pre_RegDst,pre_RegWr,pre_ALUSrc,pre_MemWr,pre_MemtoReg,pre_ExtOp,pre_ALUctr,pre_Branch,pre_Jump);
//get relevant information of pre_instruction by ctrl

	initial
	begin
		EX_PC = 0;
		EX_op = 0;
		EX_rs = 0;
		EX_rt = 0;
		EX_rd = 0;
		EX_shamt = 0;
		EX_func = 0;
		EX_imm16 = 0;
		EX_target = 0;
		EX_busA = 0;
		EX_busB = 0;
		EX_RegDst = 0;
		EX_RegWr = 0;
		EX_ALUSrc = 0;
		EX_MemWr = 0;
		EX_MemtoReg = 0;
		EX_Branch = 0;
		EX_Jump = 0;
		EX_ExtOp = 0;
		EX_ALUctr = 0;
		EX_hi_num = 0;
		EX_lo_num = 0;
		EX_cs_num = 0;
		
	end
//initial assignment

	always@(negedge clk)
	begin
		if(Load_use == 1)
		begin
		EX_PC <= 0;
		EX_op <= 0;
		EX_rs <= 0;
		EX_rt <= 0;
		EX_rd <= 0;
		EX_shamt <= 0;
		EX_func <= 0;
		EX_imm16 <= 0;
		EX_target <= 0;
		EX_busA <= 0;
		EX_busB <= 0;
		EX_RegDst <= 0;
		EX_RegWr <= 0;
		EX_ALUSrc <= 0;
		EX_MemWr <= 0;
		EX_MemtoReg <= 0;
		EX_Branch <= 0;
		EX_Jump <= 0;
		EX_ExtOp <= 0;
		EX_ALUctr <= 0;
		EX_hi_num <= 0;
		EX_lo_num <= 0;
		EX_cs_num <= 0;
		end

		else if(signal == 1) //跳转指令没有发生有效跳转
		begin	
		EX_PC <= ID_PC + 1;//预测错误 此时EX段应修正执行之前保存的pre_instruction 其PC应为之前没变的ID_PC + 1
		EX_op <= pre_op;
		EX_rs <= pre_rs;
		EX_rt <= pre_rt;
		EX_rd <= pre_rd;
		EX_shamt <= pre_shamt;
		EX_func <= pre_func;
		EX_imm16 <= pre_imm16;
		EX_target <= pre_target;
		EX_busA <= E;
		EX_busB <= F;
		EX_RegDst <= pre_RegDst;
		EX_RegWr <= pre_RegWr;
		EX_ALUSrc <= pre_ALUSrc;
		EX_MemWr <= pre_MemWr;
		EX_MemtoReg <= pre_MemtoReg;
		EX_Branch <= pre_Branch;
		EX_Jump <= pre_Jump;
		EX_ExtOp <= pre_ExtOp;
		EX_ALUctr <= pre_ALUctr;
		EX_hi_num <= H;
		EX_lo_num <= G;
		EX_cs_num <= K;
		end
//pre_instruction assignment

		else
		begin
		EX_PC <= ID_PC;
		EX_op <= ID_op;
		EX_rs <= ID_rs;
		EX_rt <= ID_rt;
		EX_rd <= ID_rd;
		EX_shamt <= ID_shamt;
		EX_func <= ID_func;
		EX_imm16 <= ID_imm16;
		EX_target <= ID_target;
		EX_busA <= A;
		EX_busB <= B;
		EX_RegDst <= ID_RegDst;
		EX_RegWr <= ID_RegWr;
		EX_ALUSrc <= ID_ALUSrc;
		EX_MemWr <= ID_MemWr;
		EX_MemtoReg <= ID_MemtoReg;
		EX_Branch <= ID_Branch;
		EX_Jump <= ID_Jump;
		EX_ExtOp <= ID_ExtOp;
		EX_ALUctr <= ID_ALUctr;
		EX_hi_num <= H;
		EX_lo_num <= G;
		EX_cs_num <= K;
		end
// normal assignment with no Load_use and no branch instruction without really jump		
	end

endmodule

