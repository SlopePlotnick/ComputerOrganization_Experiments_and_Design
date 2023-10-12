`include "experiment7.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test7;

// test7 Inputs
reg   [15:0]  A                            = 0 ;

// test7 Outputs
wire  [31:0]  B                            ;

test7  u_test7 (
    .A                       ( A  [15:0] ),

    .B                       ( B  [31:0] )
);

initial 
begin
    $dumpfile("experiment7_wave.vcd");
    $dumpvars(0, tb_test7);
end

initial
begin
    A = 16'hfc57;
    $display("This is A %b", A);
    $display("This is B %b", B);
    $finish;
end

endmodule