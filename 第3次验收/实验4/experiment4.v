module test4(op, RegDst, ALUSrc, MemtoReg, RegWr, MemWr, Branch, Jump, ExtOp, ALUop, R_type);

input [5:0] op;
output RegDst, ALUSrc, MemtoReg, RegWr, MemWr, Branch, Jump, ExtOp, R_type;
output [2:0] ALUop;

assign RegDst = (!op[5] & !op[4] & !op[3] & !op[2] & !op[1] & !op[0]);
assign ALUSrc = (!op[5] & !op[4] & op[3] & op[2] & !op[1] & op[0])
                + (op[5] & !op[4] & !op[3] & !op[2] & op[1] & op[0])
                + (op[5] & !op[4] & op[3] & !op[2] & op[1] & op[0]);
assign MemtoReg = (op[5] & !op[4] & !op[3] & !op[2] & op[1] & op[0]);
assign RegWr = (!op[5] & !op[4] & !op[3] & !op[2] & !op[1] & !op[0])
                + (!op[5] & !op[4] & op[3] & op[2] & !op[1] & op[0])
                + (op[5] & !op[4] & !op[3] & !op[2] & op[1] & op[0]);
assign MemWr = (op[5] & !op[4] & op[3] & !op[2] & op[1] & op[0]);
assign Branch = (!op[5] & !op[4] & !op[3] & op[2] & !op[1] & !op[0]);
assign Jump = (!op[5] & !op[4] & !op[3] & !op[2] & op[1] & !op[0]);
assign ExtOp = (op[5] & !op[4] & !op[3] & !op[2] & op[1] & op[0])
            + (op[5] & !op[4] & op[3] & !op[2] & op[1] & op[0]);
assign ALUop[2] = (!op[5] & !op[4] & !op[3] & op[2] & !op[1] & !op[0]);
assign ALUop[1] = (!op[5] & !op[4] & op[3] & op[2] & !op[1] & op[0]);
assign ALUop[0] = (!op[5] & !op[4] & !op[3] & !op[2] & !op[1] & !op[0]);
assign R_type = (!op[5] & !op[4] & !op[3] & !op[2] & !op[1] & !op[0]);

endmodule