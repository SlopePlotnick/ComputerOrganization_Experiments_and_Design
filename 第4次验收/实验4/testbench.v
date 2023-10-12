`include"add1_112.v"

module test();

reg clk, reset;
reg a, b, ci, se, coe;
wire s, co;
reg[31:0] vectornum, errors;
reg[4:0] testvectors[10000:0];

add1_112 dut(a, b, ci, s, co);

always
begin
    clk = 1; #5; clk = 0; #5;
end

initial
begin
    $readmemb("data.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #27; reset = 0;
end

always @ (posedge clk)
begin
    #1; {a, b, ci, se, coe} = testvectors[vectornum];
end

always @ (negedge clk)
if (~reset) begin
    if ((s !== se) | (co !== coe)) begin
        $display("Error : inputs = %b", {a, b, ci});
        $display ("s = %b (%b expected)", s, se);
        $display ("co = %b (%b expected)", co, coe);
        errors = errors + 1;
    end
    else begin
        $display("Right : inputs = %b", {a, b, ci});
        $display ("s = %b (%b expected)", s, se);
        $display ("co = %b (%b expected)", co, coe);
    end
    vectornum = vectornum + 1;
    if (testvectors[vectornum] === 5'bx) begin
        $display ("%d test completed with %d errors", vectornum, errors);

        $finish;
    end
end

endmodule