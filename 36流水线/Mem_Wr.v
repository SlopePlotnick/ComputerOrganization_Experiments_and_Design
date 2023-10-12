module Mem_Wr(Mem_op,Mem_Reg,Mem_RegWr,Mem_MemtoReg,Mem_alure,Mem_dout,Mem_PC,Mem_rs,Mem_rt,Mem_rd,Mem_shamt,Mem_func,Mem_RegDst,Mem_busA,Mem_busB,clk,
Wr_op,Wr_Reg,Wr_RegWr,Wr_MemtoReg,Wr_alure,Wr_dout,Wr_PC,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_RegDst,Wr_busA,Wr_busB,
Mem_MULT_result,Wr_MULT_result);
//Mem_Wr segement register
	input[5:0]	Mem_op;
	input[4:0]	Mem_Reg;
	input 		Mem_RegWr,Mem_MemtoReg;
	input[31:0]	Mem_alure;
	input[31:0]	Mem_dout;
	input		clk;

	input[31:2]	Mem_PC;
	input[4:0]	Mem_rs,Mem_rt,Mem_rd,Mem_shamt;
	input[5:0]	Mem_func;
	input	Mem_RegDst;
	input[31:0]	Mem_busA,Mem_busB;
	input[63:0]	Mem_MULT_result;

	output reg[5:0]	Wr_op;
	output reg[4:0]	Wr_Reg;
	output reg	Wr_RegWr,Wr_MemtoReg;
	output reg[31:0]	Wr_alure;
	output reg[31:0]	Wr_dout;

	output reg[31:2]	Wr_PC;
	output reg[4:0]	Wr_rs,Wr_rt,Wr_rd,Wr_shamt;
	output reg[5:0]	Wr_func;
	output reg	Wr_RegDst;
	output reg[31:0]	Wr_busA,Wr_busB;
	output reg[63:0]	Wr_MULT_result;
	
	initial 
	begin
		Wr_op = 0;
		Wr_Reg = 0;
		Wr_RegWr = 0;
		Wr_MemtoReg = 0;
		Wr_alure = 0;
		Wr_dout = 0;
		Wr_PC = 0;
		Wr_rs = 0;
		Wr_rt = 0;
		Wr_rd = 0;
		Wr_shamt = 0;
		Wr_func = 0;
		Wr_RegDst = 0;
		Wr_busA = 0;
		Wr_busB = 0;
		Wr_MULT_result = 0;
	end
//initial assignment

	always@(negedge clk)
	begin
		Wr_op <= Mem_op;
		Wr_Reg <= Mem_Reg;
		Wr_RegWr <= Mem_RegWr;
		Wr_MemtoReg <= Mem_MemtoReg;
		Wr_alure <= Mem_alure;
		Wr_dout <= Mem_dout;
		Wr_PC <= Mem_PC;
		Wr_rs <= Mem_rs;
		Wr_rt <= Mem_rt;
		Wr_rd <= Mem_rd;
		Wr_shamt <= Mem_shamt;
		Wr_func <= Mem_func;
		Wr_RegDst <= Mem_RegDst;
		Wr_busA <= Mem_busA;
		Wr_busB <= Mem_busB;
		Wr_MULT_result <= Mem_MULT_result;
	end
//normal assignment
endmodule
