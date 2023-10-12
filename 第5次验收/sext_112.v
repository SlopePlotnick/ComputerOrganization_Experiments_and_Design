module sext_112(A, B);

input [15:0] A;
output [31:0] B;

assign B[31:2] = {{(14){A[15]}}, A};
assign B[1:0] = 2'b00;

endmodule