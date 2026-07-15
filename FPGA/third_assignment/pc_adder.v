module pc_adder(
    input  [7:0] pc_in,
    output [7:0] pc_out
);

    assign pc_out = pc_in + 8'd1;

endmodule
