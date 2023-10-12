`include"add32_112.v"
`timescale 1ns/1ns

module test();

reg clk, reset;
reg [32:1] A;
reg [32:1] B;
reg c0;
wire [32:1] S;
wire C32;

add32_112 dut(A, B, c0, S, C32);

initial 
begin
    A = 32'd0; B = 32'd0; c0 = 1'd0;

    #5;  A = 32'd 456;  B = 32'd234;
    #1;
    $display("A = %b B", A);
    $display("= %d D", A);
    $display("B = %b B", B);
    $display("= %d D", B);
    $display("S = %b B", S );
    $display("= %d D", S);
    $display("C32 = %b", C32);
    #5;  A = 32'd 245;  B = 32'd678;
    #1;
    $display("A = %b B", A);
    $display("= %d D", A);
    $display("B = %b B", B);
    $display("= %d D", B);
    $display("S = %b B", S );
    $display("= %d D", S);
    $display("C32 = %b", C32);
end

endmodule