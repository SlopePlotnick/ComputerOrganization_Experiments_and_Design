module branch_Data_Hazard(Wr_RegWr,Wr_Reg,pre_rs,pre_rt,Mem_RegWr,Mem_Reg,ALUSrcE,ALUSrcF);
	input	Wr_RegWr,Mem_RegWr;
	input[4:0]	Wr_Reg,Mem_Reg,pre_rs,pre_rt;

	wire	C2E,C2F;

	assign	C2E = Wr_RegWr && (Wr_Reg!=0) && ((Mem_Reg != pre_rs) || (Mem_Reg == pre_rs && Mem_RegWr == 0)) && (Wr_Reg == pre_rs);
	assign	C2F = Wr_RegWr && (Wr_Reg!=0) && ((Mem_Reg != pre_rt) || (Mem_Reg == pre_rt && Mem_RegWr == 0)) && (Wr_Reg == pre_rt);

	output reg[1:0]	ALUSrcE,ALUSrcF;

	initial
	begin
		ALUSrcE = 0;
		ALUSrcF = 0;
	end

	always@(C2E)
	begin
		if(C2E == 1)	ALUSrcE <= 2'b10;
		else		ALUSrcE <= 2'b00;
	end

	always@(C2F)
	begin
		if(C2F == 1)	ALUSrcF <= 2'b10;
		else		ALUSrcF <= 2'b00;
	end

endmodule
