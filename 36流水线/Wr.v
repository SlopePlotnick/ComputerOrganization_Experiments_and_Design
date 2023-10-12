module Wr(Wr_op,Wr_Reg,Wr_RegWr,Wr_MemtoReg,Wr_alure,Wr_dout,Wr_PC,Wr_rs,Wr_rt,Wr_rd,Wr_shamt,Wr_func,Wr_RegDst,Wr_busA,Wr_busB,clk,Wr_busW);//change
	input[5:0]	Wr_op;
	input[4:0]	Wr_Reg;
	input		Wr_RegWr,Wr_MemtoReg;
	input[31:0]	Wr_alure;
	input[31:0]	Wr_dout;
	input[31:2]	Wr_PC;
	input[4:0]	Wr_rs,Wr_rd,Wr_rt,Wr_shamt;
	input[5:0]	Wr_func;
	input		Wr_RegDst;
	input[31:0]	Wr_busA,Wr_busB;

	input clk;
	
	output reg[31:0]	Wr_busW;
//statement

	always@(*)
	begin
		if(Wr_op == 6'b100000)
		begin
			Wr_busW<={{24{Wr_dout[7]}},Wr_dout[7:0]};
		end
//this is for instruction 'lb'-load byte

		else if(Wr_op == 6'b100100)
		begin
			Wr_busW<={{24'b0},Wr_dout[7:0]};
		end
//this is for instruction 'lbu'-load byte unsigned

		else
		begin
			if(Wr_MemtoReg == 0)	Wr_busW <= Wr_alure;
			else	Wr_busW <= Wr_dout;
			//mux2_32 muxW(Wr_alure,Wr_dout,Wr_MemtoReg,Wr_busW);
		end
//choose data to assign Wr_busW by Wr_MemtoReg
	end
endmodule
	