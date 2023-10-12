`include"regfile_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_regfile_112;

// regfile_112 Parameters
parameter PERIOD  = 10;


// regfile_112 Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   wEn                                  = 0 ;
reg   addr                                 = 0 ;
reg   [7:0]  din                           = 8'b1101101 ;

// regfile_112 Outputs
wire  [7:0]  dout                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

regfile_112  u_regfile_112 (
    .clk                     ( clk          ),
    .reset                   ( reset        ),
    .wEn                     ( wEn          ),
    .addr                    ( addr         ),
    .din                     ( din    [7:0] ),

    .dout                    ( dout   [7:0] )
);

initial
begin
    $dumpfile("regfile_112_wave.vcd");
    $dumpvars(0, tb_regfile_112);
end

initial
begin
    reset = 0;

    #10; reset = 1; wEn = 1;
    #10; din = 8'b01101110; addr = 2;
    #10; reset = 0;

    #100;

    $finish;
end

endmodule