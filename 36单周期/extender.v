module extender(imm16, Extop, Exout);

input[15:0]	imm16;
input[1:0]	Extop;
output[31:0] Exout;

reg[31:0]	Exout;

always @(*)
begin
	if(Extop == 2'b00) //0扩展
		Exout <= {16'b0, imm16};
	else if(Extop == 2'b01) //符号扩展
		Exout <= {{16{imm16[15]}}, imm16};
	else if(Extop == 2'b10) //用于lui指令的高位赋值 低位0扩展
		Exout <= {imm16, 16'b0};
end

endmodule
