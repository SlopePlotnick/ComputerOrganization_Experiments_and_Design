`include"getInstruction_112.v"
`include"regFile_112.v"
`include"ext_112.v"
`include"ALU_112.v"
`include"dataMem_112.v"
`include"add32_112.v"
`include"ALUctrProcess_112.v"
`include"extForSUBctr_112.v"
`include"mux3_112.v"
`include"mem_112.v"
`include"sext_112.v"

module dataPath_112(clk, RegWr, RegDst, ExtOp, ALUsrc, ALUctr, MemWr, MemtoReg, Branch, Jump, Instruction);

input clk, RegWr, RegDst, ExtOp, ALUsrc, MemWr, MemtoReg, Branch, Jump;
input[2:0] ALUctr;
output[31:0] Instruction;

wire Overflow, Zero;
wire[4:0] mux1_out;
wire[31:0] ALU_result;
wire[31:0] dataMem_out;
wire[31:0] busA, busB;
wire[4:0] Rs, Rt, Rd;
wire[31:0] ext_imm;
wire[31:0] mux2_out, mux3_out;

getInstruction_112 getInstruction
(
    .clk(clk), 
    .Zero(Zero), 
    .Branch(Branch), 
    .Jump(Jump), 
    .Instruction(Instruction)
);

assign Rs = Instruction[25:21];
assign Rt = Instruction[20:16];
assign Rd = Instruction[15:11];

mux2_112 #(.WITDH(5)) mux1
(
    .a(Rt),
    .b(Rd),
    .s(RegDst),
    .y(mux1_out)
);

regFile_112 regfile
(
    .clk(clk), 
    .wEn(RegWr & (~Overflow)), 
    .Ra(Rs), 
    .Rb(Rt), 
    .Rw(mux1_out), 
    .busA(busA), 
    .busB(busB), 
    .busW(mux3_out)
);

ext_112 ext
(
    .A(Instruction[15:0]), 
    .B(ext_imm), 
    .ExtOp(ExtOp)
);

mux2_112 #(.WITDH(32)) mux2
(
    .a(busB),
    .b(ext_imm),
    .s(ALUsrc),
    .y(mux2_out)
);

ALU_112 ALU
(
    .A(busA), 
    .B(mux2_out), 
    .ALUctr(ALUctr), 
    .Result(ALU_result), 
    .Zero(Zero),
    .Overflow(Overflow)
);

dataMem_112 dataMem
(
    .clk(clk), 
    .din(busB), 
    .wEn(MemWr), 
    .addr(ALU_result),
    .dout(dataMem_out)
);

mux2_112 #(.WITDH(32)) mux3
(
    .a(ALU_result),
    .b(dataMem_out),
    .s(MemtoReg),
    .y(mux3_out)
);

// always @(posedge clk)
// begin
// $display("Instruction = %h", Instruction);
// $display("Branch = %b", Branch);
// $display("Jump = %b", Jump);
// $display("RegDst = %b", RegDst);
// $display("ALUsrc = %b", ALUsrc);
// $display("MemtoReg = %b", MemtoReg);
// $display("RegWr = %b", RegWr);
// $display("MemWr = %b", MemWr);
// $display("ExtOp = %b", ExtOp);
// $display("ALUctr = %b", ALUctr);
// $display("mux3_out = %d", mux3_out);
// end

endmodule