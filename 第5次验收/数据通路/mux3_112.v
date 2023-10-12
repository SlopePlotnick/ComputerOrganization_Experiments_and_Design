module mux3_112 #(parameter WITDH = 32) (D0, D1, D2, s, y);

input[WITDH - 1:0] D0, D1, D2;
input[1:0] s;
output[WITDH - 1:0] y;
reg[WITDH - 1:0] y;

always @(s or D0 or D1 or D2)
begin
    case (s)
        2'b00 : y = D0;
        2'b01 : y = D1;
        2'b10 : y = D2;
    endcase
end

endmodule