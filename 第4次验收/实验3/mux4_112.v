module mux4_112 #(parameter WITDH = 8) (d0, d1, d2, d3, s1, s2, y);

input s1, s2;
input [WITDH - 1:0] d0, d1, d2, d3;
output [WITDH - 1:0] y;

assign y = (~s1 & ~s2 & d0) + (~s1 & s2 & d1) + (s1 & ~s2 & d2) + (s1 & s2 & d3);

endmodule