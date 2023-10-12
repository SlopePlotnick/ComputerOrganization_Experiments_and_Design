module alu_112 #(parameter WITDH = 8) (op, A, B, ci, result, co);
input [2:0] op;
input [WITDH - 1:0] A, B;
input ci;
output [WITDH - 1:0] result;
output co;
reg [WITDH - 1:0] result;
reg co;
//此处覆盖定义一遍是因为要在always模块中更改result和co的值

always @ (op or A or B or ci)
begin
  case (op)
    3'd0 : {co, result} = A + B;
    3'd1 : {co, result} = A + B + ci;
    3'd2 : {co, result} = A - B - ci;
    3'd3 : result = A & B;
    3'd4 : result = A | B;
    3'd5 : result = A ^ B;
    3'd6 : result = ~A;
    default : 
    begin 
        co = 0;
        result = 0;
    end
  endcase
end
        
endmodule