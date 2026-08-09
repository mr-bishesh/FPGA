
module fft_8point (
    input CLK,
    RST,
    input signed [7:0] x0_re,
    x1_re,
    x2_re,
    x3_re,
    x4_re,
    x5_re,
    x6_re,
    x7_re,
    input signed [7:0] x0_im,
    x1_im,
    x2_im,
    x3_im,
    x4_im,
    x5_im,
    x6_im,
    x7_im,
    output signed [7:0] y0_re,
    y1_re,
    y2_re,
    y3_re,
    y4_re,
    y5_re,
    y6_re,
    y7_re,
    output signed [7:0] y0_im,
    y1_im,
    y2_im,
    y3_im,
    y4_im,
    y5_im,
    y6_im,
    y7_im
);
  // internal registers
  reg signed [7:0] s1_re[7:0], s1_im[7:0];
  reg signed [7:0] s2_re[7:0], s2_im[7:0];
  reg signed [7:0] s3_re[7:0], s3_im[7:0];

  // twidle factor
  wire signed [7:0] w0_re, w1_re, w2_re, w3_re;
  wire signed [7:0] w0_im, w1_im, w2_im, w3_im;

  twiddle tw (
      w0_re,
      w1_re,
      w2_re,
      w3_re,
      w0_im,
      w1_im,
      w2_im,
      w3_im
  );

  integer i;

  // inputs after their bits are re ordered
  wire signed [7:0] x_re[7:0];
  wire signed [7:0] x_im[7:0];

  assign x_re[0] = x0_re;
  assign x_im[0] = x0_im;
  assign x_re[1] = x4_re;
  assign x_im[1] = x4_im;
  assign x_re[2] = x2_re;
  assign x_im[2] = x2_im;
  assign x_re[3] = x6_re;
  assign x_im[3] = x6_im;
  assign x_re[4] = x1_re;
  assign x_im[4] = x1_im;
  assign x_re[5] = x5_re;
  assign x_im[5] = x5_im;
  assign x_re[6] = x3_re;
  assign x_im[6] = x3_im;
  assign x_re[7] = x7_re;
  assign x_im[7] = x7_im;

  // stage 1: butterfly
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      for (i = 0; i < 8; i = i + 1) begin
        s1_re[i] <= 0;
        s1_im[i] <= 0;
      end
    end else begin
      for (i = 0; i < 4; i = i + 1) begin
        s1_re[2*i]   <= ({x_re[2*i][7], x_re[2*i]} + {x_re[2*i+1][7], x_re[2*i+1]}) >>> 1;
        s1_im[2*i]   <= ({x_im[2*i][7], x_im[2*i]} + {x_im[2*i+1][7], x_im[2*i+1]}) >>> 1;
        s1_re[2*i+1] <= ({x_re[2*i][7], x_re[2*i]} - {x_re[2*i+1][7], x_re[2*i+1]}) >>> 1;
        s1_im[2*i+1] <= ({x_im[2*i][7], x_im[2*i]} - {x_im[2*i+1][7], x_im[2*i+1]}) >>> 1;

      end
    end
  end

  // stage 2: butterfly + twiddle

  wire signed [7:0] j_s1_re_3 = -s1_im[3];
  wire signed [7:0] j_s1_im_3 = s1_re[3];
  wire signed [7:0] j_s1_re_7 = -s1_im[7];
  wire signed [7:0] j_s1_im_7 = s1_re[7];

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      for (i = 0; i < 8; i = i + 1) begin
        s2_re[i] <= 0;
        s2_im[i] <= 0;
      end
    end else begin
      s2_re[0] <= ({s1_re[0][7], s1_re[0]} + {s1_re[2][7], s1_re[2]}) >>> 1;
      s2_im[0] <= ({s1_im[0][7], s1_im[0]} + {s1_im[2][7], s1_im[2]}) >>> 1;

      s2_re[1] <= ({s1_re[1][7], s1_re[1]} - {j_s1_re_3[7], j_s1_re_3}) >>> 1;
      s2_im[1] <= ({s1_im[1][7], s1_im[1]} - {j_s1_im_3[7], j_s1_im_3}) >>> 1;

      s2_re[2] <= ({s1_re[0][7], s1_re[0]} - {s1_re[2][7], s1_re[2]}) >>> 1;
      s2_im[2] <= ({s1_im[0][7], s1_im[0]} - {s1_im[2][7], s1_im[2]}) >>> 1;

      s2_re[3] <= ({s1_re[1][7], s1_re[1]} + {j_s1_re_3[7], j_s1_re_3}) >>> 1;
      s2_im[3] <= ({s1_im[1][7], s1_im[1]} + {j_s1_im_3[7], j_s1_im_3}) >>> 1;

      s2_re[4] <= ({s1_re[4][7], s1_re[4]} + {s1_re[6][7], s1_re[6]}) >>> 1;
      s2_im[4] <= ({s1_im[4][7], s1_im[4]} + {s1_im[6][7], s1_im[6]}) >>> 1;

      s2_re[5] <= ({s1_re[5][7], s1_re[5]} - {j_s1_re_7[7], j_s1_re_7}) >>> 1;
      s2_im[5] <= ({s1_im[5][7], s1_im[5]} - {j_s1_im_7[7], j_s1_im_7}) >>> 1;

      s2_re[6] <= ({s1_re[4][7], s1_re[4]} - {s1_re[6][7], s1_re[6]}) >>> 1;
      s2_im[6] <= ({s1_im[4][7], s1_im[4]} - {s1_im[6][7], s1_im[6]}) >>> 1;

      s2_re[7] <= ({s1_re[5][7], s1_re[5]} + {j_s1_re_7[7], j_s1_re_7}) >>> 1;
      s2_im[7] <= ({s1_im[5][7], s1_im[5]} + {j_s1_im_7[7], j_s1_im_7}) >>> 1;

    end
  end

  // stage 3: final butterfly with twiddle
  wire signed [7:0] w_s2_re[3:0], w_s2_im[3:0];

  complex_mult m0 (
      s2_re[4],
      s2_im[4],
      w0_re,
      w0_im,
      w_s2_re[0],
      w_s2_im[0]
  );

  complex_mult m1 (
      s2_re[5],
      s2_im[5],
      w1_re,
      w1_im,
      w_s2_re[1],
      w_s2_im[1]
  );

  complex_mult m2 (
      s2_re[6],
      s2_im[6],
      w2_re,
      w2_im,
      w_s2_re[2],
      w_s2_im[2]
  );

  complex_mult m3 (
      s2_re[7],
      s2_im[7],
      w3_re,
      w3_im,
      w_s2_re[3],
      w_s2_im[3]
  );

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      for (i = 0; i < 8; i = i + 1) begin
        s3_re[i] <= 0;
        s3_im[i] <= 0;
      end
    end else begin
      for (i = 0; i < 4; i = i + 1) begin
        s3_re[i]   <= ({s2_re[i][7], s2_re[i]} + {w_s2_re[i][7], w_s2_re[i]}) >>> 1;
        s3_im[i]   <= ({s2_im[i][7], s2_im[i]} + {w_s2_im[i][7], w_s2_im[i]}) >>> 1;

        s3_re[i+4] <= ({s2_re[i][7], s2_re[i]} - {w_s2_re[i][7], w_s2_re[i]}) >>> 1;
        s3_im[i+4] <= ({s2_im[i][7], s2_im[i]} - {w_s2_im[i][7], w_s2_im[i]}) >>> 1;
      end
    end
  end

  assign y0_re = s3_re[0];
  assign y0_im = s3_im[0];
  assign y1_re = s3_re[1];
  assign y1_im = s3_im[1];
  assign y2_re = s3_re[2];
  assign y2_im = s3_im[2];
  assign y3_re = s3_re[3];
  assign y3_im = s3_im[3];
  assign y4_re = s3_re[4];
  assign y4_im = s3_im[4];
  assign y5_re = s3_re[5];
  assign y5_im = s3_im[5];
  assign y6_re = s3_re[6];
  assign y6_im = s3_im[6];
  assign y7_re = s3_re[7];
  assign y7_im = s3_im[7];


endmodule

module twiddle (
    output reg signed [7:0] w0_re,
    w1_re,
    w2_re,
    w3_re,
    output reg signed [7:0] w0_im,
    w1_im,
    w2_im,
    w3_im
);
  initial begin
    w0_re = 8'sh7F;
    w0_im = 8'sh00;  // w0 = 1 + j 0
    w1_re = 8'sh5B;
    w1_im = 8'shA5;  // cos(pi/4) - j sin(pi/4)
    w2_re = 8'sh00;
    w2_im = 8'sh80;  // 0 - j 1
    w3_re = 8'shA5;
    w3_im = 8'shA5;  // -cos(pi/4) - j sin(pi/4)
  end
endmodule

// Complex multiplier (Q1.7)
module complex_mult (
    input  signed [7:0] a_re,
    a_im,
    b_re,
    b_im,
    output signed [7:0] out_re,
    out_im
);
  wire signed [15:0] real_part, imag_part;
  assign real_part = (a_re * b_re - a_im * b_im) >>> 7;
  assign imag_part = (a_re * b_im + a_im * b_re) >>> 7;
  assign out_re = real_part[7:0];
  assign out_im = imag_part[7:0];
endmodule