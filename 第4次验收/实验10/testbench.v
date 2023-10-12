`include"fsm_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_fsm_112;

// fsm_112 Parameters
parameter PERIOD = 10   ;

// fsm_112 Inputs
reg   clk                                  = 0 ;
reg   in                                   = 0 ;

// fsm_112 Outputs
wire  out                                  ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

fsm_112 u_fsm_112 (
    .clk                     ( clk   ),
    .in                      ( in    ),

    .out                     ( out   )
);

initial
begin
    $dumpfile("fsm_112.wave.vcd");
    $dumpvars(0, tb_fsm_112);
end

initial
begin
    #10; in = 1;

    #100;

    $finish;
end

endmodule