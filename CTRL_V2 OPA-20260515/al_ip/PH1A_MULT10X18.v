// Verilog netlist created by Tang Dynasty v5.6.97693
// Sat Sep 14 10:07:42 2024

`timescale 1ns / 1ps
module PH1A_MULT10X18
  (
  a,
  y,
  p
  ); /* synthesis keep_hierarchy=true */ 

  input [17:0] a;
  input [23:0] y;
  output [41:0] p;

  wire [44:0] mult0_syn_2;
  wire [53:0] mult0_syn_62;

  assign p[41] = mult0_syn_2[41];
  assign p[40] = mult0_syn_2[40];
  assign p[39] = mult0_syn_2[39];
  assign p[38] = mult0_syn_2[38];
  assign p[37] = mult0_syn_2[37];
  assign p[36] = mult0_syn_2[36];
  assign p[35] = mult0_syn_2[35];
  assign p[34] = mult0_syn_2[34];
  assign p[33] = mult0_syn_2[33];
  assign p[32] = mult0_syn_2[32];
  assign p[31] = mult0_syn_2[31];
  assign p[30] = mult0_syn_2[30];
  assign p[29] = mult0_syn_2[29];
  assign p[28] = mult0_syn_2[28];
  assign p[27] = mult0_syn_2[27];
  assign p[26] = mult0_syn_2[26];
  assign p[25] = mult0_syn_2[25];
  assign p[24] = mult0_syn_2[24];
  assign p[23] = mult0_syn_2[23];
  assign p[22] = mult0_syn_2[22];
  assign p[21] = mult0_syn_2[21];
  assign p[20] = mult0_syn_2[20];
  assign p[19] = mult0_syn_2[19];
  assign p[18] = mult0_syn_2[18];
  assign p[17] = mult0_syn_2[17];
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
    \mult0_syn_47/_mult  (
    .opctrl(2'b11),
    .x({y[23],y[23],y[23],y}),
    .y(a),
    .p({mult0_syn_62[44:42],mult0_syn_2[41:0]}));

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

