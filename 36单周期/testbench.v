`include"mips.v"

module union_ts();

reg clk;
reg rst;

integer i;
integer clk_num = 1;
integer out;

mips MIPS(clk,rst);

initial
begin
	$dumpfile("single_cpu_wave.vcd");
	$dumpvars(0, union_ts);
end

initial
begin
	forever #5 clk=~clk;
end

initial
begin
	clk <= 1;
	rst <= 0;
	#5 rst <= 1;
	#5 rst <= 0;
	//上面四行是在一个周期内进行初始化和复位 接下来才是正式开始跑CPU

	#490 $finish;
end

always @(posedge clk)
begin
	out = $fopen("out.txt", "a+");

	$fdisplay(out, "clock [%d pos]", clk_num);
	clk_num = clk_num + 1;
	$fdisplay(out, "instruction = %h", MIPS.DPU.instruction);
	$fdisplay(out, "PC = %h", {MIPS.DPU.PC, 2'b00});
	$fdisplay(out, "Registers:");
	for (i = 0; i < 32; i = i + 1)
	begin
		$fdisplay(out, "R[%d] = %h", i, MIPS.DPU.RM.rgs[i]);
	end
	$fdisplay(out, "DataMem:");
	$fdisplay(out, "DM[0000_0014H] = %h", {MIPS.DPU.DMM.dm[32'd20 + 3], MIPS.DPU.DMM.dm[32'd20 + 2], MIPS.DPU.DMM.dm[32'd20 + 1], MIPS.DPU.DMM.dm[32'd20]});
	$fdisplay(out, "DM[0000_0015H] = %h", {MIPS.DPU.DMM.dm[32'd21 + 3], MIPS.DPU.DMM.dm[32'd21 + 2], MIPS.DPU.DMM.dm[32'd21 + 1], MIPS.DPU.DMM.dm[32'd21]});
	$fdisplay(out, "DM[0000_001CH] = %h", {MIPS.DPU.DMM.dm[32'd28 + 3], MIPS.DPU.DMM.dm[32'd28 + 2], MIPS.DPU.DMM.dm[32'd28 + 1], MIPS.DPU.DMM.dm[32'd28]});
	$fdisplay(out, "-------------------------------");

	$fclose(out);
end


endmodule
