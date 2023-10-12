module im_4k(addr, dout);

input[31:2]	addr; //这里只采用[11:2]位可以避免处理PC初始地址0000_3000和im中存储第一条指令的地址0000_0000不匹配的问题
output[31:0] dout;

reg[31:0] im[1023:0];

initial
begin
    $readmemh("code.txt", im);
end

assign	dout = im[addr]; //设计成了组合逻辑电路 而非时序

endmodule
