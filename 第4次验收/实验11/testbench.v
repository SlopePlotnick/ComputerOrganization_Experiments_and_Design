`include"mem1024_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_mem1024_112;

// mem1024_112 Parameters
parameter PERIOD  = 10;

// mem1024_112 Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   wEn                                  = 0 ;
reg   [9:0]  addr                          = 0 ;
reg   [7:0]  din                           = 0 ;

// mem1024_112 Outputs
wire  [7:0]  dout                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

mem1024_112  u_mem1024_112 (
    .clk                     ( clk         ),
    .rst                     ( rst         ),
    .wEn                     ( wEn         ),
    .addr                    ( addr  [9:0] ),
    .din                     ( din   [7:0] ),

    .dout                    ( dout  [7:0] )
);

integer i;

initial
begin
    rst = 1;
    addr = 10'd100;
    wEn = 1;
    i = 0;
    din = 0;
end

always @(posedge clk)
begin
    #1;

    $display("R[%d] = %d", addr, dout);
end

always @(negedge clk)
begin
    i = i + 1;
    addr = addr + 1;
    din = i;

    if (i === 21) $finish;
end


endmodule