module regfile_112(clk, reset, wEn, addr, din, dout);

input clk, reset, wEn;
input addr;
input[7:0] din;
output[7:0] dout;

reg[7:0] R[0:3];

assign dout = R[addr];

always @(posedge clk or negedge reset)
begin
  if (!reset)
  begin
    R[0] <= 0;
    R[1] <= 0;
    R[2] <= 0;
    R[3] <= 0;
  end
  else if (wEn) R[addr] <= din;
end

endmodule