module alu(ALUctr,A,B,immedia,shamt,result,zero,G,H,K);
	input[4:0]	ALUctr;
	input[31:0]	A,B,G,H,K;
	input[31:0]	immedia;
	input[4:0]	shamt;
	output[31:0]	result;
	output		zero;

	reg[31:0]	result;
	assign		zero = (result == 32'b0);
	integer		i;

	always @(*)
		begin
			case(ALUctr)
				5'b00000:result <= A + B;//addu
				5'b00001:result <= A - B;//subu
				5'b00010://slt
					begin
						if(A[31] ^ B[31])	result <= (A[31]==1)?1:0;
						else	result <= (A<B)?1:0;
					end
				5'b00011:result <= A & B;//and
				5'b00100:result <= ~(A | B);//nor
				5'b00101:result <= A | B;//or
				5'b00110:result <= A ^ B;//xor
				5'b00111:result <= B << shamt;//sll
				5'b01000:result <= B >> shamt;//srl
				5'b01001:result <= (A<B)?1:0;//sltu
				//5'b01010:jalr
				//5'b01011:jr
				5'b01100:result <= B << A;//sllv
				5'b01101:result <= $signed(B) >>> shamt;//sra 
				5'b01110:result <= $signed(B) >>> A;//srav
				5'b01111:result <= B >> A;//srlv
				5'b10000:result <= A + immedia;//addiu sign extension
				5'b10001://slti sign extension
					begin
						if(A[31] ^ immedia[31])	result <= (A[31]==1)?1:0;	
						else	result <= (A<immedia)?1:0;
					end
				5'b10010:result <= (A<immedia)?1:0;//sltiu,sign extension
				5'b10011:result <= A & immedia;//andi
				5'b10100:result <= A | immedia;//ori
				5'b10101:result <= A ^ immedia;//xori
				5'b10110:result <= immedia;//lui
				5'b10111:result <= G;//mflo
				5'b11000:result <= H;//mfhi
				5'b11001:result <= K;//mfc0
			endcase
		end
endmodule