//给出的这个代码在检测到一次0111序列后就会失灵 不太完善 有机会要修改一下
module fsm_112(clk, in, out);

input clk, in;
output out;
reg[1:0] state;
parameter s0 = 2'b00, 
s1 = 2'b01, 
s2 = 2'b10, 
s3 = 2'b11;

assign out = (state == s3);
initial state = s0;
always @(posedge clk) 
begin
    if (in == 0) state <= s0;
    else state <= state + 1;
end

endmodule