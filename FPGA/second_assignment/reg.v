module refile(
    input clk,
    input [2:0] readreg1,
    input [2:0] readreg2,
    input [2:0] writereg,
    input [7:0] writedata,
    input writeenable,
    output reg [7:0] regout1,
    output reg [7:0] regout2
);

reg [7:0] regfile [0:7];

integer i;
initial begin
    for (i = 0; i < 8; i = i + 1)
        regfile[i] = 8'b0;
end

always @(posedge clk) begin
    if (writeenable) begin
        if (writereg == 3'd6) begin
            regfile[6] <= 8'd1;
        end else if (writereg == 3'd7) begin
            regfile[7] <= 8'd0;
        end else begin
            regfile[writereg] <= writedata;
        end
    end
end

always @(*) begin
    if (writeenable && (readreg1 == writereg)) begin
        if (writereg == 3'd6)
            regout1 = 8'd1;
        else if (writereg == 3'd7)
            regout1 = 8'd0;
        else
            regout1 = writedata;
    end else begin
        if (readreg1 == 3'd6)
            regout1 = 8'd1;
        else if (readreg1 == 3'd7)
            regout1 = 8'd0;
        else
            regout1 = regfile[readreg1];
    end

    if (writeenable && (readreg2 == writereg)) begin
        if (writereg == 3'd6)
            regout2 = 8'd1;
        else if (writereg == 3'd7)
            regout2 = 8'd0;
        else
            regout2 = writedata;
    end else begin
        if (readreg2 == 3'd6)
            regout2 = 8'd1;
        else if (readreg2 == 3'd7)
            regout2 = 8'd0;
        else
            regout2 = regfile[readreg2];
    end
end

endmodule