module CPR_Data_Hazard(ID_op,EX_op,Mem_op,Wr_op,ID_rs,EX_rs,Mem_rs,Wr_rs,ID_rd,EX_rd,Mem_rd,Wr_rd,ALUSrcK);
	input[5:0]	ID_op,EX_op,Mem_op,Wr_op;
	input[4:0]	ID_rs,EX_rs,Mem_rs,Wr_rs;
	input[4:0]	ID_rd,EX_rd,Mem_rd,Wr_rd;
	output reg[1:0]	ALUSrcK;

	wire	C1K,C2K,C3K;
	
	assign	C1K = ID_op == 6'b010000 && ID_rs == 5'b00000 && EX_op == 6'b010000 && EX_rs == 5'b00100 && ID_rd == EX_rd;
	assign	C2K = ID_op == 6'b010000 && ID_rs == 5'b00000 && Mem_op == 6'b010000 && Mem_rs == 5'b00100 && ID_rd == Mem_rd && (EX_op!=6'b010000 || EX_rs!=5'b00100 || ID_rd!=EX_rd);
	assign	C3K = ID_op == 6'b010000 && ID_rs == 5'b00000 && Wr_op == 6'b010000 && Wr_rs == 5'b00100 && ID_rd == Wr_rd && (EX_op!=6'b010000 || EX_rs!=5'b00100 || ID_rd!=EX_rd) && (Mem_op!=6'b010000 || Mem_rs!=5'b00100 || ID_rd!=Mem_rd);
	
	initial
	begin
		ALUSrcK = 0;
	end
	
	always@(C1K or C2K or C3K)
	begin
		if(C1K == 1)	ALUSrcK <= 2'b01;//EX_CPR write
		else if(C2K == 1)	ALUSrcK <= 2'b10;//Mem_CPR write
		else if(C3K == 1)	ALUSrcK <= 2'b11;//Wr_CPR wirte
		else	ALUSrcK <= 2'b00;
	end
endmodule	