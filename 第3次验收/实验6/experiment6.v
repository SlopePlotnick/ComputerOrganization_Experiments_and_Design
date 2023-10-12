module test6(A, B, D, Y);

input A, B;
input [2:0] D;
output reg Y;

always @(*) 
begin
    if (B == 1'b1) Y = D[2];
    else Y = (~(A) & D[0]) + (A & D[1]);
end

endmodule