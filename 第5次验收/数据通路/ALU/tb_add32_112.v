`include"add32_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_add32_112;

// add32_112 Parameters
parameter PERIOD  = 10;


// add32_112 Inputs
reg   [32:1]  A                            = 0 ;
reg   [32:1]  B                            = 0 ;
reg   c0                                   = 0 ;

// add32_112 Outputs
wire  [32:1]  S                            ;
wire  C32                                  ;
wire  Add_Carry                            ;
wire  Zero                                 ;
wire  Add_Overflow                         ;
wire  Add_Sign                             ;

add32_112  u_add32_112 (
    .A                       ( A             [32:1] ),
    .B                       ( B             [32:1] ),
    .c0                      ( c0                   ),

    .S                       ( S             [32:1] ),
    .C32                     ( C32                  ),
    .Add_Carry               ( Add_Carry            ),
    .Zero                    ( Zero                 ),
    .Add_Overflow            ( Add_Overflow         ),
    .Add_Sign                ( Add_Sign             )
);

initial
begin
    A = 32'h40000000; B = 32'h40000000;

    $display("A = %b", A);
    $display("B = %b", B);

    #1;

    $display("%b", S);
    $display("%b", C32);
    $display("%b", Add_Carry);
    $display("%b", Zero);
    $display("%b", Add_Overflow);
    $display("%b", Add_Sign);


    $finish;
end

endmodule