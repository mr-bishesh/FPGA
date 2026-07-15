`timescale 1ns/1ps

module cpu(
    input clk
//    output [7:0] acc_out,
//    output [7:0] pc_out
    );

    reg  [7:0] pc;
    wire [7:0] pc_next;
    wire       pcen_w;

    pc_adder u_pc_adder (
        .pc_in  (pc),
        .pc_out (pc_next)
    );

    initial pc = 8'd0;
    always @(posedge clk) if (pcen_w) pc <= pc_next;

    wire [7:0] inst;

    imem u_imem (
        .addr (pc),
        .data (inst)
    );

    wire [7:0] imm_val;
    wire [2:0] readreg1;   // -> REGOUT1 -> straight to ALU OPERAND2
    wire [2:0] readreg2;   // -> REGOUT2 -> 2's-comp / imm mux -> ALU OPERAND1
    wire [2:0] writereg_w;
    wire       writeenable_w;
    wire [2:0] aluop_w;
    wire       compmux_sel;
    wire       immux_sel;

    control u_control (
        .clk         (clk),
        .code        (inst),
        .imm         (imm_val),
        .regsel1     (readreg1),
        .regsel2     (readreg2),
        .writereg    (writereg_w),
        .writeenable (writeenable_w),
        .aluop       (aluop_w),
        .compmux     (compmux_sel),
        .immux       (immux_sel),
        .pcen        (pcen_w)
    );
    wire [7:0] regout1;   // direct  -> ALU OPERAND2
    wire [7:0] regout2;   // muxed   -> ALU OPERAND1
    wire [7:0] aluresult;

    refile u_refile (
        .clk         (clk),
        .readreg1    (readreg1),
        .readreg2    (readreg2),
        .writereg    (writereg_w),
        .writedata   (aluresult),
        .writeenable (writeenable_w),
        .regout1     (regout1),
        .regout2     (regout2)
    );

    wire [7:0] comp_out;
    wire [7:0] opA_pre;    // result of compmux: regout2 or -regout2

    compi u_compi (
        .a (regout2),
        .b (comp_out)
    );

    compmux u_compmux (
        .a        (comp_out),
        .b        (regout2),
        .compmux  (compmux_sel),
        .result   (opA_pre)
    );

    //--------------------------------------------------------------
    // Immediate MUX  (IMMEDIATE[7:0] vs opA_pre) -> ALU OPERAND1
    //--------------------------------------------------------------
    wire [7:0] operand1;

    immux u_immux (
        .imm      (imm_val),
        .regout1  (opA_pre),
        .immux    (immux_sel),
        .alu_a    (operand1)
    );

    //--------------------------------------------------------------
    // ALU  (unchanged, exactly as given)
    //--------------------------------------------------------------
    wire       alu_carry;

    eight_bit_alu u_alu (
        .a   (operand1),   // OPERAND1
        .b   (regout1),    // OPERAND2 (direct from REGOUT1)
        .sel (aluop_w),
        .o   (aluresult),
        .c   (alu_carry)
    );
    assign acc_out = u_refile.regfile[0];  
    assign pc_out  = pc;

endmodule
