module ERET_Data_Hazard(ID_op,ID_func,EX_op,Mem_op,Wr_op,EX_rs,Mem_rs,Wr_rs,EX_rd,Mem_rd,Wr_rd,ALUSrcL);
	input[5:0]	ID_op,ID_func;
	input[5:0]	EX_op,Mem_op,Wr_op;
	input[4:0]	EX_rs,Mem_rs,Wr_rs;
	input[4:0]	EX_rd,Mem_rd,Wr_rd;
	output reg[1:0]	ALUSrcL;

	wire	C1L,C2L,C3L;

	assign	C1L = ID_op == 6'b010000 && ID_func == 6'b011000 && EX_op == 6'b010000 && EX_rs == 5'b00100 && EX_rd == 5'b01110;
	assign	C2L = ID_op == 6'b010000 && ID_func == 6'b011000 && Mem_op == 6'b010000 && Mem_rs == 5'b00100 && Mem_rd == 5'b01110 && (EX_op!=6'b010000 || EX_rs!=5'b00100 || EX_rd != 5'b01110);
	assign	C3L = ID_op == 6'b010000 && ID_func == 6'b011000 && Wr_op == 6'b010000 && Wr_rs == 5'b00100 && Wr_rd == 5'b01110 && (EX_op!=6'b010000 || EX_rs!=5'b00100 || EX_rd != 5'b01110) && (Mem_op!=6'b010000 || Mem_rs!=5'b00100 || Mem_rd != 5'b01110);

	initial
	begin
		ALUSrcL = 0;
	end
	
	always@(C1L or C2L or C3L)
	begin
		if(C1L == 1)	ALUSrcL <= 2'b01;//EX_cpr write
		else if(C2L == 1)	ALUSrcL <= 2'b10;//Mem_cpr write
		else if(C3L == 1)	ALUSrcL <= 2'b11;//Wr_cpr write
		else	ALUSrcL <= 2'b00;
	end
	


endmodule
