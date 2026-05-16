// Verilog netlist created by Tang Dynasty v5.6.97693
// Sat Sep 14 10:08:27 2024

`timescale 1ns / 1ps
module PH1A_MULT8X32
  (
  a,
  y,
  p
  ); /* synthesis keep_hierarchy=true */ 

  input [17:0] a;
  input [39:0] y;
  output [57:0] p;

  wire [53:0] mult0_syn_178;
  wire [44:0] mult0_syn_2;
  wire [44:0] mult0_syn_278;
  wire [53:0] mult0_syn_405;
  wire [44:0] mult0_syn_48;
  wire [53:0] mult0_syn_94;

  assign p[57] = mult0_syn_48[40];
  assign p[56] = mult0_syn_48[39];
  assign p[55] = mult0_syn_48[38];
  assign p[54] = mult0_syn_48[37];
  assign p[53] = mult0_syn_48[36];
  assign p[52] = mult0_syn_48[35];
  assign p[51] = mult0_syn_48[34];
  assign p[50] = mult0_syn_48[33];
  assign p[49] = mult0_syn_48[32];
  assign p[48] = mult0_syn_48[31];
  assign p[47] = mult0_syn_48[30];
  assign p[46] = mult0_syn_48[29];
  assign p[45] = mult0_syn_48[28];
  assign p[44] = mult0_syn_48[27];
  assign p[43] = mult0_syn_48[26];
  assign p[42] = mult0_syn_48[25];
  assign p[41] = mult0_syn_48[24];
  assign p[40] = mult0_syn_48[23];
  assign p[39] = mult0_syn_48[22];
  assign p[38] = mult0_syn_48[21];
  assign p[37] = mult0_syn_48[20];
  assign p[36] = mult0_syn_48[19];
  assign p[35] = mult0_syn_48[18];
  assign p[34] = mult0_syn_48[17];
  assign p[33] = mult0_syn_48[16];
  assign p[32] = mult0_syn_48[15];
  assign p[31] = mult0_syn_48[14];
  assign p[30] = mult0_syn_48[13];
  assign p[29] = mult0_syn_48[12];
  assign p[28] = mult0_syn_48[11];
  assign p[27] = mult0_syn_48[10];
  assign p[26] = mult0_syn_48[9];
  assign p[25] = mult0_syn_48[8];
  assign p[24] = mult0_syn_48[7];
  assign p[23] = mult0_syn_48[6];
  assign p[22] = mult0_syn_48[5];
  assign p[21] = mult0_syn_48[4];
  assign p[20] = mult0_syn_48[3];
  assign p[19] = mult0_syn_48[2];
  assign p[18] = mult0_syn_48[1];
  assign p[17] = mult0_syn_48[0];
  assign p[16] = mult0_syn_2[16];
  assign p[15] = mult0_syn_2[15];
  assign p[14] = mult0_syn_2[14];
  assign p[13] = mult0_syn_2[13];
  assign p[12] = mult0_syn_2[12];
  assign p[11] = mult0_syn_2[11];
  assign p[10] = mult0_syn_2[10];
  assign p[9] = mult0_syn_2[9];
  assign p[8] = mult0_syn_2[8];
  assign p[7] = mult0_syn_2[7];
  assign p[6] = mult0_syn_2[6];
  assign p[5] = mult0_syn_2[5];
  assign p[4] = mult0_syn_2[4];
  assign p[3] = mult0_syn_2[3];
  assign p[2] = mult0_syn_2[2];
  assign p[1] = mult0_syn_2[1];
  assign p[0] = mult0_syn_2[0];
  PH1_PHY_DSPMULT
    \mult0_syn_148/_mult  (
    .opctrl(2'b11),
    .x({y[39],y[39],y[39],y[39],y[39:17]}),
    .y(a),
    .p(mult0_syn_278));
  PH1_PHY_DSPTADD #(
    .CI_INVERT("NO"),
    .INV_OPCTRL(4'b0000),
    .RND_CONST(54'b0),
    .USE_OVERFLOW("S53"),
    .X1_EXTEND("YES"),
    .Y1_ROUND("NO"),
    .Z1_SHIFT("YES"))
    \mult0_syn_148/_tadd  (
    .ci(1'b0),
    .ci_special(1'b0),
    .opctrl(9'b010100000),
    .x1_special({mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278[44],mult0_syn_278}),
    .y0(54'b000000000000000000000000000000000000000000000000000000),
    .y1_special(54'b000000000000000000000000000000000000000000000000000000),
    .z0({mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44:0]}),
    .z1_special({mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44],mult0_syn_94[44:0]}),
    .sum({mult0_syn_405[53:41],mult0_syn_48[40:0]}));
  PH1_PHY_DSPMULT
    \mult0_syn_93/_mult  (
    .opctrl(2'b11),
    .x({a[17],a[17],a[17],a[17],a[17],a[17],a[17],a[17],a[17],a}),
    .y({1'b0,y[16:0]}),
    .p({mult0_syn_178[44:17],mult0_syn_2[16:0]}));
  PH1_PHY_DSPMREG #(
    .CEMUX("1"),
    .CLKMUX("SIG"),
    .DYNAMIC_DATA("D"),
    .RSTMODE("ASYNC"),
    .RSTMUX("0"),
    .WIDTH(54))
    \mult0_syn_93/cpo_mreg  (
    .d({mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44],mult0_syn_178[44:17],mult0_syn_2[16:0]}),
    .opctrl(1'b1),
    .dynamic_q({open_n60,open_n61,open_n62,open_n63,open_n64,open_n65,open_n66,open_n67,open_n68,mult0_syn_94[44:0]}));

  // synthesis translate_off
  glbl glbl();
  always @(*) begin
    glbl.gsr <= PH1_PHY_GSR.gsr;
    glbl.gsrn <= PH1_PHY_GSR.gsrn;
    glbl.done_gwe <= PH1_PHY_GSR.done_gwe;
    glbl.usr_gsrn_en <= PH1_PHY_GSR.usr_gsrn_en;
  end
  // synthesis translate_on

endmodule 

