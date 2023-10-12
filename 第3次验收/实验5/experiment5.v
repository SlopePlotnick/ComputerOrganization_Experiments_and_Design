module test5(A, D, Y);

input A;
input [1:0] D;
output Y;

assign Y = (~(A) & D[0]) + (A & D[1]);

endmodule