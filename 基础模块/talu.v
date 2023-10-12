`include "alu.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_ALU;

// ALU Parameters
parameter PERIOD  = 10;


// ALU Inputs
reg   [2:0]  op                            = 0 ;
reg   [7:0]  A                             = 0 ;
reg   [7:0]  B                             = 0 ;
reg   ci                                   = 0 ;

// ALU Outputs
wire  [7:0]  result                        ;
wire  co                                   ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

ALU  u_ALU (
    .op                      ( op      [2:0] ),
    .A                       ( A       [7:0] ),
    .B                       ( B       [7:0] ),
    .ci                      ( ci            ),

    .result                  ( result  [7:0] ),
    .co                      ( co            )
);

initial
begin

    $finish;
end

endmodule