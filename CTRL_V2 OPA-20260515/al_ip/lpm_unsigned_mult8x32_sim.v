// Verilog netlist created by TD v5.0.38657
// Fri Jun 16 17:27:51 2023

`timescale 1ns / 1ps
module lpm_unsigned_mult8x32  // lpm_unsigned_mult8x32.v(14)
  (
  a,
  b,
  p
  );

  input [9:0] a;  // lpm_unsigned_mult8x32.v(18)
  input [31:0] b;  // lpm_unsigned_mult8x32.v(19)
  output [41:0] p;  // lpm_unsigned_mult8x32.v(16)

  wire [23:0] n0;
  wire inst_0_0_0;
  wire inst_0_0_1;
  wire inst_0_0_10;
  wire inst_0_0_11;
  wire inst_0_0_12;
  wire inst_0_0_13;
  wire inst_0_0_14;
  wire inst_0_0_15;
  wire inst_0_0_16;
  wire inst_0_0_17;
  wire inst_0_0_18;
  wire inst_0_0_19;
  wire inst_0_0_2;
  wire inst_0_0_20;
  wire inst_0_0_21;
  wire inst_0_0_22;
  wire inst_0_0_23;
  wire inst_0_0_24;
  wire inst_0_0_25;
  wire inst_0_0_26;
  wire inst_0_0_27;
  wire inst_0_0_3;
  wire inst_0_0_4;
  wire inst_0_0_5;
  wire inst_0_0_6;
  wire inst_0_0_7;
  wire inst_0_0_8;
  wire inst_0_0_9;
  wire inst_0_1_0;
  wire inst_0_1_1;
  wire inst_0_1_10;
  wire inst_0_1_11;
  wire inst_0_1_12;
  wire inst_0_1_13;
  wire inst_0_1_14;
  wire inst_0_1_15;
  wire inst_0_1_16;
  wire inst_0_1_17;
  wire inst_0_1_18;
  wire inst_0_1_19;
  wire inst_0_1_2;
  wire inst_0_1_20;
  wire inst_0_1_21;
  wire inst_0_1_22;
  wire inst_0_1_23;
  wire inst_0_1_3;
  wire inst_0_1_4;
  wire inst_0_1_5;
  wire inst_0_1_6;
  wire inst_0_1_7;
  wire inst_0_1_8;
  wire inst_0_1_9;
  wire \inst_add_1/c0 ;
  wire \inst_add_1/c1 ;
  wire \inst_add_1/c10 ;
  wire \inst_add_1/c11 ;
  wire \inst_add_1/c12 ;
  wire \inst_add_1/c13 ;
  wire \inst_add_1/c14 ;
  wire \inst_add_1/c15 ;
  wire \inst_add_1/c16 ;
  wire \inst_add_1/c17 ;
  wire \inst_add_1/c18 ;
  wire \inst_add_1/c19 ;
  wire \inst_add_1/c2 ;
  wire \inst_add_1/c20 ;
  wire \inst_add_1/c21 ;
  wire \inst_add_1/c22 ;
  wire \inst_add_1/c23 ;
  wire \inst_add_1/c3 ;
  wire \inst_add_1/c4 ;
  wire \inst_add_1/c5 ;
  wire \inst_add_1/c6 ;
  wire \inst_add_1/c7 ;
  wire \inst_add_1/c8 ;
  wire \inst_add_1/c9 ;

  assign p[41] = n0[23];
  assign p[40] = n0[22];
  assign p[39] = n0[21];
  assign p[38] = n0[20];
  assign p[37] = n0[19];
  assign p[36] = n0[18];
  assign p[35] = n0[17];
  assign p[34] = n0[16];
  assign p[33] = n0[15];
  assign p[32] = n0[14];
  assign p[31] = n0[13];
  assign p[30] = n0[12];
  assign p[29] = n0[11];
  assign p[28] = n0[10];
  assign p[27] = n0[9];
  assign p[26] = n0[8];
  assign p[25] = n0[7];
  assign p[24] = n0[6];
  assign p[23] = n0[5];
  assign p[22] = n0[4];
  assign p[21] = n0[3];
  assign p[20] = n0[2];
  assign p[19] = n0[1];
  assign p[18] = n0[0];
  assign p[17] = inst_0_0_17;
  assign p[16] = inst_0_0_16;
  assign p[15] = inst_0_0_15;
  assign p[14] = inst_0_0_14;
  assign p[13] = inst_0_0_13;
  assign p[12] = inst_0_0_12;
  assign p[11] = inst_0_0_11;
  assign p[10] = inst_0_0_10;
  assign p[9] = inst_0_0_9;
  assign p[8] = inst_0_0_8;
  assign p[7] = inst_0_0_7;
  assign p[6] = inst_0_0_6;
  assign p[5] = inst_0_0_5;
  assign p[4] = inst_0_0_4;
  assign p[3] = inst_0_0_3;
  assign p[2] = inst_0_0_2;
  assign p[1] = inst_0_0_1;
  assign p[0] = inst_0_0_0;
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
    inst_0_0_ (
    .a({8'b00000000,a}),
    .b(b[17:0]),
    .p({open_n130,open_n131,open_n132,open_n133,open_n134,open_n135,open_n136,open_n137,inst_0_0_27,inst_0_0_26,inst_0_0_25,inst_0_0_24,inst_0_0_23,inst_0_0_22,inst_0_0_21,inst_0_0_20,inst_0_0_19,inst_0_0_18,inst_0_0_17,inst_0_0_16,inst_0_0_15,inst_0_0_14,inst_0_0_13,inst_0_0_12,inst_0_0_11,inst_0_0_10,inst_0_0_9,inst_0_0_8,inst_0_0_7,inst_0_0_6,inst_0_0_5,inst_0_0_4,inst_0_0_3,inst_0_0_2,inst_0_0_1,inst_0_0_0}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    inst_0_1_ (
    .a({8'b00000000,a}),
    .b({4'b0000,b[31:18]}),
    .p({open_n221,open_n222,open_n223,open_n224,open_n225,open_n226,open_n227,open_n228,open_n229,open_n230,open_n231,open_n232,inst_0_1_23,inst_0_1_22,inst_0_1_21,inst_0_1_20,inst_0_1_19,inst_0_1_18,inst_0_1_17,inst_0_1_16,inst_0_1_15,inst_0_1_14,inst_0_1_13,inst_0_1_12,inst_0_1_11,inst_0_1_10,inst_0_1_9,inst_0_1_8,inst_0_1_7,inst_0_1_6,inst_0_1_5,inst_0_1_4,inst_0_1_3,inst_0_1_2,inst_0_1_1,inst_0_1_0}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u0  (
    .a(inst_0_0_18),
    .b(inst_0_1_0),
    .c(\inst_add_1/c0 ),
    .o({\inst_add_1/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u1  (
    .a(inst_0_0_19),
    .b(inst_0_1_1),
    .c(\inst_add_1/c1 ),
    .o({\inst_add_1/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u10  (
    .a(1'b0),
    .b(inst_0_1_10),
    .c(\inst_add_1/c10 ),
    .o({\inst_add_1/c11 ,n0[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u11  (
    .a(1'b0),
    .b(inst_0_1_11),
    .c(\inst_add_1/c11 ),
    .o({\inst_add_1/c12 ,n0[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u12  (
    .a(1'b0),
    .b(inst_0_1_12),
    .c(\inst_add_1/c12 ),
    .o({\inst_add_1/c13 ,n0[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u13  (
    .a(1'b0),
    .b(inst_0_1_13),
    .c(\inst_add_1/c13 ),
    .o({\inst_add_1/c14 ,n0[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u14  (
    .a(1'b0),
    .b(inst_0_1_14),
    .c(\inst_add_1/c14 ),
    .o({\inst_add_1/c15 ,n0[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u15  (
    .a(1'b0),
    .b(inst_0_1_15),
    .c(\inst_add_1/c15 ),
    .o({\inst_add_1/c16 ,n0[15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u16  (
    .a(1'b0),
    .b(inst_0_1_16),
    .c(\inst_add_1/c16 ),
    .o({\inst_add_1/c17 ,n0[16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u17  (
    .a(1'b0),
    .b(inst_0_1_17),
    .c(\inst_add_1/c17 ),
    .o({\inst_add_1/c18 ,n0[17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u18  (
    .a(1'b0),
    .b(inst_0_1_18),
    .c(\inst_add_1/c18 ),
    .o({\inst_add_1/c19 ,n0[18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u19  (
    .a(1'b0),
    .b(inst_0_1_19),
    .c(\inst_add_1/c19 ),
    .o({\inst_add_1/c20 ,n0[19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u2  (
    .a(inst_0_0_20),
    .b(inst_0_1_2),
    .c(\inst_add_1/c2 ),
    .o({\inst_add_1/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u20  (
    .a(1'b0),
    .b(inst_0_1_20),
    .c(\inst_add_1/c20 ),
    .o({\inst_add_1/c21 ,n0[20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u21  (
    .a(1'b0),
    .b(inst_0_1_21),
    .c(\inst_add_1/c21 ),
    .o({\inst_add_1/c22 ,n0[21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u22  (
    .a(1'b0),
    .b(inst_0_1_22),
    .c(\inst_add_1/c22 ),
    .o({\inst_add_1/c23 ,n0[22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u23  (
    .a(1'b0),
    .b(inst_0_1_23),
    .c(\inst_add_1/c23 ),
    .o({open_n233,n0[23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u3  (
    .a(inst_0_0_21),
    .b(inst_0_1_3),
    .c(\inst_add_1/c3 ),
    .o({\inst_add_1/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u4  (
    .a(inst_0_0_22),
    .b(inst_0_1_4),
    .c(\inst_add_1/c4 ),
    .o({\inst_add_1/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u5  (
    .a(inst_0_0_23),
    .b(inst_0_1_5),
    .c(\inst_add_1/c5 ),
    .o({\inst_add_1/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u6  (
    .a(inst_0_0_24),
    .b(inst_0_1_6),
    .c(\inst_add_1/c6 ),
    .o({\inst_add_1/c7 ,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u7  (
    .a(inst_0_0_25),
    .b(inst_0_1_7),
    .c(\inst_add_1/c7 ),
    .o({\inst_add_1/c8 ,n0[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u8  (
    .a(inst_0_0_26),
    .b(inst_0_1_8),
    .c(\inst_add_1/c8 ),
    .o({\inst_add_1/c9 ,n0[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \inst_add_1/u9  (
    .a(inst_0_0_27),
    .b(inst_0_1_9),
    .c(\inst_add_1/c9 ),
    .o({\inst_add_1/c10 ,n0[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \inst_add_1/ucin  (
    .a(1'b0),
    .o({\inst_add_1/c0 ,open_n236}));

endmodule 

