module immux(
    input [7:0] imm,
    input [7:0] regout1,
    input immux,
    output reg [7:0] alu_a
);


    always @(*) begin
        if (immux) begin
            alu_a = imm;
        end else begin
            alu_a = regout1;
        end
    end
endmodule