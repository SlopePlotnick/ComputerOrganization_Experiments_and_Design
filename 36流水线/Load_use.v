module Load_use(EX_MemRead,EX_rt,ID_rs,ID_rt,Load_use);
//Load_use hazard judge
	input	EX_MemRead;
	input[4:0]	EX_rt,ID_rs,ID_rt;
	output reg	Load_use;
	wire	C;
	
	assign	C = EX_MemRead && ((EX_rt == ID_rs) || (EX_rt == ID_rt));

	initial
	begin
		Load_use = 0;
	end

	always@(C)
	begin
		Load_use = C;
	end

endmodule
