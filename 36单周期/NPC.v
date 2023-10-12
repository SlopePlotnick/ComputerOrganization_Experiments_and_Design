module NPC(PC, zero, branch, op, imm16, target, jump, NPC, busA, rs, rt, rd, shamt, func);

input[31:2] PC;
input zero, branch, jump;
input[5:0] op, func;
input[15:0] imm16;
input[25:0] target;
input[31:0] busA;
input[4:0]	rs, rt, rd, shamt;
output[31:2] NPC;

reg[31:2] NPC;
wire[31:2] B_NPC = {{14{imm16[15]}}, imm16[15:0]} + PC; //条件跳转 将立即数进行符号扩展后与PC相加
wire[31:2] J_NPC = {PC[31:28], target}; //无条件跳转 target和PC组合成跳转指令
wire[31:2] N_NPC = PC + 1; //不发生跳转时正常的下一条指令

initial
begin
	NPC = 0;
end

always @(*)
begin
//根据op的不同来执行不同的操作
case(op)
	6'b000100: NPC = (zero == 1 && branch == 1) ? B_NPC : N_NPC;//beq
	6'b000101: NPC = (zero == 0 && branch == 1) ? B_NPC : N_NPC;//bne
	6'b000001: 
	//注意这里的bgez和bltz都是有符号比较 可以通过符号位来判断与0的大小关系
		begin
			if(rt == 1 && branch == 1 && (busA == 0 || busA[31] == 0))//bgez
				NPC = B_NPC;
			else if(rt == 0 && branch == 1 && busA[31] == 1 && busA != 0)//bltz 此处还要保证busA不为0是要排除-0的情况
				NPC = B_NPC;
			else	
				NPC = N_NPC;
		end
	6'b000111: NPC = (branch == 1 && busA[31] == 0 && busA != 0) ? B_NPC : N_NPC;//bgtz
	6'b000110: NPC = (branch == 1 && (busA[31] == 1 || busA == 0)) ? B_NPC : N_NPC;//blez 
	6'b000010: NPC = (jump == 1) ? J_NPC : N_NPC;//j 
	6'b000011: NPC = (jump == 1) ? J_NPC : N_NPC;//jal 该指令额外的操作并不在NPC中进行
	6'b000000: 
		begin
			if(rt == 0 && imm16 == 16'b1111100000001001)	
				NPC = busA[31:2];//jalr 同理 额外操作不在NPC中进行
			else if(rt == 0 && imm16 == 16'b0000000000001000)	
				NPC = busA[31:2];//jr
			else	
				NPC = N_NPC; 
		end
	default: NPC = N_NPC;
endcase
end

endmodule