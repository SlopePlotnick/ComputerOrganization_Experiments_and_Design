module ctrl(op, func, RegDst, RegWr, ALUSrc, MemWr, MemtoReg, ExtOp, ALUctr, Branch, Jump);

input[5:0] 	op;
input[5:0]	func;
output		RegDst;
output		RegWr;
output		ALUSrc;
output		MemWr;
output		MemtoReg;
output[1:0]	ExtOp;
output[4:0]	ALUctr;
output		Branch;
output		Jump;		

reg[13:0]	controls;

assign {RegDst, RegWr, ALUSrc, MemWr, MemtoReg, ExtOp, ALUctr, Branch, Jump} = controls;

always @(*)
case(op)
	6'b000000:    //R
		begin
			case(func)
				6'b100001: controls <= 14'b11000000000000;//addu
				6'b100011: controls <= 14'b11000000000100;//subu
				6'b101010: controls <= 14'b11000000001000;//slt
				6'b100100: controls <= 14'b11000000001100;//and
				6'b100111: controls <= 14'b11000000010000;//nor
				6'b100101: controls <= 14'b11000000010100;//or
				6'b100110: controls <= 14'b11000000011000;//xor
				6'b000000: controls <= 14'b11000000011100;//sll
				6'b000010: controls <= 14'b11000000100000;//srl
				6'b101011: controls <= 14'b11000000100100;//sltu
				6'b001001: controls <= 14'b11000000000000;//jalr
				6'b001000: controls <= 14'b10000000000000;//jr
				6'b000100: controls <= 14'b11000000110000;//sllv
				6'b000011: controls <= 14'b11000000110100;//sra
				6'b000111: controls <= 14'b11000000111000;//srav
				6'b000110: controls <= 14'b11000000111100;//srlv
			endcase
		end
	6'b001001: controls <= 14'b01100011000000;//addiu
	6'b000100: controls <= 14'b00000000000110;//beq
	6'b000101: controls <= 14'b00000000000110;//bne
	6'b100011: controls <= 14'b01101011000000;//lw
	6'b101011: controls <= 14'b00110011000000;//sw
	6'b001111: controls <= 14'b01100100000000;//lui
	6'b001010: controls <= 14'b01100011000100;//slti
	6'b001011: controls <= 14'b01100011001000;//sltiu
	6'b000001: controls <= 14'b00000000000010;//bgez,bltz 
		
	6'b000111: controls <= 14'b00000000000010;//bgtz
	6'b000110: controls <= 14'b00000000000010;//blez
	6'b100000: controls <= 14'b01101011000000;//lb
	6'b100100: controls <= 14'b01101011000000;//lbu
	6'b101000: controls <= 14'b00110011000000;//sb
	6'b001100: controls <= 14'b01100001001100;//andi
	6'b001101: controls <= 14'b01100001010000;//ori
	6'b001110: controls <= 14'b01100001010100;//xori

	
	6'b000010: controls <= 14'b00000000000001;//j
	6'b000011: controls <= 14'b01000000000001;//jal

	default: controls <= 14'b00000000000000;
endcase
endmodule
