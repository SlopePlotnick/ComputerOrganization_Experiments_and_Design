module counter16(clk, reset, d);
    input clk, reset;
    output[0:3] d;
    reg[0:3] d;

    always @(posedge clk)
        if (!reset)
            d <= 0;
        else
            d <= d + 1;
endmodule