module NPC(PC,NPC,jump,branch,zero,op,target,imm16,busA,rs,rt,rd,shamt,func,
sign,CPR14);
	input[31:2]	PC;
	output[31:2]	NPC;
	input		jump,branch,zero;
	input[5:0]	op;
	input[25:0]	target;
	input[15:0]	imm16;
	input[31:0]	busA;
	input[4:0]	rs,rt,rd,shamt;
	input[5:0]	func;
	input[31:0]	CPR14;

	output reg	sign;

	reg[31:2]	NPC;
	wire[31:2]	B_NPC = {{14{imm16[15]}},imm16[15:0]} + PC - 1; //要减1是因为译码完成传入时已经到了跳转指令的ID段 PC已经 + 1了？
//NPC with branch instructions

	wire[31:2]	J_NPC = {PC[31:28],target};
//NPC with jump instructions

	wire[31:2]	N_NPC = PC + 1;
//normal NPC

	reg[31:2]	EXC_ENTER_ADDR;
//jump address of ERET isntruction

	initial
	begin
			NPC = 0;
			sign = 0;
			EXC_ENTER_ADDR = 0;
	end
//initial assignment

	always @(*)
		begin
			case(op)
				6'b000100: //beq
					begin 
						if(zero==1 && branch==1)//jump when two inputs equal
						begin
							NPC <= B_NPC;
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000101: //bne
					begin
						if(zero==0 && branch==1)//jump when two inputs not equal
						begin
							NPC <= B_NPC;
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
			 	6'b000001: 
					begin
						if(rt == 1 && branch == 1&& (busA == 0||busA[31] == 0))//bgez - jump when busA >= 0
						begin
							NPC <= B_NPC;
							sign <= 0;
						end
					   	else if(rt == 0 && branch == 1 && busA[31] == 1 && busA != 0)//bltz - jump when busA < 0
						begin
							NPC <= B_NPC;
							sign <= 0;
						end
						else	
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000111: //bgtz - jump when busA > 0
					begin
						if(branch == 1 && busA[31] == 0 && busA != 0)
						begin
							NPC <= B_NPC;
							sign <= 0;		
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000110: //blez - jump when busA <= 0
					begin
						if(branch == 0 && (busA[31] == 1||busA == 0))
						begin
							NPC <= B_NPC;
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000010: //j
					begin
						if(jump == 1)
						begin
							NPC <= J_NPC;
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000011: //jal 
					begin
						if(jump == 1)
						begin
							NPC <= J_NPC;
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 1;
						end
					end
				6'b000000: 
					begin
					  	if(rt == 0 && imm16 == 16'b1111100000001001)	
						begin
							NPC <= busA[31:2];//jalr
							sign <= 0;
						end
					  	else if(rt == 0 && imm16 == 16'b0000000000001000)	
						begin
							NPC <= busA[31:2];//jr
							sign <= 0;
						end
						else if(func == 6'b001100)
						begin
							NPC <= EXC_ENTER_ADDR;//ERET
							sign <= 0;
						end
						else	
						begin
							NPC <= N_NPC;
							sign <= 0;
						end
					end
				6'b010000:
					begin
						if(func == 6'b011000)//syscall
						begin
							NPC <= CPR14[31:2];
							sign <= 0;
						end
						else
						begin
							NPC <= N_NPC;
							sign <= 0;
						end
					end
				default: //normal instructions
					begin
						NPC <= N_NPC;
						sign <= 0;
					end
			endcase
		end
endmodule
