module mem1024_112(clk, rst, wEn, addr, din, dout);

input clk, rst, wEn;
input[9:0] addr;
input[7:0] din;
output[7:0] dout;
reg[7:0] R[0:1023];

integer i;

always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        for (i = 0; i < 1024; i++)
        begin
            R[i] <= 0;
        end
    end
    else if (wEn) R[addr] <= din;
end

assign dout = R[addr];

endmodule