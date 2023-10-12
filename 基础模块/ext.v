module test8(A, B);

input [15:0] A;
output [31:0] B;

assign B = {{(16){A[15]}}, A};

endmodule