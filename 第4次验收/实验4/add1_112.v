module add1_112(a, b, ci, s, co);

input a, b, ci;
output s, co;

assign s = ci ^ a ^ b;
assign co = (a ^ b) & ci | a & b;

endmodule