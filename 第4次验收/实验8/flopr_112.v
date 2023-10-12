module flopr_112 #(parameter WITDH = 4) (clk, reset, En, d, q);

input clk, reset, En;
input[WITDH - 1:0] d;
output[WITDH - 1:0] q;
reg[WITDH - 1:0] q;

//异步复位
always @(posedge clk or negedge reset)
begin
  if (!reset) q <= 0;
  else if (En) q <= d;
end

endmodule