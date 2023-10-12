module RegFile_PPL(op,PC,alure,rs,rt,rd,shamt,func,data,RegWr,RegDst,rs2,rt2,ra,rb,rs3,rt3,ra2,rb2,clk,reset);
	input[5:0]	op;
	input[31:2]	PC;
	input[31:0]	alure;
	input[4:0]	rs,rt,rd,shamt;
	input[5:0]	func;
	input[31:0]	data;
	input		RegWr;
	input		RegDst;
	input 		clk;
	input		reset;
	input[4:0]	rs2,rt2;
	input[4:0]	rs3,rt3;
	output[31:0]	ra,rb;
	output[31:0]	ra2,rb2;

	reg[31:0]	rgs[31:0];
	integer		i;
	always@(negedge clk or posedge reset)
		begin
			if(reset == 1)
			begin
				for(i = 0;i < 32;i = i + 1)
					rgs[i] <= 32'b0;
//initial assignment
			end
			if(RegWr)
				case(op)
					6'b100000:
						begin
							rgs[rt] <= data;
							/*if(alure[1:0] == 2'b00)		rgs[rt]<={{24{data[7]}},data[7:0]};
							if(alure[1:0] == 2'b01)		rgs[rt]<={{24{data[15]}},data[15:8]};
							if(alure[1:0] == 2'b10)		rgs[rt]<={{24{data[23]}},data[23:16]};					
							if(alure[1:0] == 2'b11)		rgs[rt]<={{24{data[31]}},data[31:24]};*/
						end
					6'b100100:
						begin
							rgs[rt] <= data;
							/*if(alure[1:0] == 2'b00)		rgs[rt]<={{24'b0},data[7:0]};
							if(alure[1:0] == 2'b01)		rgs[rt]<={{24'b0},data[15:8]};
							if(alure[1:0] == 2'b10)		rgs[rt]<={{24'b0},data[23:16]};					
							if(alure[1:0] == 2'b11)		rgs[rt]<={{24'b0},data[31:24]};*/
						end		
					6'b000011: rgs[31]<={(PC+30'd2),2'b00};//jal
					6'b001111: rgs[rt]<={rd,shamt,func,16'b0};//lui
					default:
						begin
							if(rt == 0 && rd == 5'b11111 && shamt == 0 && func == 6'b001001)
								rgs[31] <= {(PC+30'd2),2'b00};//jalr
							else if(RegDst == 1)	rgs[rd] <= data;
								
							else if(RegDst == 0)	rgs[rt] <= data;
						end 
				endcase
		end

	assign	ra = (rs2!=0)? rgs[rs2] : 0;
	assign	rb = (rt2!=0)? rgs[rt2] : 0;
	assign	ra2 = (rs3!=0)?rgs[rs3] : 0;
	assign	rb2 = (rt3!=0)?rgs[rt3] : 0;
// get data from register
endmodule