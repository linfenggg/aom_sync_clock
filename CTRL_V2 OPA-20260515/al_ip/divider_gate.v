// Verilog netlist created by Tang Dynasty v5.6.56362
// Wed Aug 16 09:36:25 2023

`timescale 1ns / 1ps
module divider
  (
  clk,
  denominator,
  numerator,
  rst,
  start,
  done,
  quotient,
  remainder
  );

  input clk;
  input [7:0] denominator;
  input [7:0] numerator;
  input rst;
  input start;
  output done;
  output [7:0] quotient;
  output [7:0] remainder;

  parameter S_DEN = "UNSIGNED";
  parameter S_NUM = "UNSIGNED";
  parameter W_DEN = 8;
  parameter W_NUM = 8;
  // localparam W_CNT = 4;
  wire [3:0] al_1deac949;
  wire [3:0] al_d0dc52fd;
  wire [14:0] al_11033702;
  wire [14:0] al_1c1b24e7;
  wire [7:0] al_1315ed94;
  wire [7:0] al_9bfb1470;
  wire [14:0] al_c67bebad;
  wire [7:0] al_327525b3;
  wire al_9673d977;
  wire al_a9fbe072;
  wire al_3973d008;
  wire al_4c40b6e5;
  wire al_d63e42fe;
  wire al_b4fc1000;
  wire al_ab829401;
  wire al_b7ca2ed;
  wire al_22a7ce9f;
  wire al_f5902502;
  wire al_b83a67b2;
  wire al_540b209;
  wire al_27e1f3bc;
  wire al_e64e5f1c;
  wire al_e761a920;
  wire al_42ead886;
  wire al_fafc8f53;
  wire al_33de60a;
  wire al_3ae4de70;
  wire al_ff46470e;
  wire al_bc96c084;
  wire al_bc93f476;
  wire al_bea0d2b8;
  wire al_368990f0;
  wire al_114eba31;
  wire al_c61b4192;

  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    al_dc50342 (
    .a(al_1deac949[0]),
    .b(al_1deac949[1]),
    .c(al_1deac949[2]),
    .d(al_1deac949[3]),
    .o(al_114eba31));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(~B*~(~E*~D*~C)))"),
    .INIT(32'hbbbbbbba))
    al_f17cd423 (
    .a(start),
    .b(al_1deac949[0]),
    .c(al_1deac949[1]),
    .d(al_1deac949[2]),
    .e(al_1deac949[3]),
    .o(al_d0dc52fd[0]));
  AL_MAP_LUT5 #(
    .EQN("(~A*(B*~(C)*~((E*~D))+~(B)*C*~((E*~D))+~(B)*C*(E*~D)))"),
    .INIT(32'h14101414))
    al_147e6a1b (
    .a(start),
    .b(al_1deac949[0]),
    .c(al_1deac949[1]),
    .d(al_1deac949[2]),
    .e(al_1deac949[3]),
    .o(al_d0dc52fd[1]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(D@(C*B)))"),
    .INIT(16'h1540))
    al_c8620855 (
    .a(start),
    .b(al_1deac949[0]),
    .c(al_1deac949[1]),
    .d(al_1deac949[2]),
    .o(al_d0dc52fd[2]));
  AL_MAP_LUT5 #(
    .EQN("(~A*(B*C*D*~(E)+~(B)*~(C)*~(D)*E+~(B)*C*~(D)*E+B*C*~(D)*E+~(B)*~(C)*D*E+B*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'h15514000))
    al_6614de08 (
    .a(start),
    .b(al_1deac949[0]),
    .c(al_1deac949[1]),
    .d(al_1deac949[2]),
    .e(al_1deac949[3]),
    .o(al_d0dc52fd[3]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_cde08279 (
    .a(denominator[3]),
    .b(start),
    .c(al_11033702[11]),
    .o(al_1c1b24e7[10]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_524ec5be (
    .a(denominator[4]),
    .b(start),
    .c(al_11033702[12]),
    .o(al_1c1b24e7[11]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_14abf2aa (
    .a(denominator[5]),
    .b(start),
    .c(al_11033702[13]),
    .o(al_1c1b24e7[12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_c4e8f3cf (
    .a(denominator[6]),
    .b(start),
    .c(al_11033702[14]),
    .o(al_1c1b24e7[13]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_d41af768 (
    .a(denominator[0]),
    .b(start),
    .c(al_11033702[8]),
    .o(al_1c1b24e7[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_536f7df3 (
    .a(denominator[1]),
    .b(start),
    .c(al_11033702[9]),
    .o(al_1c1b24e7[8]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    al_c7595fbe (
    .a(denominator[2]),
    .b(start),
    .c(al_11033702[10]),
    .o(al_1c1b24e7[9]));
  AL_DFF_0 al_35b11324 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_114eba31),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(done));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    al_2c0796e5 (
    .a(1'b1),
    .o({al_9673d977,open_n2}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_c203f32c (
    .a(al_11033702[4]),
    .b(al_1315ed94[4]),
    .c(al_d63e42fe),
    .o({al_b4fc1000,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_5a2e66a8 (
    .a(al_11033702[5]),
    .b(al_1315ed94[5]),
    .c(al_b4fc1000),
    .o({al_ab829401,open_n4}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_2f287d12 (
    .a(al_11033702[6]),
    .b(al_1315ed94[6]),
    .c(al_ab829401),
    .o({al_b7ca2ed,open_n5}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_9ce86edd (
    .a(al_11033702[7]),
    .b(al_1315ed94[7]),
    .c(al_b7ca2ed),
    .o({al_22a7ce9f,open_n6}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_29f6525 (
    .a(al_11033702[8]),
    .b(1'b0),
    .c(al_22a7ce9f),
    .o({al_f5902502,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_f171b4f4 (
    .a(al_11033702[0]),
    .b(al_1315ed94[0]),
    .c(al_9673d977),
    .o({al_a9fbe072,open_n8}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_e9c7012b (
    .a(al_11033702[9]),
    .b(1'b0),
    .c(al_f5902502),
    .o({al_b83a67b2,open_n9}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_4226b3d1 (
    .a(al_11033702[10]),
    .b(1'b0),
    .c(al_b83a67b2),
    .o({al_540b209,open_n10}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_3f6fc47e (
    .a(al_11033702[11]),
    .b(1'b0),
    .c(al_540b209),
    .o({al_27e1f3bc,open_n11}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_e17073e0 (
    .a(al_11033702[12]),
    .b(1'b0),
    .c(al_27e1f3bc),
    .o({al_e64e5f1c,open_n12}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_ba5a9770 (
    .a(al_11033702[13]),
    .b(1'b0),
    .c(al_e64e5f1c),
    .o({al_e761a920,open_n13}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_cb976531 (
    .a(al_11033702[14]),
    .b(1'b0),
    .c(al_e761a920),
    .o({al_42ead886,open_n14}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_e5cd5640 (
    .a(1'b0),
    .b(1'b1),
    .c(al_42ead886),
    .o({open_n15,al_c61b4192}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_441ad9b2 (
    .a(al_11033702[1]),
    .b(al_1315ed94[1]),
    .c(al_a9fbe072),
    .o({al_3973d008,open_n16}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_9395428b (
    .a(al_11033702[2]),
    .b(al_1315ed94[2]),
    .c(al_3973d008),
    .o({al_4c40b6e5,open_n17}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    al_f7ac689a (
    .a(al_11033702[3]),
    .b(al_1315ed94[3]),
    .c(al_4c40b6e5),
    .o({al_d63e42fe,open_n18}));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_affc23c8 (
    .a(numerator[0]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[0]),
    .e(al_c67bebad[0]),
    .o(al_9bfb1470[0]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_db832082 (
    .a(numerator[1]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[1]),
    .e(al_c67bebad[1]),
    .o(al_9bfb1470[1]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_3e04c0e7 (
    .a(numerator[2]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[2]),
    .e(al_c67bebad[2]),
    .o(al_9bfb1470[2]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_b86e3fac (
    .a(numerator[3]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[3]),
    .e(al_c67bebad[3]),
    .o(al_9bfb1470[3]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_1f499def (
    .a(numerator[4]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[4]),
    .e(al_c67bebad[4]),
    .o(al_9bfb1470[4]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_8f1711f3 (
    .a(numerator[5]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[5]),
    .e(al_c67bebad[5]),
    .o(al_9bfb1470[5]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_6e1c653d (
    .a(numerator[6]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[6]),
    .e(al_c67bebad[6]),
    .o(al_9bfb1470[6]));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)*~(B)+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*~(B)+~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*A*B+(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A*B)"),
    .INIT(32'hbbb88b88))
    al_b46e3fd7 (
    .a(numerator[7]),
    .b(start),
    .c(al_c61b4192),
    .d(al_1315ed94[7]),
    .e(al_c67bebad[7]),
    .o(al_9bfb1470[7]));
  AL_DFF_0 al_b26d62bf (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_d0dc52fd[0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1deac949[0]));
  AL_DFF_0 al_809f7104 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_d0dc52fd[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1deac949[1]));
  AL_DFF_0 al_c1468025 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_d0dc52fd[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1deac949[2]));
  AL_DFF_0 al_c19d8344 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_d0dc52fd[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1deac949[3]));
  AL_DFF_0 al_b40e8e05 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[8]));
  AL_DFF_0 al_2259e8d1 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[9]));
  AL_DFF_0 al_5f624aaf (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[10]));
  AL_DFF_0 al_d532b054 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[11]));
  AL_DFF_0 al_9d987fc8 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[12]));
  AL_DFF_0 al_220744cc (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[13]));
  AL_DFF_0 al_e241f44a (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(denominator[7]),
    .en(1'b1),
    .sr(~start),
    .ss(1'b0),
    .q(al_11033702[14]));
  AL_DFF_0 al_fd544ba8 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[1]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[0]));
  AL_DFF_0 al_40ebe0d4 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[2]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[1]));
  AL_DFF_0 al_b4cd3408 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[3]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[2]));
  AL_DFF_0 al_16607eff (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[4]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[3]));
  AL_DFF_0 al_2e1082f (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[5]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[4]));
  AL_DFF_0 al_806f02ed (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[6]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[5]));
  AL_DFF_0 al_e97bb64b (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_11033702[7]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_11033702[6]));
  AL_DFF_0 al_f7f2da08 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_1c1b24e7[7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_11033702[7]));
  AL_DFF_0 al_16ad90bc (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[0]));
  AL_DFF_0 al_e1044ec0 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[1]));
  AL_DFF_0 al_16da6de4 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[2]));
  AL_DFF_0 al_e819e904 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[3]));
  AL_DFF_0 al_4990808d (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[4]));
  AL_DFF_0 al_d51e17ed (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[5]));
  AL_DFF_0 al_b67f884b (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[6]));
  AL_DFF_0 al_ff3308ea (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_9bfb1470[7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(al_1315ed94[7]));
  AL_DFF_0 al_53efe64b (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[0]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[0]));
  AL_DFF_0 al_26890f76 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[1]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[1]));
  AL_DFF_0 al_802c7023 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[2]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[2]));
  AL_DFF_0 al_9c45670 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[3]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[3]));
  AL_DFF_0 al_b0a0e999 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[4]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[4]));
  AL_DFF_0 al_739d9f2f (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[5]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[5]));
  AL_DFF_0 al_7f9eee7d (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[6]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[6]));
  AL_DFF_0 al_741313a7 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[7]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(quotient[7]));
  AL_DFF_0 al_5e904a35 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_c61b4192),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[0]));
  AL_DFF_0 al_116f1db3 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[0]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[1]));
  AL_DFF_0 al_6c993e82 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[1]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[2]));
  AL_DFF_0 al_23963ea6 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[2]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[3]));
  AL_DFF_0 al_6c25cf29 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[3]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[4]));
  AL_DFF_0 al_e7cc423c (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[4]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[5]));
  AL_DFF_0 al_2c6ea385 (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[5]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[6]));
  AL_DFF_0 al_a356779f (
    .ar(1'b0),
    .as(1'b0),
    .clk(clk),
    .d(al_327525b3[6]),
    .en(1'b1),
    .sr(start),
    .ss(1'b0),
    .q(al_327525b3[7]));
  AL_DFF_0 al_cbbb4490 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[0]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[0]));
  AL_DFF_0 al_30153836 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[1]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[1]));
  AL_DFF_0 al_37ead40d (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[2]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[2]));
  AL_DFF_0 al_7625712c (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[3]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[3]));
  AL_DFF_0 al_2531de5d (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[4]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[4]));
  AL_DFF_0 al_2ccbdc6d (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[5]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[5]));
  AL_DFF_0 al_2c62c395 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[6]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[6]));
  AL_DFF_0 al_ee1990ef (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(al_1315ed94[7]),
    .en(al_114eba31),
    .sr(1'b0),
    .ss(1'b0),
    .q(remainder[7]));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_8b9c8457 (
    .a(al_1315ed94[7]),
    .b(al_11033702[7]),
    .c(al_368990f0),
    .o({open_n19,al_c67bebad[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    al_f5224f5b (
    .a(1'b0),
    .o({al_fafc8f53,open_n22}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_e6e3dfcf (
    .a(al_1315ed94[0]),
    .b(al_11033702[0]),
    .c(al_fafc8f53),
    .o({al_33de60a,al_c67bebad[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_68abff86 (
    .a(al_1315ed94[1]),
    .b(al_11033702[1]),
    .c(al_33de60a),
    .o({al_3ae4de70,al_c67bebad[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_8de058bd (
    .a(al_1315ed94[2]),
    .b(al_11033702[2]),
    .c(al_3ae4de70),
    .o({al_ff46470e,al_c67bebad[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_bbd4c846 (
    .a(al_1315ed94[3]),
    .b(al_11033702[3]),
    .c(al_ff46470e),
    .o({al_bc96c084,al_c67bebad[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_222b6767 (
    .a(al_1315ed94[4]),
    .b(al_11033702[4]),
    .c(al_bc96c084),
    .o({al_bc93f476,al_c67bebad[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_9c7fbfa5 (
    .a(al_1315ed94[5]),
    .b(al_11033702[5]),
    .c(al_bc93f476),
    .o({al_bea0d2b8,al_c67bebad[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    al_fd218d47 (
    .a(al_1315ed94[6]),
    .b(al_11033702[6]),
    .c(al_bea0d2b8),
    .o({al_368990f0,al_c67bebad[6]}));

endmodule 

