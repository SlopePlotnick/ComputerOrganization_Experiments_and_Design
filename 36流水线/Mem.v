`include"dm.v"

module Mem(Mem_op,Mem_Reg,Mem_busB,Mem_RegWr,Mem_MemWr,Mem_MemtoReg,Mem_alure,clk,Mem_dout);
	input[5:0]	Mem_op;
	input[4:0]	Mem_Reg;
	input[31:0]	Mem_busB;
	input 		Mem_RegWr,Mem_MemWr,Mem_MemtoReg;
	input[31:0]	Mem_alure;
	input		clk;

	output[31:0]	Mem_dout;

	dm_4k dmT(Mem_op,Mem_alure,Mem_busB,Mem_dout,clk,Mem_MemWr);//data memory invoking
endmodule
