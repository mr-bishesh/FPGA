`timescale 1ns / 1ps

module fft_tb;
  reg CLK, RST;
  reg signed [7:0] x0_re, x1_re, x2_re, x3_re, x4_re, x5_re, x6_re, x7_re;
  reg signed [7:0] x0_im, x1_im, x2_im, x3_im, x4_im, x5_im, x6_im, x7_im;
  wire signed [7:0] y0_re, y1_re, y2_re, y3_re, y4_re, y5_re, y6_re, y7_re;
  wire signed [7:0] y0_im, y1_im, y2_im, y3_im, y4_im, y5_im, y6_im, y7_im;

  fft_8point uut (
      CLK,
      RST,
      x0_re,
      x1_re,
      x2_re,
      x3_re,
      x4_re,
      x5_re,
      x6_re,
      x7_re,
      x0_im,
      x1_im,
      x2_im,
      x3_im,
      x4_im,
      x5_im,
      x6_im,
      x7_im,
      y0_re,
      y1_re,
      y2_re,
      y3_re,
      y4_re,
      y5_re,
      y6_re,
      y7_re,
      y0_im,
      y1_im,
      y2_im,
      y3_im,
      y4_im,
      y5_im,
      y6_im,
      y7_im
  );

  integer i;

  // Clock generation
  initial CLK = 0;
  always #5 CLK = ~CLK;

  // VCD dump for waveform analysis
  initial begin
    $dumpfile("fft_tb.vcd");
    $dumpvars(0, fft_tb);
  end

  // Stimulus
  initial begin
    RST   = 1;

    x0_re = 0;
    x0_im = 0;
    x1_re = 0;
    x1_im = 0;
    x2_re = 0;
    x2_im = 0;
    x3_re = 0;
    x3_im = 0;
    x4_re = 0;
    x4_im = 0;
    x5_re = 0;
    x5_im = 0;
    x6_re = 0;
    x6_im = 0;
    x7_re = 0;
    x7_im = 0;
    #20;
    RST   = 0;

    // Example: Impulse input (x[0]=1, rest=0)
    x0_re = 8'sh7F;
    x0_im = 0;
    x1_re = 0;
    x1_im = 0;
    x2_re = 0;
    x2_im = 0;
    x3_re = 0;
    x3_im = 0;
    x4_re = 0;
    x4_im = 0;
    x5_re = 0;
    x5_im = 0;
    x6_re = 0;
    x6_im = 0;
    x7_re = 0;
    x7_im = 0;
    #50;

    // Example: All ones
    x0_re = 8'sh10;
    x0_im = 0;
    x1_re = 8'sh10;
    x1_im = 0;
    x2_re = 8'sh10;
    x2_im = 0;
    x3_re = 8'sh10;
    x3_im = 0;
    x4_re = 8'sh10;
    x4_im = 0;
    x5_re = 8'sh10;
    x5_im = 0;
    x6_re = 8'sh10;
    x6_im = 0;
    x7_re = 8'sh10;
    x7_im = 0;
    #50;

    // Example: Random test vector
    x0_re = 8'sh7F;
    x0_im = 0;
    x1_re = 8'sh00;
    x1_im = 0;
    x2_re = 8'sh80;
    x2_im = 0;
    x3_re = 8'sh00;
    x3_im = 0;
    x4_re = 8'sh7F;
    x4_im = 0;
    x5_re = 8'sh00;
    x5_im = 0;
    x6_re = 8'sh80;
    x6_im = 0;
    x7_re = 8'sh00;
    x7_im = 0;
    #50;

    // x[n] = 0.7 * cos(2*pi* n / 8)
    x0_re = 8'sh5A;
    x0_im = 0;
    x1_re = 8'sh3F;
    x1_im = 0;
    x2_re = 8'sh00;
    x2_im = 0;
    x3_re = 8'shC1;
    x3_im = 0;
    x4_re = 8'shA6;
    x4_im = 0;
    x5_re = 8'shC1;
    x5_im = 0;
    x6_re = 8'sh00;
    x6_im = 0;
    x7_re = 8'sh3F;
    x7_im = 0;
    #50;

    // x[n] = 0.6 * exp(-j * 2 * pi * n / 8)
    x0_re = 8'sh4D;
    x0_im = 8'sh00;
    x1_re = 8'sh36;
    x1_im = 8'shCA;
    x2_re = 8'sh00;
    x2_im = 8'shB3;
    x3_re = 8'shCA;
    x3_im = 8'shCA;
    x4_re = 8'shB3;
    x4_im = 8'sh00;
    x5_re = 8'shCA;
    x5_im = 8'sh36;
    x6_re = 8'sh00;
    x6_im = 8'sh4D;
    x7_re = 8'sh36;
    x7_im = 8'sh36;
    #50;

    // x[n] = 0.4*cos(2*pi*3*n/8)
    x0_re = 8'sh33;
    x0_im = 0;
    x1_re = 8'shDC;
    x1_im = 0;
    x2_re = 8'sh00;
    x2_im = 0;
    x3_re = 8'sh24;
    x3_im = 0;
    x4_re = 8'shCD;
    x4_im = 0;
    x5_re = 8'sh24;
    x5_im = 0;
    x6_re = 8'sh00;
    x6_im = 0;
    x7_re = 8'shDC;
    x7_im = 0;
    $display("-----------------------------------------");
    $display(" 8-point FFT results:");
    $display("  X0 = %0d + j%0d", y0_re, y0_im);
    $display("  X1 = %0d + j%0d", y1_re, y1_im);
    $display("  X2 = %0d + j%0d", y2_re, y2_im);
    $display("  X3 = %0d + j%0d", y3_re, y3_im);
    $display("  X4 = %0d + j%0d", y4_re, y4_im);
    $display("  X5 = %0d + j%0d", y5_re, y5_im);
    $display("  X6 = %0d + j%0d", y6_re, y6_im);
    $display("  X7 = %0d + j%0d", y7_re, y7_im);
    $display("-----------------------------------------");
    #100;

    $finish;
  end
endmodule