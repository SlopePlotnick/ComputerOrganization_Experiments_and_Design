module extender(immedia,exop,exout);
	input[15:0]	immedia;
	input[1:0]	exop;
	output[31:0]	exout;
	reg[31:0]	exout;

	always@(*)
		if(exop == 2'b00)
			exout <= {16'b0,immedia};//zero extender
		else if(exop == 2'b01)
			exout <= {{16{immedia[15]}},immedia};//sign extender
		else if(exop == 2'b10)
			exout <= {immedia,16'b0};//lui extender
endmodule
