//32位并行进位加法器顶层模块
module add32_112(A, B, c0, S, C32, Add_Carry, Zero, Add_Overflow, Add_Sign);
     input [31:0] A;
     input [31:0] B;
     input c0;
     output [31:0] S;
     output C32, Add_Carry, Zero, Add_Overflow, Add_Sign;

  assign {C32, S} = A + B + (c0 === 1),
         Add_Carry = c0 ^ C32,
         Zero = (S == 0),
         Add_Overflow = (A[31] & B[31] & ~S[31]) + (~A[31] & ~B[31] & S[31]),
         Add_Sign = S[31]; 

// always @(A or B or c0)
// begin
//    #1;
//    $display("A = %b", A);
//    $display("B = %b", B);
//    $display("c0 = %b", (c0 === 1));
//    $display("S = %b", S);
// end

endmodule