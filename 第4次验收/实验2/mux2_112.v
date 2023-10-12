module mux2_112 #(parameter WITDH = 8) (a, b, s, y);

input s;
input [WITDH - 1:0] a, b;
output [WITDH - 1:0] y;

assign y = (s == 0) ? a : b;

endmodule