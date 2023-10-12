module mux2(a, b, s, y);

input s;             //选择信号
input[31:0] a,b;     //两个数据输入
output reg[31:0] y;  //输出
    
always @(*)
begin
    y <= (s == 0) ? a : b;
end

endmodule