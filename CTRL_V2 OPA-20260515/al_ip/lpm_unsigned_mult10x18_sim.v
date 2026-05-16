// Verilog netlist created by TD v5.0.38657
// Tue Jul 18 16:19:46 2023

`timescale 1ns / 1ps
module lpm_unsigned_mult10x18  // lpm_unsigned_mult10x18.v(14)
  (
  a,
  b,
  p
  );

  input [9:0] a;  // lpm_unsigned_mult10x18.v(18)
  input [17:0] b;  // lpm_unsigned_mult10x18.v(19)
  output [27:0] p;  // lpm_unsigned_mult10x18.v(16)


  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_ (
    .a({8'b00000000,a}),
    .b(b),
    .p({open_n130,open_n131,open_n132,open_n133,open_n134,open_n135,open_n136,open_n137,p}));

endmodule 

