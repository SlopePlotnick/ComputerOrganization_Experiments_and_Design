`include"centerControl_112.v"
`include"ALUControl_112.v"

module control_112(op, func, Branch, Jump, RegDst, ALUsrc, ALUctr, MemtoReg, RegWr, MemWr, ExtOp);

input[5:0] op;
input[5:0] func;
output[2:0] ALUctr;
output Branch, Jump, RegDst, ALUsrc, MemtoReg, RegWr, MemWr, ExtOp;

wire[2:0] ALUop, ALUctrF;
wire R_type;

centerControl_112 centerControl
(
    .op(op), 
    .RegDst(RegDst), 
    .ALUsrc(ALUsrc), 
    .MemtoReg(MemtoReg), 
    .RegWr(RegWr), 
    .MemWr(MemWr), 
    .Branch(Branch), 
    .Jump(Jump), 
    .ExtOp(ExtOp), 
    .ALUop(ALUop), 
    .R_type(R_type)
);

ALUControl_112 ALUControl
(
    .func(func), 
    .ALUctrF(ALUctrF)
);

mux2_112 #(.WITDH(3)) mux
(
    .a(ALUop),
    .b(ALUctrF),
    .s(R_type),
    .y(ALUctr)
);

// always @(op or func)
// begin
// $display("op = %b", op);
// $display("func = %b", func);
// #1;
// $display("Branch = %b", Branch);
// $display("Jump = %b", Jump);
// $display("RegDst = %b", RegDst);
// $display("ALUsrc = %b", ALUsrc);
// $display("MemtoReg = %b", MemtoReg);
// $display("RegWr = %b", RegWr);
// $display("MemWr = %b", MemWr);
// $display("ExtOp = %b", ExtOp);
// $display("ALUctr = %b", ALUctr);
// end

endmodule