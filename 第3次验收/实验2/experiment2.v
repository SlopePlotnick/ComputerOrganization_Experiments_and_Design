module test2(A, B, Y1, Y2, Y3);
input A, B;
output Y1, Y2, Y3;

assign Y1 = (A & (~B));
assign Y2 = ~(A ^ B);
assign Y3 = ((~A) & B);

endmodule