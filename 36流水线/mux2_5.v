module mux2_5(a,b,s,y);
//choose data by 's' 
	input[4:0]	a,b;
	input		s;
	output[4:0]	y;
//5-bit binary number
	
	reg[4:0]	y;
//reg-type output
	always@(*)
		if(s == 0)
			y <= a;
		else if(s == 1)
			y <= b;
endmodule
