`include"ALU_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_ALU_112;

// ALU_112 Parameters
parameter PERIOD  = 10;


// ALU_112 Inputs
reg   [31:0]  A                            = 0 ;
reg   [31:0]  B                            = 0 ;
reg   [2:0]  ALUctr                        = 0 ;

// ALU_112 Outputs
wire  [31:0]  Result                       ;
wire  Zero                                 ;
wire  Overflow                             ;

ALU_112  u_ALU_112 (
    .A                       ( A         [31:0] ),
    .B                       ( B         [31:0] ),
    .ALUctr                  ( ALUctr    [2:0]  ),

    .Result                  ( Result    [31:0] ),
    .Zero                    ( Zero             ),
    .Overflow                ( Overflow         )
);

initial
begin
    A = 32'd250; B = 32'd369;

    $display("%b", A);
    $display("%b", B);

    ALUctr = 3'b000;
    #1;
    $display("addu");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    #1;ALUctr = 3'b001;
    #1;
    $display("add");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    #1;ALUctr = 3'b010;
    #1;
    $display("or");
    $display("Result = %b", Result);

    #1;ALUctr = 3'b100;
    #1;
    $display("subu");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    #1;ALUctr = 3'b101;
    #1;
    $display("sub");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    #1;ALUctr = 3'b110;
    #1;
    $display("sltu");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    #1;ALUctr = 3'b111;
    #1;
    $display("slt");
    $display("Result = %b", Result);
    $display("Zero = %b", Zero);
    $display("Overflow = %b", Overflow);

    $finish;
end

endmodule