`include"add1_112.v"
`include"add4_112.v"
`include"cla4_112.v"
`include"cla16_112.v"

//32位并行进位加法器顶层模块
module add32_112(A,B,c0,S,C32);
     input [32:1] A;
     input [32:1] B;
     input c0;
     output [32:1] S;
     output C32;

     wire px1,gx1,px2,gx2;
     wire c16;

  cla16_112 CLA1(
      .A(A[16:1]),
        .B(B[16:1]),
        .c0(c0),
        .S(S[16:1]),
        .px(px1),
        .gx(gx1)
    );

  cla16_112 CLA2(
        .A(A[32:17]),
          .B(B[32:17]),
          .c0(c16),
          .S(S[32:17]),
          .px(px2),
          .gx(gx2)
    );

  assign c16 = gx1 ^ (px1 && c0),
         C32 = gx2 ^ (px2 && c16);

endmodule