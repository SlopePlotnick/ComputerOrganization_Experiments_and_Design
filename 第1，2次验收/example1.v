module test1(Z, A, B, Enable);
output [3:0] Z;
input A, B, Enable;
assign Z[0] = ~((Enable) & (~A) & (~B));
assign Z[1] = ~((~A) & B & (Enable));
assign Z[2] = ~((~B) & A & (Enable));
assign Z[3] = ~((Enable) & A & B);

endmodule