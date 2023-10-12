`include "experiment6.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test6;

// test6 Inputs
reg   A                                    = 0 ;
reg   B                                    = 0 ;
reg   [2:0]  D                             = 0 ;

// test6 Outputs
wire  Y                                    ;

test6  u_test6 (
    .A                       ( A        ),
    .B                       ( B        ),
    .D                       ( D  [2:0] ),

    .Y                       ( Y        )
);

initial
begin
    $dumpfile("experiment6_wave.vcd");
    $dumpvars(0, tb_test6);
end

initial
begin
    D = 3'b001;
    #10 A = 1'b1; D = 3'b010;
    #10 B = 1'b1; D = 3'b100; A = 1'b0;
    #10 A = 1'b1;

    #10 $finish;
end

endmodule