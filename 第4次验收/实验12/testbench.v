`include"mem512_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_mem512_112;

// mem512_112 Parameters
parameter PERIOD  = 10;


// mem512_112 Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   wEn                                  = 0 ;
reg   [8:0]  addr                          = 0 ;
reg   [31:0]  din                          = 0 ;

// mem512_112 Outputs
wire  [31:0]  dout                         ;

reg[31:0] vectornum;
reg[31:0] testvectors[10000:0];

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

mem512_112  u_mem512_112 (
    .clk                     ( clk          ),
    .rst                     ( rst          ),
    .wEn                     ( wEn          ),
    .addr                    ( addr  [8:0]  ),
    .din                     ( din   [31:0] ),

    .dout                    ( dout  [31:0] )
);

initial
begin
    rst = 1; wEn = 1;
    $readmemb("inst.tv", testvectors);
    vectornum = 0;
    addr = 9'd200;
    din = testvectors[vectornum];
end

always @(posedge clk)
begin
    #1; 

    $display("The current instruction is:");
    $display("R[%d] = %h", addr, dout);
end

always @(negedge clk)
begin
    addr = addr + 1;
    vectornum = vectornum + 1;
    din = testvectors[vectornum];

    if (testvectors[vectornum] === 32'bx) $finish;
end

endmodule