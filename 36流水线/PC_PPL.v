module PC_PPL(NPC,rst,clk,PC,
Load_use);
	input[31:2]	NPC;
	input		rst;
	input 		clk;
	input		Load_use;
	
	output[31:2]	PC;

	reg[31:2]	PC;
	initial
	begin
		PC = 0;
	end
	always @(negedge clk or posedge rst)
		begin
			if(rst == 1)
				PC<=0;
//initial assignment pc <= 13
			else if(!Load_use)
				PC<=NPC;
		end
endmodule