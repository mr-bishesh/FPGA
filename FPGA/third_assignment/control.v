module control(
    input clk,
    input [7:0] code,
    output reg [7:0] imm,
    output reg [2:0] regsel1,   
    output reg [2:0] regsel2,   
    output reg [2:0] writereg,
    output reg       writeenable,
    output reg [2:0] aluop,    
    output reg       compmux,   
    output reg       immux,
    output reg       pcen
    );

    localparam [2:0] ACC_ADDR = 3'b000;   // accumulator register address
    localparam [2:0] G_ADDR   = 3'b110;   // hard-wired constant = 8'd1
    localparam [2:0] H_ADDR   = 3'b111;   // hard-wired constant = 8'd0 

    // ALU sel encoding as actually implemented in eight.v (do not change eight.v)
    localparam [2:0] ALU_ADD  = 3'b001;
    localparam [2:0] ALU_AND  = 3'b010;
    localparam [2:0] ALU_OR   = 3'b011;
    localparam [2:0] ALU_XOR  = 3'b100;
    localparam [2:0] ALU_NOT  = 3'b101;

    localparam [1:0] S_DECODE    = 2'b00;
    localparam [1:0] S_FETCH_IMM = 2'b01;
    localparam [1:0] S_EXECUTE   = 2'b10;

    reg [1:0] state;
    always @(*) begin
        writeenable = (state == S_EXECUTE);
        pcen        = (state != S_EXECUTE);   // hold PC during writeback cycle
    end

    initial begin
        state    = S_DECODE;
        imm      = 8'd0;
        regsel1  = 3'd0;
        regsel2  = 3'd0;
        writereg = 3'd0;
        aluop    = 3'd0;
        compmux  = 1'b0;
        immux    = 1'b0;
    end

    always @(posedge clk) begin
        case (state)
            S_DECODE: begin
                compmux <= 1'b0; 

                case (code[7:6])

                    2'b00: begin // mov reg <- reg
                        regsel2  <= code[2:0];   // source -> REGOUT2 -> 'a' (immux=0, compmux=0)
                        regsel1  <= H_ADDR;     // constant 0 -> REGOUT1 -> 'b'
                        writereg <= code[5:3];   // destination
                        aluop    <= ALU_ADD;     // a+0 = pass-through
                        immux    <= 1'b0;
                        state    <= S_EXECUTE;
                    end

                    2'b01: begin // mov reg <- immediate
                        writereg <= code[5:3];
                        regsel1  <= H_ADDR;      // constant 0 -> 'b'
                        regsel2  <= H_ADDR;      // don't-care, overridden by immux
                        aluop    <= ALU_ADD;     // imm+0 = pass-through
                        immux    <= 1'b1;        // 'a' comes from imm
                        state    <= S_FETCH_IMM; // next byte is data, not an opcode
                    end

                    2'b10: begin
                    writereg <= ACC_ADDR;    // result always written back to accumulator
                    immux    <= 1'b0;

                    case (code[2:0])
                        3'b001: begin // ADD : ACC + R
                            regsel2 <= ACC_ADDR;    // 'a' = ACC
                            regsel1 <= code[5:3];   // 'b' = R
                            aluop   <= ALU_ADD;
                            compmux <= 1'b0;
                        end
                        3'b010: begin // INC : ACC + 1
                            regsel2 <= ACC_ADDR;    // 'a' = ACC
                            regsel1 <= G_ADDR;      // 'b' = 1
                            aluop   <= ALU_ADD;
                            compmux <= 1'b0;
                        end
                        3'b011: begin // DEC : ACC - 1 = ACC + (-1), via 2's complement
                            regsel1 <= ACC_ADDR;    // 'b' = ACC (direct path)
                            regsel2 <= G_ADDR;      // 'a' = 1, negated by compmux -> -1
                            aluop   <= ALU_ADD;
                            compmux <= 1'b1;
                        end
                        3'b100: begin // XOR : ACC ^ R
                            regsel2 <= ACC_ADDR;
                            regsel1 <= code[5:3];
                            aluop   <= ALU_XOR;
                            compmux <= 1'b0;
                        end
                        3'b101: begin // AND : ACC & R
                            regsel2 <= ACC_ADDR;
                            regsel1 <= code[5:3];
                            aluop   <= ALU_AND;
                            compmux <= 1'b0;
                        end
                        3'b110: begin // OR : ACC | R
                            regsel2 <= ACC_ADDR;
                            regsel1 <= code[5:3];
                            aluop   <= ALU_OR;
                            compmux <= 1'b0;
                        end
                        3'b111: begin // NOT : ~ACC (unary, 'b' unused -> const 0)
                            regsel2 <= ACC_ADDR;
                            regsel1 <= H_ADDR;
                            aluop   <= ALU_NOT;
                            compmux <= 1'b0;
                        end
                        default: begin
                            regsel2 <= ACC_ADDR;
                            regsel1 <= code[5:3];
                            aluop   <= ALU_ADD;
                            compmux <= 1'b0;
                        end
                    endcase

                    state <= S_EXECUTE;
                    end

                   default : state <= S_DECODE;

                endcase
            end
            S_FETCH_IMM: begin
                imm   <= code;
                state <= S_EXECUTE;
            end
            S_EXECUTE: begin
                state <= S_DECODE;
            end

            default: state <= S_DECODE;
        endcase
    end
endmodule
