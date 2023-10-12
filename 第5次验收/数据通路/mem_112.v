module mem_112(addr, dout);
    input[31:0] addr;
    output[31:0] dout;

	reg[7:0] mem[0:1023];

	initial 
	begin
        //注意这里采用的是读二进制的指令 要根据后续的需求进行修改
		$readmemb("inst.tv", mem);
	end

    assign dout = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3]};
endmodule