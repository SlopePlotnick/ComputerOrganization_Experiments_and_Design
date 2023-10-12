module dataMem_112(clk, din, wEn, addr, dout);

input clk, wEn;
input[31:0] addr;
input[31:0] din;
output[31:0] dout;
reg[31:0] R[0:1023];

always @(posedge clk)
begin
    if (wEn) R[addr] <= din;
end

assign dout = R[addr];

endmodule