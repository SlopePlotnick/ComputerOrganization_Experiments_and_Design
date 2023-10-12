module ALUctrProcess_112(ALUctr, SUBctr, OVctr, SIGctr, OPctr);

input[2:0] ALUctr;
output SUBctr, OVctr, SIGctr;
output[1:0] OPctr;

assign SUBctr = ALUctr[2];
assign OVctr = (~ALUctr[1]) & ALUctr[0];
assign SIGctr = ALUctr[0];
assign OPctr[1] = ALUctr[2] & ALUctr[1];
assign OPctr[0] = (~ALUctr[2]) & ALUctr[1] & (~ALUctr[0]);

endmodule