module eight_bit_alu(
    input [7:0] a,b,
    input [2:0] sel,
    output [7:0] o,
    output c
);

wire [8:0] sum;

assign sum = (sel == 3'b001) ? a-b : a+b;

assign o =  (sel == 3'b000) ? a+b :
            (sel == 3'b001) ? a-b :
            (sel == 3'b010) ? a&b :
            (sel == 3'b011) ? a|b : 
            (sel == 3'b100) ? a^b : 
            (sel == 3'b101) ? ~a : 
            (sel == 3'b110) ? a<<1 :
             b>>1;

assign c = (sel == 3'b000 || sel == 3'b001) ? sum[8] : 1'b0;
endmodule
