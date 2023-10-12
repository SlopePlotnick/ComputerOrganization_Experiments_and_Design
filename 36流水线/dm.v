module dm_4k(op, addr, din, dout, clk, we);

input[5:0]	op;
input[31:0]	addr;
input[31:0]	din;
input		clk;
input		we;
output[31:0]	dout;

reg[7:0] dm[4095:0]; //采取以字节位单位存储数据才是最合理的

integer i;

always @(negedge clk)
begin
if(we)
begin
    if(op == 6'b101000)   //sb
        dm[addr] <= din[7:0];
    else {dm[addr + 3], dm[addr + 2], dm[addr + 1], dm[addr]} <= din;
end
end

assign dout = {dm[addr + 3], dm[addr + 2], dm[addr + 1], dm[addr]};

endmodule
