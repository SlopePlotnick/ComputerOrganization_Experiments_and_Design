module EX_Mem(EX_op,EX_Reg,EX_RegWr,EX_MemWr,EX_MemtoReg,EX_PC,EX_rs,EX_rt,EX_rd,EX_shamt,EX_func,EX_RegDst,EX_busA,EX_busB,alure,clk,
Mem_op,Mem_Reg,Mem_RegWr,Mem_MemWr,Mem_MemtoReg,Mem_alure,Mem_PC,Mem_rs,Mem_rt,Mem_rd,Mem_shamt,Mem_func,Mem_RegDst,Mem_busA,Mem_busB,
EX_MULT_result,Mem_MULT_result);
//EX_Mem segment register
	input[5:0]	EX_op;
	input[4:0]	EX_Reg;
	input		EX_RegWr,EX_MemWr,EX_MemtoReg;
	input[31:0]	alure;
	input		clk;

	input[31:2]	EX_PC;
	input[4:0]	EX_rs,EX_rt,EX_rd,EX_shamt;
	input[5:0]	EX_func;
	input		EX_RegDst;
	input[31:0]	EX_busA,EX_busB;

	input[63:0]	EX_MULT_result;

	output reg[5:0]	Mem_op;
	output reg[4:0]	Mem_Reg;
	output reg		Mem_RegWr,Mem_MemWr,Mem_MemtoReg;
	output reg[31:0]	Mem_alure;
	output reg[31:2]	Mem_PC;
	output reg[4:0]	Mem_rs,Mem_rt,Mem_rd,Mem_shamt;
	output reg[5:0]	Mem_func;
	output reg	Mem_RegDst;
	output reg[31:0]	Mem_busA,Mem_busB;
	output reg[63:0]	Mem_MULT_result;
//assignment

	initial
	begin
		Mem_op = 0;
		Mem_Reg = 0;
		Mem_RegWr = 0;
		Mem_MemWr = 0;
		Mem_MemtoReg = 0;
		Mem_alure = 0;
		Mem_PC = 0;
		Mem_rs = 0;
		Mem_rt = 0;
		Mem_rd = 0;
		Mem_shamt = 0;
		Mem_func = 0;
		Mem_RegDst = 0;
		Mem_busA = 0;
		Mem_busB = 0;
		Mem_MULT_result = 0;
	end
//initial assignment

	always@(negedge clk)
	begin
		Mem_op <= EX_op;
		Mem_Reg <= EX_Reg;
		Mem_RegWr <= EX_RegWr;
		Mem_MemWr <= EX_MemWr;
		Mem_MemtoReg <= EX_MemtoReg;
		Mem_alure <= alure;
		Mem_PC <= EX_PC;
		Mem_rs <= EX_rs;
		Mem_rt <= EX_rt;
		Mem_rd <= EX_rd;
		Mem_shamt <= EX_shamt;
		Mem_func <= EX_func;
		Mem_RegDst <= EX_RegDst;
		Mem_busA <= EX_busA;
		Mem_busB <= EX_busB;
		Mem_MULT_result <= EX_MULT_result;
	end
//normal assignment
endmodule
	
