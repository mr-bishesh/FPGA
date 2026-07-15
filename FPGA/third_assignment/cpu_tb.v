`timescale 1ns/1ps

module tb_cpu;

    reg clk = 0;
    always #5 clk = ~clk;
    wire [7:0] acc;
    wire [7:0] pc;

    cpu dut (.clk(clk)
//    .acc_out(acc),
//    .pc_out(pc)
    );

    integer i;
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_cpu);

        $display("time  pc   inst   ACC(r0) r1  r2  r3  r4  r5");
        for (i = 0; i < 40; i = i + 1) begin
            @(posedge clk);
            #1;
            $display("%0t  %0d   %0h    %0d  %0d  %0d  %0d  %0d  %0d",
                $time, dut.pc, dut.inst,
                dut.u_refile.regfile[0],
                dut.u_refile.regfile[1],
                dut.u_refile.regfile[2],
                dut.u_refile.regfile[3],
                dut.u_refile.regfile[4],
                dut.u_refile.regfile[5]);
        end
        $finish;
    end

endmodule
