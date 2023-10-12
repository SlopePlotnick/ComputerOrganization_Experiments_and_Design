`include"alu_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_alu_112;


// alu_112 Inputs
reg   [2:0]  op                            = 0 ;
reg   [31:0]  A                             = 0 ;
reg   [31:0]  B                             = 0 ;
reg   ci                                   = 0 ;

// alu_112 Outputs
wire  [31:0]  result                        ;
wire  co                                   ;

alu_112 #(.WITDH(32)) u_alu_112 (
    .op                      ( op      [2:0] ),
    .A                       ( A       [31:0] ),
    .B                       ( B       [31:0] ),
    .ci                      ( ci            ),

    .result                  ( result  [31:0] ),
    .co                      ( co            )
);

initial
begin
    A = 32'd456; B = 32'd234; ci = 1'b1;

    op = 3'b000;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A + B = %b, co = %b", result, co);

    op = 3'b001;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("ci = %b", ci);
    $display("A + B + ci = %b, co = %b", result, co);

    op = 3'b010;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("ci = %b", ci);
    $display("A - B - ci = %b, co = %b", result, co);

    op = 3'b011;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A & B = %b", result);

    op = 3'b100;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A | B = %b", result);

    op = 3'b101;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A ^ B = %b", result);

    op = 3'b110;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("~A = %b", result);

    $display("-----------------------");

    A = 32'd245; B = 32'd678;

    op = 3'b000;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A + B = %b, co = %b", result, co);

    op = 3'b001;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("ci = %b", ci);
    $display("A + B + ci = %b, co = %b", result, co);

    op = 3'b010;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("ci = %b", ci);
    $display("A - B - ci = %b, co = %b", result, co);

    op = 3'b011;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A & B = %b", result);

    op = 3'b100;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A | B = %b", result);

    op = 3'b101;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("A ^ B = %b", result);

    op = 3'b110;
    #1;
    $display("A = %b", A);
    $display("B = %b", B);
    $display("~A = %b", result);

    $finish;
end

endmodule