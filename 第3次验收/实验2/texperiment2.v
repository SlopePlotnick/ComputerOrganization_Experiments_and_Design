`include "experiment2.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test2;

// test2 Inputs
reg   A                                    = 0;
reg   B                                    = 0;

// test2 Outputs
wire  Y1                                   ;
wire  Y2                                   ;
wire  Y3                                   ;

test2 mytest(A, B, Y1, Y2, Y3);

/*iverilog */
initial
begin
    $dumpfile("experiment2_wave.vcd");        //生成的vcd文件名称 注意脚本中生成的波形文件要名称相同
    $dumpvars(0, tb_test2);     //tb模块名称
end
/*iverilog */

initial
begin
    #10 A = 1'b0; B = 1'b1;
    #10 A = 1'b1; B = 1'b0;
    #10 A = 1'b1; B = 1'b1;
    #10 $finish;
end

endmodule