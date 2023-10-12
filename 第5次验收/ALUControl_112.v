module ALUControl_112(func, ALUctrF);

input[5:0] func;
output[2:0] ALUctrF;

assign ALUctrF[2] = (!func[2] & func[1]);
assign ALUctrF[1] = (func[3] & !func[2] & func[1]);
assign ALUctrF[0] = (!func[3] & !func[2] & !func[0]) | (!func[2] & func[1] & !func[0]);

endmodule