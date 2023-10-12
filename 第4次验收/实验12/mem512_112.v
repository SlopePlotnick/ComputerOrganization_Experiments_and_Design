module mem512_112(clk, rst, wEn, addr, din, dout);

input clk, rst, wEn;
input[8:0] addr;
input[31:0] din;
output[31:0] dout;
reg[31:0] R[0:511];

integer i;

always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        for (i = 0; i < 512; i++)
        begin
            R[i] <= 0;
        end
    end
    else if (wEn) R[addr] <= din;
end

assign dout = R[addr];

endmodule