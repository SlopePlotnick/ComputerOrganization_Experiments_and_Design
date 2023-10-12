`include"mux2_112.v"

module test();

reg clk, reset;
reg a, b, s, ye;
wire y;
reg[31:0] vectornum, errors;
reg[31:0] testvectors[10000:0];

mux2_112 #(.WITDH(1)) dut(a, b, s, y);

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
    #1; {a, b, s, ye} = testvectors[vectornum];
end

always @ (negedge clk)
if (~reset) begin
    if (y !== ye) begin
        $display("Error : inputs = %b", {a, b, s});
        $display ("outputs = %b (%b expected)", y, ye);
        errors = errors + 1;
    end
    else begin
        $display("Right : inputs = %b", {a, b, s});
        $display ("outputs = %b (%b expected)", y, ye);
    end
    vectornum = vectornum + 1;
    if (testvectors[vectornum] === 4'bx) begin
        $display ("%d test completed with %d errors", vectornum, errors);

        $finish;
    end
end

endmodule