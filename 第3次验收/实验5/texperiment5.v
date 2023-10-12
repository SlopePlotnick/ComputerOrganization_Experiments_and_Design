`include "experiment5.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_test5;

// test5 Parameters
parameter PERIOD  = 10;


// test5 Inputs
reg   A                                    = 0 ;
reg   [1:0]  D                             = 0 ;

// test5 Outputs
wire  Y                                    ;

test5  u_test5 (
    .A                       ( A        ),
    .D                       ( D  [1:0] ),

    .Y                       ( Y        )
);

initial
begin
    $dumpfile("experiment5_wave.vcd");
    $dumpvars(0, tb_test5);
end

initial
begin

    A = 0; D = 2'b01;
    #10 A = 1; D = 2'b10;

    #10 $finish;
end

endmodule