`include "experiment4.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test4;

// test4 Inputs
reg   [5:0]  op                            = 0 ;

// test4 Outputs
wire  RegDst                               ;
wire  ALUSrc                               ;
wire  MemtoReg                             ;
wire  RegWrite                             ;
wire  MemWrite                             ;
wire  Branch                               ;
wire  Jump                                 ;
wire  ExtOp                                ;
wire  [2:0]  ALUop                         ;

test4  u_test4 (
    .op                      ( op        [5:0] ),

    .RegDst                  ( RegDst          ),
    .ALUSrc                  ( ALUSrc          ),
    .MemtoReg                ( MemtoReg        ),
    .RegWrite                ( RegWrite        ),
    .MemWrite                ( MemWrite        ),
    .Branch                  ( Branch          ),
    .Jump                    ( Jump            ),
    .ExtOp                   ( ExtOp           ),
    .ALUop                   ( ALUop     [2:0] )
);

/*iverilog */
initial
begin
    $dumpfile("experiment4_wave.vcd");        //生成的vcd文件名称 注意脚本中生成的波形文件要名称相同
    $dumpvars(0, tb_test4);     //tb模块名称
end
/*iverilog */

initial
begin
    #10 op = 6'b001101;
    #10 op = 6'b100011;
    #10 op = 6'b101011;
    #10 op = 6'b000100;
    #10 op = 6'b000010; 

    #10 $finish;
end

endmodule