module ALU(ALUctr, A, B, shamt, result, zero);

input[4:0] ALUctr;
input[31:0] A, B;
input[4:0] shamt;

output[31:0] result;
output zero;

reg[31:0] result;

assign zero = (result == 32'b0); //0标志位

always @(*)
begin
	case(ALUctr)
		5'b00000: result <= A + B;//addu
		5'b00001: result <= A - B;//subu
		5'b00010://slt
			//由于内置比较运算只能进行无符号比较运算 有符号比较需要另加判断
			begin
				if(A[31] ^ B[31]) //如果符号位不同 显然存在大小关系
					result <= (A[31] == 1) ? 1 : 0; //若A符号为负 则显然A < B
				else //如果符号位相同 可以用内置运算比较
					//是负数比较的结果与补码视为无符号比较的结果不冲突
					result <= (A < B) ? 1 : 0;
			end
		5'b00011: result <= A & B;//and
		5'b00100: result <= ~(A | B);//nor
		5'b00101: result <= A | B;//or
		5'b00110: result <= A ^ B;//xor
		5'b00111: result <= B << shamt;//sll 逻辑左移
		5'b01000: result <= B >> shamt;//srl 逻辑右移
		5'b01001: result <= (A < B) ? 1 : 0;//sltu 可直接使用内置运算
		//5'b01010:jalr
		//5'b01011:jr
		//以上两条指令在alu阶段没有运算操作 即使涉及运算操作也放在寄存器组中进行了
		5'b01100: result <= B << A;//sllv 逻辑左移 左移量由寄存器提供
		//以下两个操作中 signed函数用来对操作数进行符号扩位 >>>是算术右移运算符 这两个步骤都是为了保证算数右移的正确性
		5'b01101: result <= $signed(B) >>> shamt;//sra 算数右移
		5'b01110: result <= $signed(B) >>> A;//srav //算数右移 右移量由寄存器提供
		5'b01111: result <= B >> A;//srlv //逻辑右移 右移量由寄存器提供
		5'b10000: result <= A + B;//addiu sign extension 无符号立即数加法 符号扩展
		//slti操作中传入的B已经是经过符号扩展之后的了
		5'b10001://slti 立即数无符号比较 比较逻辑类似于前面的slt
			begin
				if(A[31] ^ B[31])
					result <= (A[31] == 1) ? 1 : 0;
				else
					result <= (A < B) ? 1 : 0;
			end
		5'b10010: result <= (A < B) ? 1 : 0;//sltiu 立即数无符号比较
		5'b10011: result <= A & B;//andi
		5'b10100: result <= A | B;//ori
		5'b10101: result <= A ^ B;//xori
	endcase
end

endmodule
