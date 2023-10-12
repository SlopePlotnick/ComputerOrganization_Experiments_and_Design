module RegFile(op, PC, rs, rt, rd, shamt, func, data, RegWr, RegDst, ra, rb, clk, reset);

input[5:0]	 op;
input[31:2]	PC;
input[4:0]	rs,rt,rd,shamt;
input[5:0]	func;
input[31:0]	data;
input		RegWr;
input		RegDst;
input 		clk;	
input		reset;
output[31:0]	ra,rb;

reg[31:0]	rgs[31:0];
integer		i;

always @(negedge clk or posedge reset)
begin
	if(reset) //复位 所有寄存器初始化为0
	begin
		for(i = 0; i < 32; i = i + 1)
			rgs[i] <= 32'b0;
	end

	if(RegWr)
	begin
		case(op)
			6'b100000: //lb 装载字节 作符号扩展 此处alure是计算出的内存取值地址 根据除4的余数关系确定装载的字节是4个字节中的哪一个字
				begin
					rgs[rt] <= {{24{data[7]}}, data[7:0]};
				end
			6'b100100: //lbu 装载字节 作0扩展 此处alure是计算出的内存取值地址 根据与4的倍数关系确定装载的字节是4个字节中的哪一个字
				begin
					rgs[rt] <= {{24'b0}, data[7:0]};
				end		
			6'b000011: rgs[31] <= {(PC+30'd1), 2'b00}; //jal 在跳转同时还要将PC + 4并赋值给31号寄存器
			6'b001111: rgs[rt] <= {rd, shamt, func, 16'b0}; //lui 将立即数载入高位 末尾进行0扩展 这里的{rd, shamt, func}实际上是拼凑出了I型指令中的imm
			default:
				begin
					//jalr指令无法通过op判断 所以在这里另加判断
					if(rt == 0 && rd == 5'b11111 && shamt == 0 && func == 6'b001001)
						rgs[31] <= {(PC + 30'd1),2'b00}; //jalr 在跳转同时还要将PC + 4并赋值给31号寄存器
					//这里的操作可以省掉一个mux
					else if(RegDst == 1)	rgs[rd] <= data;
					else if(RegDst == 0)	rgs[rt] <= data;
				end 
		endcase
	end
end

//1. 这里的操作是为了保证0号寄存器的值始终为0
//2. 当输入地址的值为0时 输出的值永远是0 而不是寄存器中的值
//3. 此处设计的是组合逻辑电路
assign ra = (rs != 0) ? rgs[rs] : 0;
assign rb = (rt != 0) ? rgs[rt] : 0;

endmodule
