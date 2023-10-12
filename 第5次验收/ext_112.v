module ext_112(A, B, ExtOp);

input[15:0] A;
input ExtOp;
output[31:0] B;

assign B[31:16] = (ExtOp == 0) ? (16'd0) : ({(16){A[15]}});
assign B[15:0] = A;

endmodule