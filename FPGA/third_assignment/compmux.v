module compmux(
    input [7:0] a,
    input [7:0] b,
    input compmux,
    output reg [7:0] result
);

    always @(*) begin
        if (compmux) begin
            result = a;
        end else begin
            result = b;
        end
    end
endmodule
