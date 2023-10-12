module regFile_112(clk, wEn, Ra, Rb, Rw, busA, busB, busW);

input clk, wEn;
input[4:0] Ra, Rb, Rw;
input[31:0] busW;
output[31:0] busA, busB;

reg[31:0] R[0:31];

assign dout = R[addr];

always @(posedge clk)
begin
    if (wEn) R[addr] <= busW;
end

endmodule