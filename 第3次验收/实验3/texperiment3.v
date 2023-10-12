`include "experiment3.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test3;

// test3 Inputs
reg   A                                    = 0 ;
reg   B                                    = 0 ;
reg   En                                   = 0 ;

// test3 Outputs
wire  [3:0]  Z                             ;

test3  u_test3 (
    .A                       ( A         ),
    .B                       ( B         ),
    .En                      ( En        ),

    .Z                       ( Z   [3:0] )
);

/*iverilog */
initial
begin
    $dumpfile("experiment3_wave.vcd");        //生成的vcd文件名称 注意脚本中生成的波形文件要名称相同
    $dumpvars(0, tb_test3);     //tb模块名称
end
/*iverilog */

initial
begin
    #10 A = 1'b0; B = 1'b1;
    #10 A = 1'b1; B = 1'b0;
    #10 A = 1'b1; B = 1'b1;
    #10 En = 1'b1; A = 1'b0; B = 1'b0;
    #10 A = 1'b0; B = 1'b1;
    #10 A = 1'b1; B = 1'b0;
    #10 A = 1'b1; B = 1'b1;

    #10 $finish;
end

endmodule