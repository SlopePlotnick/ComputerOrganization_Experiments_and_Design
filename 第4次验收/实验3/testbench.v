`include"mux4_112.v"

module test();

reg clk, reset;
reg d0, d1, d2, d3, s1, s2, ye;
wire y;
reg[31:0] vectornum, errors;
reg[6:0] testvectors[10000:0];

mux4_112 #(.WITDH(1)) dut(d0, d1, d2, d3, s1, s2, y);

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
    #1; {d0, d1, d2, d3, s1, s2, ye} = testvectors[vectornum];
end

always @ (negedge clk)
if (~reset) begin
    if (y !== ye) begin
        $display("Error : inputs = %b", {d0, d1, d2, d3, s1, s2});
        $display ("outputs = %b (%b expected)", y, ye);
        errors = errors + 1;
    end
    else begin
        $display("Right : inputs = %b", {d0, d1, d2, d3, s1, s2});
        $display ("outputs = %b (%b expected)", y, ye);
    end
    vectornum = vectornum + 1;
    if (testvectors[vectornum] === 7'bx) begin
        $display ("%d test completed with %d errors", vectornum, errors);

        $finish;
    end
end

endmodule