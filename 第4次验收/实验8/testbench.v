`include"flopr_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_flopr_112;

// flopr_112 Parameters
parameter PERIOD  = 10;


// flopr_112 Inputs
reg   clk                                  = 0 ;
reg   reset                                 ;
reg   En                                    ;
reg   [3:0]  d                     = 4'b1011 ;

// flopr_112 Outputs
wire  [3:0]  q                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

flopr_112  u_flopr_112 (
    .clk                     ( clk                  ),
    .reset                   ( reset                ),
    .En                      ( En                   ),
    .d                       ( d      [3:0] ),

    .q                       ( q      [3:0] )
);

initial
begin
    $dumpfile("flopr_112_wave.vcd");
    $dumpvars(0, tb_flopr_112);
end

initial
begin
    reset = 1; En = 1;

    #7; reset = 0; //复位

    #7; reset = 1; //赋值

    #7; reset = 0; //复位

    #7; En = 0; reset = 1; //En为0 不赋值

    #100;

    $finish;
end

endmodule