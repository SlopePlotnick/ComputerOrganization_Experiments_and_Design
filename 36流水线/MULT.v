module MULT(op,busA,busB,rd,shamt,func,result);
// this is for MULT 32*32 multiplication
	input[5:0]	op;
	input[31:0]	busA,busB;
	input[4:0]	rd,shamt;
	input[5:0]	func;

	output reg[63:0]	result;
	integer		i;
	reg[63:0]	count[31:0];
	reg[31:0]	sign;
	
	initial
	begin
		for(i = 0;i<32;i = i+1)
			count[i] = 0;
		sign = 0;
		result = 0;
	end
//Multiply by bit
	always@(*)
	begin
		if(op == 6'b000000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011000)
		begin
			count[0] = busB[0]?{{32{busA[31]}},busA} : 64'b0;
			count[1] = busB[1]?{{31{busA[31]}},busA,1'b0} : 64'b0;
			count[2] = busB[2]?{{30{busA[31]}},busA,2'b0} : 64'b0;
			count[3] = busB[3]?{{29{busA[31]}},busA,3'b0} : 64'b0;
			count[4] = busB[4]?{{28{busA[31]}},busA,4'b0} : 64'b0;
			count[5] = busB[5]?{{27{busA[31]}},busA,5'b0} : 64'b0;
			count[6] = busB[6]?{{26{busA[31]}},busA,6'b0} : 64'b0;
			count[7] = busB[7]?{{25{busA[31]}},busA,7'b0} : 64'b0;
			count[8] = busB[8]?{{24{busA[31]}},busA,8'b0} : 64'b0;
			count[9] = busB[9]?{{23{busA[31]}},busA,9'b0} : 64'b0;
			count[10] = busB[10]?{{22{busA[31]}},busA,10'b0} : 64'b0;
			count[11] = busB[11]?{{21{busA[31]}},busA,11'b0} : 64'b0;
			count[12] = busB[12]?{{20{busA[31]}},busA,12'b0} : 64'b0;
			count[13] = busB[13]?{{19{busA[31]}},busA,13'b0} : 64'b0;
			count[14] = busB[14]?{{18{busA[31]}},busA,14'b0} : 64'b0;
			count[15] = busB[15]?{{17{busA[31]}},busA,15'b0} : 64'b0;
			count[16] = busB[16]?{{16{busA[31]}},busA,16'b0} : 64'b0;
			count[17] = busB[17]?{{15{busA[31]}},busA,17'b0} : 64'b0;
			count[18] = busB[18]?{{14{busA[31]}},busA,18'b0} : 64'b0;
			count[19] = busB[19]?{{13{busA[31]}},busA,19'b0} : 64'b0;
			count[20] = busB[20]?{{12{busA[31]}},busA,20'b0} : 64'b0;
			count[21] = busB[21]?{{11{busA[31]}},busA,21'b0} : 64'b0;
			count[22] = busB[22]?{{10{busA[31]}},busA,22'b0} : 64'b0;
			count[23] = busB[23]?{{9{busA[31]}},busA,23'b0} : 64'b0;
			count[24] = busB[24]?{{8{busA[31]}},busA,24'b0} : 64'b0;
			count[25] = busB[25]?{{7{busA[31]}},busA,25'b0} : 64'b0;
			count[26] = busB[26]?{{6{busA[31]}},busA,26'b0} : 64'b0;
			count[27] = busB[27]?{{5{busA[31]}},busA,27'b0} : 64'b0;
			count[28] = busB[28]?{{4{busA[31]}},busA,28'b0} : 64'b0;
			count[29] = busB[29]?{{3{busA[31]}},busA,29'b0} : 64'b0;
			count[30] = busB[30]?{{2{busA[31]}},busA,30'b0} : 64'b0;
			
			sign = ~busA + 1'b1;
			count[31] = busB[31]?{{1{sign[31]}},sign,31'b0} : 64'b0;

			result = 0;
			for(i = 0;i<32;i= i+1)
			begin
				result = result + count[i];
			end
		end
	end

endmodule
