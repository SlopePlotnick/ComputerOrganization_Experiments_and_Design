module PC(NPC, clk, reset, PC);

input[31:2] NPC;
input clk,reset;
output[31:2] PC;

reg[31:2] PC;

initial
begin
	PC = 0;
end

always @(negedge clk or posedge reset)
begin
	if(reset)
		PC <= 0; //reset高电平时发生异步复位
	else
		PC <= NPC; //若复位信号无效 则在时钟下降沿将NPC赋值给PC
end

endmodule