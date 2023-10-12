module MULTFile(op,rt,rd,shamt,func,result,hi_num,lo_num,busA,clk);
	input[5:0]	op;
	input[4:0]	rt,rd,shamt;
	input[5:0]	func;
	input[63:0]	result;
	input[31:0]	busA;
	input		clk;

	output[31:0]	hi_num,lo_num;
	reg[31:0]	HI,LO;
	
	initial
	begin
		HI = 0;
		LO = 0;
	end

	always@(negedge clk)
	begin
		if(op == 6'b000000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011000)//MULT
		begin
			HI <= result[63:32];
			LO <= result[31:0];
		end

		if(op == 6'b000000 && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b010011)//MTLO
		begin
			LO <= busA;
		end

		if(op == 6'b000000 && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b010001)//MTHI
		begin
			HI <= busA;
		end
	end
	
	assign	hi_num = HI;
	assign	lo_num = LO;
//get data from HI and LO register
endmodule
