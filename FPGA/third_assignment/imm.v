module imem(
    input [7:0] addr,
    output reg [7:0] data
);

    reg [7:0] mem [0:255];
    integer i;

    initial begin
        mem[8'h00] = 8'h40; // mov ACC(r0) <- imm
        mem[8'h01] = 8'h0A; //   imm = 10            -> ACC = 10
        mem[8'h02] = 8'h48; // mov r1 <- imm
        mem[8'h03] = 8'h05; //   imm = 5             -> r1 = 5
        mem[8'h04] = 8'h11; // mov r2 <- r1 (mov reg<-reg demo) -> r2 = 5
        mem[8'h05] = 8'h89; // ADD  ACC + r1  = 10 + 5      -> ACC = 15
        mem[8'h06] = 8'h92; // INC  ACC + 1   = 15 + 1      -> ACC = 16
        mem[8'h07] = 8'h9B; // DEC  ACC - 1   = 16 - 1      -> ACC = 15
        mem[8'h08] = 8'h58; // mov r3 <- imm
        mem[8'h09] = 8'hF0; //   imm = 0xF0 (240)   -> r3 = 240
        mem[8'h0A] = 8'h9C; // XOR  ACC ^ r3  = 15 ^ 240    -> ACC = 255
        mem[8'h0B] = 8'h60; // mov r4 <- imm
        mem[8'h0C] = 8'h0F; //   imm = 0x0F (15)    -> r4 = 15
        mem[8'h0D] = 8'hA5; // AND  ACC & r4 = 255 & 15    -> ACC = 15
        mem[8'h0E] = 8'h68; // mov r5 <- imm
        mem[8'h0F] = 8'hAA; //   imm = 0xAA (170)   -> r5 = 170
        mem[8'h10] = 8'hAE; // OR   ACC | r5  = 15 | 170    -> ACC = 175
        mem[8'h11] = 8'hBF; // NOT  ~ACC      = ~175        -> ACC = 80
        for (i = 18; i < 256; i = i + 1) mem[i] = 8'h00; // NOP (mov r0<-r0) padding
    end

    always @(*) begin
        data = mem[addr];
    end

endmodule
