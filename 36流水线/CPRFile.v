module CPRFile(op,rs,rt,rd,shamt,func,cs,cs_num,busB,PC,CPR14,clk);
	input[5:0]	op;
	input[4:0]	rs,rt,rd,shamt,cs;
	input[5:0]	func;
	input[31:0]	busB;
	input[31:2]	PC;
	input		clk;
	
	output[31:0]	cs_num;
	output[31:0]	CPR14;
	reg[31:0]	CPR[31:0];
	integer		i;

	initial
	begin
		for(i = 0;i<32;i = i+1)
		begin
			CPR[i] = 0;
		end
	end

	always@(negedge clk)
	begin
		if(op == 6'b010000 && rs == 5'b00100 && shamt == 5'b00000 && func == 6'b000000)
		begin
			CPR[rd] <= busB;
		end
		if(op == 6'b000000 && func == 6'b001100)
		begin
			CPR[14] <= {PC,2'b00};
			CPR[13][6:2] <= 5'b01000;
			CPR[12][1] <= 1;
		end
		if(op == 6'b010000 && rs == 5'b10000 && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011000)
		begin
			CPR[12][1] <= 0;
		end
	end

	assign	cs_num = CPR[cs];
	assign	CPR14 = CPR[14];//get cpr 14 for instruction ERET

endmodule
