module getInstruction_112(clk, Zero, Branch, Jump, Instruction);

input clk;
input Zero, Branch, Jump;
output[31:0] Instruction;

reg[31:0] PC;
wire[31:0] NPC;
wire[31:0] add1_out;
wire[31:0] sext_imm;
wire[31:0] add2_out;
wire[31:0] mux1_out;
wire[31:0] mux2_1;

initial
begin
    PC = 0;
end

mem_112 mem
(
    .addr(PC),
    .dout(Instruction)
);

add32_112 add1
(
    .A(PC),
    .B(32'd4),
    .c0(),
    .S(add1_out),
    .C32(),
    .Add_Carry(), 
    .Zero(), 
    .Add_Overflow(), 
    .Add_Sign()
);

sext_112 sext
(
    .A(Instruction[15:0]),
    .B(sext_imm)
);

add32_112 add2
(
    .A(add1_out), 
    .B(sext_imm), 
    .c0(), 
    .S(add2_out), 
    .C32(), 
    .Add_Carry(), 
    .Zero(), 
    .Add_Overflow(), 
    .Add_Sign()
);

mux2_112 #(.WITDH(32)) mux1
(
    .a(add1_out),
    .b(add2_out),
    .s(Branch & Zero),
    .y(mux1_out)
);

assign mux2_1 = {PC[31:28], Instruction[25:0], 2'b00};

mux2_112 #(.WITDH(32)) mux2
(
    .a(mux1_out),
    .b(mux2_1),
    .s(Jump),
    .y(NPC)
);

always @(posedge clk)
begin
    if (NPC == 14 * 4) $finish(2);

    PC <= NPC;
end

endmodule