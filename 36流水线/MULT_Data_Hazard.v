module MULT_Data_Hazard(ID_op,ID_func,EX_op,EX_func,Mem_op,Mem_func,Wr_op,Wr_func,ALUSrcG,ALUSrcH);
	input[5:0]	ID_op,EX_op,Mem_op,Wr_op;
	input[5:0]	ID_func,EX_func,Mem_func,Wr_func;
	output reg[2:0]	ALUSrcG,ALUSrcH;

	wire	C1G,C1H,C2G,C2H,C3G,C4G,C3H,C4H,C5G,C6G,C5H,C6H;

	assign	C1G = ID_op == 6'b000000 && ID_func == 6'b010010 && EX_op == 6'b000000 && EX_func == 6'b010011;
	assign	C2G = ID_op == 6'b000000 && ID_func == 6'b010010 && EX_op == 6'b000000 && EX_func == 6'b011000;
	assign	C3G = ID_op == 6'b000000 && ID_func == 6'b010010 && Mem_op == 6'b000000 && Mem_func == 6'b010011 && (EX_op != 6'b000000 || (EX_func != 6'b010011 && EX_func != 6'b011000));
	assign	C4G = ID_op == 6'b000000 && ID_func == 6'b010010 && Mem_op == 6'b000000 && Mem_func == 6'b011000 && (EX_op != 6'b000000 || (EX_func != 6'b010011 && EX_func != 6'b011000));
	assign	C5G = ID_op == 6'b000000 && ID_func == 6'b010010 && Wr_op == 6'b000000 && Wr_func == 6'b010011 && (EX_op != 6'b000000 || (EX_func != 6'b010011 && EX_func != 6'b011000)) && (Mem_op != 6'b000000 || (Mem_func != 6'b010011 && Mem_func != 6'b011000));
	assign	C6G = ID_op == 6'b000000 && ID_func == 6'b010010 && Wr_op == 6'b000000 && Wr_func == 6'b011000 && (EX_op != 6'b000000 || (EX_func != 6'b010011 && EX_func != 6'b011000)) && (Mem_op != 6'b000000 || (Mem_func != 6'b010011 && Mem_func != 6'b011000)); 
// lo register related data hazard. There exists two instruction that write into lo register	

	assign	C1H = ID_op == 6'b000000 && ID_func == 6'b010000 && EX_op == 6'b000000 && EX_func == 6'b010001;
	assign	C2H = ID_op == 6'b000000 && ID_func == 6'b010000 && EX_op == 6'b000000 && EX_func == 6'b011000;
	assign	C3H = ID_op == 6'b000000 && ID_func == 6'b010000 && Mem_op == 6'b000000 && Mem_func == 6'b010001 && (EX_op != 6'b000000 || (EX_func != 6'b010001 && EX_func != 6'b011000));
	assign	C4H = ID_op == 6'b000000 && ID_func == 6'b010000 && Mem_op == 6'b000000 && Mem_func == 6'b011000 && (EX_op != 6'b000000 || (EX_func != 6'b010001 && EX_func != 6'b011000));
	assign	C5H = ID_op == 6'b000000 && ID_func == 6'b010000 && Wr_op == 6'b000000 && Wr_func == 6'b010001 && (EX_op != 6'b000000 || (EX_func != 6'b010001 && EX_func != 6'b011000)) && (Mem_op != 6'b000000 || (Mem_func != 6'b010001 && Mem_func != 6'b011000));
	assign	C6H = ID_op == 6'b000000 && ID_func == 6'b010000 && Wr_op == 6'b000000 && Wr_func == 6'b011000 && (EX_op != 6'b000000 || (EX_func != 6'b010001 && EX_func != 6'b011000)) && (Mem_op != 6'b000000 || (Mem_func != 6'b010001 && Mem_func != 6'b011000)); 
// hi register related data hazard. There exists two instruction that write into hi register		


	initial
	begin
		ALUSrcG = 0;
		ALUSrcH = 0;
	end
//initial assignment

	always@(C1G or C2G or C3G or C4G or C5G or C6G)
	begin
		if(C1G == 1)	ALUSrcG <= 3'b001;//EX_write into lo only
		else if(C2G == 1)	ALUSrcG <= 3'b010;//EX_MULT
		else if(C3G == 1)	ALUSrcG <= 3'b011;//Mem_write into lo only
		else if(C4G == 1)	ALUSrcG <= 3'b100;//Mem_MULT
		else if(C5G == 1)	ALUSrcG <= 3'b101;//Wr_write into lo only
		else if(C6G == 1)	ALUSrcG <= 3'b110;//Wr_MULT
		else	ALUSrcG <= 3'b000;
	end

	always@(C1H or C2H or C3H or C4H or C5H or C6H)
	begin
		if(C1H == 1)	ALUSrcH <= 3'b001;//EX_write into HI only
		else if(C2H == 1)	ALUSrcH <= 3'b010;//EX_MULT
		else if(C3H == 1)	ALUSrcH <= 3'b011;//Mem_write into HI only
		else if(C4H == 1)	ALUSrcH <= 3'b100;//Mem_MULT
		else if(C5H == 1)	ALUSrcH <= 3'b101;//Wr_write into hi only
		else if(C6H == 1)	ALUSrcH <= 3'b110;//Wr_MULT
		else	ALUSrcH <= 3'b000;
	end

endmodule
