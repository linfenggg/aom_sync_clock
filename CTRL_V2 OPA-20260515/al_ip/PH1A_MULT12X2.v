// Verilog netlist created by Tang Dynasty v5.6.97693
// Wed Sep 11 14:34:23 2024

`timescale 1ns / 1ps
module PH1A_MULT12X2
  (
  a,
  y,
  p
  ); /* synthesis keep_hierarchy=true */ 

  input [17:0] a;
  input [3:0] y;
  output [21:0] p;

  wire [44:0] mult0_syn_2;
  wire [53:0] mult0_syn_20;

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
    .x({a[17],a[17],a[17],a[17],a[17],a[17],a[17],a[17],a[17],a}),
    .y({y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y[3],y}),
    .p({mult0_syn_20[44:22],mult0_syn_2[21:0]}));

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

