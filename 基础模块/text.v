`include "ext.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test8;

// test8 Inputs
reg   [15:0]  A                            = 0;

// test8 Outputs
wire  [31:0]  B                            ;

test8  u_test8 (
    .A                       ( A  [15:0] ),

    .B                       ( B  [31:0] )
);

initial
begin
    A = 16'hfc57;
    $display("This is A %b", A);
    #1 $display("This is B %b", B);
    #10 A = 16'h0c57;
    $display("This is A %b", A);
    #1 $display("This is B %b", B);
    #10 $finish;
end

endmodule