`timescale  1ns / 1ps

module regFile_112(clk, wEn, Ra, Rb, Rw, busA, busB, busW);

input clk, wEn;
input[4:0] Ra, Rb, Rw;
input[31:0] busW;
output[31:0] busA, busB;

reg[31:0] R[0:31];

assign busA = R[Ra];
assign busB = R[Rb];

integer i;

initial
begin
    for (i = 0; i < 32; i++)
    begin
        R[i] = 0;
    end
end

always @(posedge clk)
begin
    if (wEn) R[Rw] = busW;

    $display("-------------------------");
    for (i = 0; i < 32; i++)
    begin
        $display("R[%d] = %d", i, R[i]);
    end
end

endmodule