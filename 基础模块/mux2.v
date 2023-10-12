//注意根据实际的使用需求更改此处的WIDTH常数
//在例化时修改的语法为 mux2 #(.WITDH(1)) dut(a, b, s, y);
module mux2 #(parameter WITDH = 8) (a, b, s, y);

input s;
input [WITDH - 1:0] a, b;
output [WITDH - 1:0] y;

assign y = (s == 0) ? a : b;

endmodule