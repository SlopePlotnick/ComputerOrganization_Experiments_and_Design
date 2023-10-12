`include"datapath_PPL.v"

module union_ts();

reg clk;
reg rst;

integer i;
integer clk_num = 1;
integer out;

datapath_PPL PPL(clk,rst);

initial
begin
	$dumpfile("pipeline_cpu_wave.vcd");
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
	#1 rst <= 1;
	#1 rst <= 0;
	//上面四行是在一个周期内进行初始化和复位 接下来才是正式开始跑CPU

	#650 $finish;
end

always @(posedge clk)
begin
	out = $fopen("out.txt", "a+");

	$fdisplay(out, "clock [%d pos]", clk_num);
	clk_num = clk_num + 1;
	$fdisplay(out, "instruction = %h", PPL.instruction);
	$fdisplay(out, "ID_instruction = %h", PPL.ID_instruction);
	$fdisplay(out, "PC = %h", {PPL.PC, 2'b00});
	$fdisplay(out, "IF_PC = %h", {PPL.IF_PC, 2'b00});
	$fdisplay(out, "ID_PC = %h", {PPL.ID_PC, 2'b00});
	$fdisplay(out, "EX_PC = %h", {PPL.EX_PC, 2'b00});
	$fdisplay(out, "Mem_PC = %h", {PPL.Mem_PC, 2'b00});
	$fdisplay(out, "Wr_PC = %h", {PPL.Wr_PC, 2'b00});
	$fdisplay(out, "Registers:");
	for (i = 0; i < 32; i = i + 1)
	begin
		$fdisplay(out, "R[%d] = %h", i, PPL.IDPP.REGPPL.rgs[i]);
	end
	$fdisplay(out, "DataMem:");
	$fdisplay(out, "DM[0000_0014H] = %h", {PPL.MEMPP.dmT.dm[32'd20 + 3], PPL.MEMPP.dmT.dm[32'd20 + 2], PPL.MEMPP.dmT.dm[32'd20 + 1], PPL.MEMPP.dmT.dm[32'd20]});
	$fdisplay(out, "DM[0000_0015H] = %h", {PPL.MEMPP.dmT.dm[32'd21 + 3], PPL.MEMPP.dmT.dm[32'd21 + 2], PPL.MEMPP.dmT.dm[32'd21 + 1], PPL.MEMPP.dmT.dm[32'd21]});
	$fdisplay(out, "DM[0000_001CH] = %h", {PPL.MEMPP.dmT.dm[32'd28 + 3], PPL.MEMPP.dmT.dm[32'd28 + 2], PPL.MEMPP.dmT.dm[32'd28 + 1], PPL.MEMPP.dmT.dm[32'd28]});
	$fdisplay(out, "-------------------------------");

	$fclose(out);
end


endmodule
