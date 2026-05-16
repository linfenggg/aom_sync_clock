module alarm_mon(
	input			clk_i,		//50m 20ns
	input			rstn_i,

	input 			PTOTE_PD1,	//断纤,算法告警，1告警
	input 			PTOTE_PD2,	//烧纤
	input			PTOTE_PD3,	//烧纤
	input 			LOW_24V,
	input			INTER_LOCK1,	
	input 			INTER_LOCK2,	
	input 			MCU_ERR,
	input 			MCU_ESTOP,
	input [15:0]	ONLINE_DATA1	,
	input [15:0]	ONLINE_DATA2	,
	input [15:0]	SEQ_ALM			,
	input 			pll_alm			,
	input 			mode_lock_alm	,

	input 			SEED_OK,
	input 			PD1_LOW_ALM	,
	input 			PD2_LOW_ALM ,
	input 			PD3_LOW_ALM ,
	input [16:0]	PD1_freq	,
	input [15:0]	PD2_freq    ,
	input [15:0]	PD3_freq    ,
	input [16:0]	FREQ1_THR_H	,
	input [15:0]	FREQ2_THR_H ,
	input [15:0]	FREQ3_THR_H ,
	
	input [31:0]	alarm_en,	//告警屏蔽
	input			clear,		//清除所有告警
	
	output [31:0]	alarm_now,	//当前告警
	output [31:0]	alarm_lat,	//历史告警
	output [31:0] 	alarm_out,	//总告警，高级加低级
	
    input 			PANEL_KEY,  //面板钥匙开关,
    input			PANEL_ESTOP,//面板急停开关
    input           HEAD_ERROR,	//激光头报警信号
	input  [31:0]	alarm_en2,	//告警屏蔽
	output [31:0]	alarm_now2,	//当前告警
	output [31:0]	alarm_lat2,	//历史告警
	output [31:0] 	alarm_out2,	//总告警，高级加低级

	output reg 			error	,	//任何告警输出，低级告警
	output reg 			lock	,	//锁机输出,高级告警
	output reg [1:0]	FPGA_SW		//关断保护，正常输出1，异常输出0
);

reg  	volt_low_alarm;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		FPGA_SW <= 2'b00;
	else if(lock)	//高级告警关电源
		FPGA_SW <= 2'b00;
	else
		FPGA_SW <= 2'b11;
//低级报警
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		error <= 0;
	else if(alarm_now[14] || alarm_now[31])
		error <= 1;
	else 
		error <= 0;
//高级报警
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		lock <= 0;
	else if({alarm_lat[30:15],alarm_lat[13:0]} != 0  || alarm_lat2[2:0]!= 0)
		lock <= 1;
	else 
		lock <= 0;

//有一个欠压报警发生后，该标志位置1，其他关联的欠压报警不再产生，避免连串报警
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		volt_low_alarm <= 0;
	else if({alarm_lat[30:15],alarm_lat[3]} != 0)	//任意一个欠压告警
		volt_low_alarm <= 1;
	else 
		volt_low_alarm <= 0;

assign alarm_out[0] = alarm_lat[0];		assign alarm_out[16] = alarm_lat[16];
assign alarm_out[1] = alarm_lat[1];		assign alarm_out[17] = alarm_lat[17];
assign alarm_out[2] = alarm_lat[2];		assign alarm_out[18] = alarm_lat[18];
assign alarm_out[3] = alarm_lat[3];		assign alarm_out[19] = alarm_lat[19];
assign alarm_out[4] = alarm_lat[4];		assign alarm_out[20] = alarm_lat[20];
assign alarm_out[5] = alarm_lat[5];		assign alarm_out[21] = alarm_lat[21];
assign alarm_out[6] = alarm_lat[6];		assign alarm_out[22] = alarm_lat[22];
assign alarm_out[7] = alarm_lat[7];		assign alarm_out[23] = alarm_lat[23];
assign alarm_out[8]  = alarm_lat[8];	assign alarm_out[24] = alarm_lat[24];	
assign alarm_out[9]  = alarm_lat[9];	assign alarm_out[25] = alarm_lat[25];	
assign alarm_out[10] = alarm_lat[10];	assign alarm_out[26] = alarm_lat[26];
assign alarm_out[11] = alarm_lat[11];	assign alarm_out[27] = alarm_lat[27];
assign alarm_out[12] = alarm_lat[12];	assign alarm_out[28] = alarm_lat[28];
assign alarm_out[13] = alarm_lat[13];	assign alarm_out[29] = alarm_lat[29];
assign alarm_out[14] = alarm_now[14];	assign alarm_out[30] = alarm_lat[30];
assign alarm_out[15] = alarm_lat[15];	assign alarm_out[31] = alarm_lat[31];

assign alarm_out2[0] = alarm_lat2[0];
assign alarm_out2[1] = alarm_lat2[1];
assign alarm_out2[2] = alarm_lat2[2];
reg [28:0]	cnt; 	//0.5s = 500_000_000 / 20  = 25_000_000
reg 		volt_ok;
parameter CNT_MAX = 100_000_000*2-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt <= 0;
	else if(FPGA_SW == 2'B00)
		cnt <= 0;
	else if(cnt < CNT_MAX)
		cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)		
		volt_ok <= 0;
	else if(cnt == CNT_MAX)
		volt_ok <= 1;
	else 
		volt_ok <= 0;

reg [16:0]		PD1_freq_reg0,PD1_freq_reg1,PD1_freq_reg2;
reg [15:0]		PD2_freq_reg0,PD2_freq_reg1,PD2_freq_reg2;
reg [15:0]		PD3_freq_reg0,PD3_freq_reg1,PD3_freq_reg2;

always @(posedge clk_i or negedge rstn_i) 
	if(!rstn_i)	begin 
		PD1_freq_reg0 <= 0;
        PD2_freq_reg0 <= 0;
        PD3_freq_reg0 <= 0;
		PD1_freq_reg1 <= 0;
		PD2_freq_reg1 <= 0;
		PD3_freq_reg1 <= 0;
		PD1_freq_reg2 <= 0;
		PD2_freq_reg2 <= 0;
		PD3_freq_reg2 <= 0;
		end 
	else 
	begin 
		PD1_freq_reg0 <= PD1_freq;
        PD2_freq_reg0 <= PD2_freq;
        PD3_freq_reg0 <= PD3_freq;
		
		PD1_freq_reg1 <= PD1_freq_reg0;
		PD2_freq_reg1 <= PD2_freq_reg0;
		PD3_freq_reg1 <= PD3_freq_reg0;
		
		PD1_freq_reg2 <= PD1_freq_reg1;
		PD2_freq_reg2 <= PD2_freq_reg1;
		PD3_freq_reg2 <= PD3_freq_reg1;
	end 

reg freq1_h_alarm,freq2_h_alarm,freq3_h_alarm;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)	
		freq1_h_alarm <= 0;
	else if(SEED_OK && PD1_freq_reg2 > FREQ1_THR_H)
		freq1_h_alarm <= 1;
	else 
		freq1_h_alarm <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)	 begin 
		freq2_h_alarm <= 0;
		end 
	else if(PD2_freq_reg2 > FREQ2_THR_H) begin 
		freq2_h_alarm <= 1;
		end 
	else 
		freq2_h_alarm <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)	
		freq3_h_alarm <= 0;
	else if(SEED_OK && PD3_freq_reg2 > FREQ3_THR_H)
		freq3_h_alarm <= 1;
	else 
		freq3_h_alarm <= 0;

high_alarm	U0(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[0]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(PTOTE_PD1),
	.alarm			(alarm_now[0]),
	.latch			(alarm_lat[0])
);

low_alarm	U1(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[1]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(INTER_LOCK1),
	.alarm			(alarm_now[1]),
	.latch			(alarm_lat[1])
);

low_alarm	U2(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[2]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(INTER_LOCK2),
	.alarm			(alarm_now[2]),
	.latch			(alarm_lat[2])
);

high_alarm	U3(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[3]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(!LOW_24V & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[3]),
	.latch			(alarm_lat[3])
);

low_alarm	U4(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[4]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(PTOTE_PD2),
	.alarm			(alarm_now[4]),
	.latch			(alarm_lat[4])
);

low_alarm	U5(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[5]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(PTOTE_PD3),
	.alarm			(alarm_now[5]),
	.latch			(alarm_lat[5])
);

high_alarm	U6(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[6]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(PD1_LOW_ALM),
	.alarm			(alarm_now[6]),
	.latch			(alarm_lat[6])
);

high_alarm	U7(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[7]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(PD2_LOW_ALM),
	.alarm			(alarm_now[7]),
	.latch			(alarm_lat[7])
);

high_alarm	U8(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[8]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(PD3_LOW_ALM),
	.alarm			(alarm_now[8]),
	.latch			(alarm_lat[8])
);

high_alarm	U9(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[9]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(pll_alm),
	.alarm			(alarm_now[9]),
	.latch			(alarm_lat[9])
);

high_alarm	U10(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[10]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(freq1_h_alarm),
	.alarm			(alarm_now[10]),
	.latch			(alarm_lat[10])
);

high_alarm	U11(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[11]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(freq2_h_alarm),
	.alarm			(alarm_now[11]),
	.latch			(alarm_lat[11])
);

high_alarm	U12(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[12]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(freq3_h_alarm),
	.alarm			(alarm_now[12]),
	.latch			(alarm_lat[12])
);

high_alarm	U13(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[13]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(MCU_ESTOP),
	.alarm			(alarm_now[13]),
	.latch			(alarm_lat[13])
);

high_alarm	U14(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[14]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(MCU_ERR),
	.alarm			(alarm_now[14]),
	.latch			(alarm_lat[14])
);

high_alarm	U15(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[15]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[0] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[15]),
	.latch			(alarm_lat[15])
);

high_alarm	U16(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[16]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[1] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[16]),
	.latch			(alarm_lat[16])
);

high_alarm	U17(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[17]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[2] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[17]),
	.latch			(alarm_lat[17])
);

high_alarm	U18(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[18]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[3] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[18]),
	.latch			(alarm_lat[18])
);

high_alarm	U19(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[19]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[4] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[19]),
	.latch			(alarm_lat[19])
);

high_alarm	U20(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[20]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[5]  & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[20]),
	.latch			(alarm_lat[20])
);

high_alarm	U21(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[21]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[6] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[21]),
	.latch			(alarm_lat[21])
);

high_alarm	U22(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[22]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[7] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[22]),
	.latch			(alarm_lat[22])
);

high_alarm	U23(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[23]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[8] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[23]),
	.latch			(alarm_lat[23])
);

high_alarm	U24(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[24]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[9] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[24]),
	.latch			(alarm_lat[24])
);

high_alarm	U25(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[25]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[10] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[25]),
	.latch			(alarm_lat[25])
);

high_alarm	U26(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[26]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[11] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[26]),
	.latch			(alarm_lat[26])
);

high_alarm	U27(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[27]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[12] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[27]),
	.latch			(alarm_lat[27])
);

high_alarm	U28(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[28]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[13] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[28]),
	.latch			(alarm_lat[28])
);

high_alarm	U29(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[29]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[14] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[29]),
	.latch			(alarm_lat[29])
);

high_alarm	U30(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[30]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(!SEQ_ALM[15] & volt_ok & !volt_low_alarm),
	.alarm			(alarm_now[30]),
	.latch			(alarm_lat[30])
);

high_alarm	U31(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en[31]),
	.clear			(clear),
	.DB_TIME		(9),
	.signal			(mode_lock_alm),
	.alarm			(alarm_now[31]),
	.latch			(alarm_lat[31])
);

//面板钥匙开关报警
low_alarm	U2_0(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en2[0]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(PANEL_KEY),
	.alarm			(alarm_now2[0]),
	.latch			(alarm_lat2[0])
);
//面板急停开关报警
low_alarm	U2_1(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en2[1]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(PANEL_ESTOP),
	.alarm			(alarm_now2[1]),
	.latch			(alarm_lat2[1])
);
//激光头报警
low_alarm	U2_2(
	.clk_i			(clk_i),
	.rstn_i			(rstn_i),
	.EN				(alarm_en2[2]),
	.clear			(clear),
	.DB_TIME		(50000),
	.signal			(HEAD_ERROR),
	.alarm			(alarm_now2[2]),
	.latch			(alarm_lat2[2])
);

endmodule 