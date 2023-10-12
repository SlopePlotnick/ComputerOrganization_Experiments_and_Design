`include"singleCPU_112.v"

//~ `New testbench
`timescale  1ns / 1ps

module tb_singleCPU_112;

// singleCPU_112 Parameters
parameter PERIOD  = 10;


// singleCPU_112 Inputs
reg   clk                                  = 0 ;

// singleCPU_112 Outputs

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

singleCPU_112  u_singleCPU_112 (
    .clk                     ( clk   )
);

endmodule