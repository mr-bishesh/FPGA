module eight_bit_alu(
    input [7:0] a,b, input [2:0] sel, output reg [7:0] o,output reg c
    );
always @(*) 
begin
c= 1'b0;
case (sel)
3'b001 : {c,o} = a+b;
3'b010 : o = a&b;
3'b011 : o = a|b;
3'b100 : o = a^b;
3'b101 : o = ~a;
default : {c,o} = 9'b0;
endcase
end
endmodule
