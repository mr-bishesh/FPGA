module compi(
    input [7:0] a,
    output reg [7:0] b
    );
always @(*)
begin
    b = ~a + 1'b1;
end
endmodule
