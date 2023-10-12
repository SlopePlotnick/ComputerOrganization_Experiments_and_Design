module extForSUBctr_112(A, B);

input A;
output[31:0] B;

assign B = {{(31){A}}, A};

endmodule