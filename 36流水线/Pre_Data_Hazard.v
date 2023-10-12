module Pre_Data_Hazard(Mem_RegWr,Mem_Reg,ID_rs,ID_rt,EX_RegWr,EX_Reg,Wr_RegWr,Wr_Reg,ALUSrcC,ALUSrcD);
	input	Mem_RegWr,EX_RegWr,Wr_RegWr;
	input[4:0]	Mem_Reg,EX_Reg,Wr_Reg,ID_rs,ID_rt;
//parameters which is needed in this module	

	wire	C1C,C1D,C2C,C2D,C3C,C3D;
//intermediate variables	

	assign	C1C = EX_RegWr && (EX_Reg != 0) && (EX_Reg == ID_rs);
	assign	C1D = EX_RegWr && (EX_Reg != 0) && (EX_Reg == ID_rt);
	assign	C2C = Mem_RegWr && (Mem_Reg != 0) && ((EX_Reg != ID_rs)||(EX_Reg == ID_rs && EX_RegWr == 0)) && (Mem_Reg == ID_rs);
	assign	C2D = Mem_RegWr && (Mem_Reg != 0) && ((EX_Reg != ID_rt)||(EX_Reg == ID_rt && EX_RegWr == 0)) && (Mem_Reg == ID_rt);
	assign	C3C = Wr_RegWr && (Wr_Reg != 0) && ((EX_Reg != ID_rs)||(EX_Reg == ID_rs && EX_RegWr == 0)) && ((Mem_Reg != ID_rs)||(Mem_Reg == ID_rs && Mem_RegWr == 0)) && (Wr_Reg == ID_rs);
	assign	C3D = Wr_RegWr && (Wr_Reg != 0) && ((EX_Reg != ID_rt)||(EX_Reg == ID_rt && EX_RegWr == 0)) && ((Mem_Reg != ID_rt)||(Mem_Reg == ID_rt && Mem_RegWr == 0)) && (Wr_Reg == ID_rt); 
//definitions

	output reg[1:0]	ALUSrcC,ALUSrcD;
//reg-type output

	initial
	begin
		ALUSrcC = 0;
		ALUSrcD = 0;
	end
//initial assignment

	always@(C1C or C2C or C3C)
	begin
		if(C1C == 1)	ALUSrcC <= 2'b01;//RS EX-segment data hazard
		else if(C2C == 1)	ALUSrcC <= 2'b10;//RS Mem-segment data hazard
		else if(C3C == 1)	ALUSrcC <= 2'b11;//RS Wr-segment data hazard
		else	ALUSrcC <= 2'b00;//no data hazard
	end

	always@(C1D or C2D or C3D)
	begin
		if(C1D == 1)	ALUSrcD <= 2'b01;//RT EX-segment data hazard
		else if(C2D == 1)	ALUSrcD <= 2'b10;//RT Mem-segment data hazard
		else if(C3D == 1)	ALUSrcD <= 2'b11;//RT Wr-segment data hazard
		else	ALUSrcD <= 2'b00;//no data hazard
	end

endmodule	