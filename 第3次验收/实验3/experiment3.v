module test3(A, B, En, Z);

input A, B, En;
output [3:0] Z;

assign Z[0] = ~(~(A) & ~(B) & En);
assign Z[1] = ~(~(A) & B & En);
assign Z[2] = ~(A & ~(B) & En);
assign Z[3] = ~(A & B & En);

endmodule