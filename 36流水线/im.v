module im_4k(addr,dout);
	input[11:2]	addr;
	output[31:0]	dout;

	reg[31:0]	im[1023:0];
	integer		i;
	initial
		begin
			$readmemh("code.txt",im);
		end
//read data in code1.txt
	assign	dout = im[addr];
endmodule	