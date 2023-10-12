module ALU_112(A, B, ALUctr, Result, Zero, Overflow);

input[31:0] A, B;
input[2:0] ALUctr;
output[31:0] Result;
output Zero, Overflow;

wire SUBctr, OVctr, SIGctr, Add_Carry, Add_Overflow, Add_Sign;
wire[31:0] Add_Result;
wire[1:0] OPctr;
wire[31:0] SUBctr_ext;
wire mux1_out;
wire[31:0] mux3_2;

// always @(A or B or ALUctr)
// begin
//     #1; $display("A = %b", A);
//     $display("B = %b", B);
//     $display("ALUctr = %b", ALUctr);
//     $display("Add_Reuslt = %b", Add_Result);
// end

ALUctrProcess_112 ALUctrProcess
(
    .ALUctr(ALUctr),
    .SUBctr(SUBctr),
    .OVctr(OVctr),
    .SIGctr(SIGctr),
    .OPctr(OPctr)
);

extForSUBctr_112 extForSUBctr
(
    .A(SUBctr),
    .B(SUBctr_ext)
);

add32_112 add32
(
    .A(A),
    .B(B ^ SUBctr_ext),
    .c0(SUBctr),
    .S(Add_Result),
    .C32(),
    .Add_Carry(Add_Carry),
    .Zero(Zero),
    .Add_Overflow(Add_Overflow),
    .Add_Sign(Add_Sign)
);

mux2_112 #(.WITDH(1)) mux1
(
    .a(SUBctr ^ Add_Carry),
    .b(Add_Overflow ^ Add_Sign),
    .s(SIGctr),
    .y(mux1_out)
);

mux2_112 #(.WITDH(32)) mux2
(
    .a(32'h00000000),
    .b(32'hffffffff),
    .s(mux1_out),
    .y(mux3_2)
);

mux3_112 mux3
(
    .D0(Add_Result),
    .D1(A | B),
    .D2(mux3_2),
    .s(OPctr),
    .y(Result)
);

assign Overflow = Add_Overflow & OVctr;

endmodule