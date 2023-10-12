`include "sillyfunction_112.v"

module testbench3();

reg clk, reset;
reg a, b, c, yexpected;
wire y;
reg[31:0] vectornum, errors;
reg[31:0] testvectors[10000:0];

//调用该模块的逻辑是参数同名自动传递参数
sillyfunction_112 dut(a, b, c, y);

always
begin
    clk = 1; #5; clk = 0; #5;
end

initial
begin
    $readmemb("example.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #27; reset = 0;
end

always @ (posedge clk)
begin
    #1; {a, b, c, yexpected} = testvectors[vectornum];
end

always @ (negedge clk)
if (~reset) begin
    if (y !== yexpected) begin
        $display("Error : inputs = %b", {a, b, c});
        $display ("outputs = %b (%b expected)", y, yexpected);
        errors = errors + 1;
    end
    vectornum = vectornum + 1;
    if (testvectors[vectornum] === 4'bx) begin
        $display ("%d test completed with %d errors", vectornum, errors);

        $finish;
    end
end

endmodule