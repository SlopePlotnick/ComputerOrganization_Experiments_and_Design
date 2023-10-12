module ALU(op, A, B, ci, result, co);
input [2:0] op;
input [7:0] A, B;
input ci;
output [7:0] result;
output co;
reg [7:0] result;
reg co;

always @ (op or A or B)
begin
  case (op)
    3'd0 : {co, result} = A + B;
    3'd1 : {co, result} = A + B + ci;
    3'd2 : {co, result} = A - B - ci;
    3'd3 : result = A & B;
    3'd4 : result = A | B;
    3'd5 : result = A ^ B;
    3'd6 = result = ~A;
    default : 
    begin 
        co = 0;
        result = 8'd0;
    end
  endcase
end
        
endmodule