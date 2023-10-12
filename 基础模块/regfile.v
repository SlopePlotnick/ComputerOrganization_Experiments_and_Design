module regfile(clk, wEn, addr, wd, rd);

input clk, wEn;
input [1:0] addr;
input [7:0] wd;
output [7:0] rd;
reg [7:0] regfile[0:4];

assign rd = regfile[addr];
always @ (posedge clk)
    if (wEn) regfile[addr] <= wd;


endmodule