module test7(A, B);

input [15:0] A;
output [31:0] B;

assign B[31:16] = 16'h0000;
assign B[15:0] = A;

endmodule