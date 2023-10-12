`include"dataPath_112.v"
`include"control_112.v"
`include"mux2_112.v"

module singleCPU_112(clk);

input clk;
wire RegWr, RegDst, ExtOp, ALUsrc, MemWr, MemtoReg, Branch, Jump;
wire[2:0] ALUctr;
wire[31:0] Instruction;

dataPath_112 dataPath
(
    .clk(clk), 
    .RegWr(RegWr), 
    .RegDst(RegDst), 
    .ExtOp(ExtOp), 
    .ALUsrc(ALUsrc), 
    .ALUctr(ALUctr), 
    .MemWr(MemWr), 
    .MemtoReg(MemtoReg), 
    .Branch(Branch), 
    .Jump(Jump), 
    .Instruction(Instruction)
);

control_112 control
(
    .op(Instruction[31:26]), 
    .func(Instruction[5:0]), 
    .Branch(Branch), 
    .Jump(Jump), 
    .RegDst(RegDst), 
    .ALUsrc(ALUsrc), 
    .ALUctr(ALUctr), 
    .MemtoReg(MemtoReg), 
    .RegWr(RegWr), 
    .MemWr(MemWr), 
    .ExtOp(ExtOp)
);

endmodule