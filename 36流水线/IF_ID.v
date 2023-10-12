module IF_ID(IF_PC,instruction,ID_PC,ID_instruction,Jump,Branch,op,func,clk,
pre_instruction,sign,signal,
Load_use);
	input[31:2]	IF_PC;
	input[31:0]	instruction;
	input		clk;
	input		Jump;
	input		Branch;
	input		Load_use;
	input		sign;
	input[5:0]	op,func;
		
	output reg[31:2]	ID_PC;
	output reg[31:0]	ID_instruction;
	output reg[31:0]	pre_instruction;
	output reg		signal;
//assignment
	
	initial
	begin
		ID_PC = 30'b0;
		ID_instruction = 32'b0;
		pre_instruction = 32'b0;
		signal = 0;
	end
//initial assignment
		
	always@(negedge clk)
	begin
		if((op == 6'b000000 && func == 6'b001100) || (op == 6'b010000 && func == 6'b011000))
//syscall and ERET
		begin
			ID_instruction <= 32'b0;
			signal <= sign;
		end
		else if(!Load_use && !Jump && !Branch)
//normal instructions
		begin
			ID_PC <= IF_PC;
			ID_instruction <= instruction;
			signal <= sign;
		end
		else if(!Load_use && (Jump || Branch))
//jump and branch instructions with a delay slot 
		begin
			// ID_instruction <= instruction;			
			ID_instruction <= 32'b0;//this is for code without a delay slot
			pre_instruction <= instruction;
			signal <= sign;
		end
	end
endmodule
	
