module burst(
	input 			clk_i,	//FREQ_PD1 用过PLL的pd信号做时钟
	input			rstn_i,	
	
	input 			EXT_TRIG,	
	input [4:0]		BST_NUM,		//burst （选单）数量设置，(x+1)个
    input [4:0]		GHZ_BST_NUM,		//burst （选单）数量设置，(x+1)个
	input [15:0]	BST_PERIOD,		//burst(选单)周期(频率)设置，(x+1)*种子源周期
	input [7:0]		AOM1_DLY_FINE,	//AOM1延时，细调
	input [7:0]		AOM1_DLY_COARSE,
    input [7:0]		AOM1_TTL2DAC_DLY,//一级声光TTL相对于并口DAC延时调节
    
    input [7:0]		AOM3_DLY_FINE,	//AOM1延时，细调
    input [7:0]		AOM3_DLY_COARSE,
    input [11:0]		AOM3_PUL_NUM,
    
    
    input [7:0]		AOM4_DLY_FINE,	//AOM1延时，细调
    input [7:0]		AOM4_DLY_COARSE,
    input [7:0]		AOM4_PUL_NUM,
    
    input [9:0]		AOM1_DATA,	//AOM1高度值
    input [9:0]		AOM3_DATA,	//AOM3高度值
    input [9:0]		AOM4_DATA,	//AOM4高度值
    
    input 		    AOM3_FULL_OPEN,	//AOM3高度值
    input 		    AOM4_FULL_OPEN,	//AOM4高度值
    
    
    
	input [23:0]	FREQ_DIV_NUM,
	input [3:0]		AOM_CTRL_SEL,	//4bit，声光控制选择,0-内部设置，1-外部gate，2-常规trigger，3-free trigger
	input [7:0]		BST_END_CNT,	
//	input [3:0]		AOM2_HEAD_DLY,
//	input [3:0]		AOM2_TAIL_DLY,
	input 			SEED_SYNC_AOM1,
	input 			BST_SEL		,
	input [7:0]		BST_PUL_NUM	,

	input [7:0]		TRIG_PRE	,
	input [7:0]		PROT_FREQ	,	//保护周期/频率
	input [7:0]		BURST_DATA1	,
	input [7:0]		BURST_DATA2	,
	input [7:0]		BURST_DATA3	,
	input [7:0]		BURST_DATA4	,
	input [7:0]		BURST_DATA5	,
	input [7:0]		BURST_DATA6	,
	input [7:0]		BURST_DATA7	,
	input [7:0]		BURST_DATA8	,
	input [7:0]		BURST_DATA9	,
	input [7:0]		BURST_DATA10,
	input [7:0]		BURST_DATA11,
	input [7:0]		BURST_DATA12,
	input [7:0]		BURST_DATA13,
	input [7:0]		BURST_DATA14,
	input [7:0]		BURST_DATA15,
	input [7:0]		BURST_DATA16,
	input [7:0]		BURST_DATA17,
	input [7:0]		BURST_DATA18,
	input [7:0]		BURST_DATA19,
	input [7:0]		BURST_DATA20,    
	
	output wire 	TTL_DIV,		//用于二级声光分频
	output reg 		TTL_tem,		//用于PD2测频判断
	output wire		AOM2_EXP,		//用于AOM2提前开启和关闭判断
	output [9:0]	FIBER_AOM_DATA	,//一级声光模拟量
	output 			FIBER_AOM_CLK	,
	output 			FIBER_AOM_TTL	,//一级声光TTL,实际正在出光
    output [7:0]	FIBER_AOM3_DATA	,
	output 			FIBER_AOM3_CLK	,
	output 			FIBER_AOM3_TTL	,
    output [9:0]	FIBER_AOM4_DATA	,
	output 			FIBER_AOM4_CLK	,
	output 			FIBER_AOM4_TTL	,
    input  [15:0]	FIBER_AOM_FULL_OPEN_FRQ,
    input			FIBER_AOM_FULL_OPEN_EN
);




reg [15:0]	period_cnt;	//选单周期计数器
reg [4:0]	bst_cnt;
reg [4:0]	ghz_bst_cnt;
reg 		FIBER_AOM_TTL_tem;
reg 		FIBER_AOM3_TTL_tem;
reg 		FIBER_AOM4_TTL_tem;
reg [7:0]	FIBER_AOM_DATA_tem;
reg [7:0]	FIBER_AOM3_DATA_tem;
reg [7:0]	FIBER_AOM4_DATA_tem;

reg [3:0]	state;

//
reg 		trig_aom_ttl;
reg			trig_dac_en;	//一级声光DAC输出控制寄存器
reg [3:0]	trig_state;
reg [15:0]	trig_per_cnt;
reg 		EXT_TRIG_reg0,EXT_TRIG_reg1;
reg [3:0]	AOM_CTRL_SEL_reg		;
reg			trig_aom_ttl_to_aom2;
reg [4:0]	BST_NUM_reg0,BST_NUM_reg;
reg [4:0]	GHZ_BST_NUM_reg0,GHZ_BST_NUM_reg;
reg [15:0]	BST_PERIOD_reg0,BST_PERIOD_reg;

//选单数量寄存器BST_NUM同步处理，避免异步数据刷新出现竞争冒险而报警
always @(posedge clk_i) begin
	BST_NUM_reg0 <= BST_NUM;
    BST_NUM_reg <= BST_NUM_reg0;
end

//选单数量寄存器BST_NUM同步处理，避免异步数据刷新出现竞争冒险而报警
always @(posedge clk_i) begin
	GHZ_BST_NUM_reg0 <= GHZ_BST_NUM;
    GHZ_BST_NUM_reg <= GHZ_BST_NUM_reg0;
end
//选单周期寄存器BST_PERIOD同步处理，避免异步数据刷新出现竞争冒险而报警
always @(posedge clk_i) begin
    BST_PERIOD_reg0 <= BST_PERIOD;
    BST_PERIOD_reg  <= BST_PERIOD_reg0;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		AOM_CTRL_SEL_reg <= 0;
	else 
		AOM_CTRL_SEL_reg <= AOM_CTRL_SEL;
end

/*******************free trigger模式***************/
reg [4:0]	trig_bst;
reg [7:0]	freq_cnt;
reg 		freq_ttl;
//freetrig模式，外部EXT_TRIG信号控制的是一级声光TTL
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		EXT_TRIG_reg0 <= 0;
		EXT_TRIG_reg1 <= 0;
	end 
	else begin 
		EXT_TRIG_reg0 <= EXT_TRIG;
		EXT_TRIG_reg1 <= EXT_TRIG_reg0;
	end 
end
//保护频率
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		freq_cnt <= 0;
	else if(trig_dac_en || freq_cnt>=PROT_FREQ)
		freq_cnt <= 0;
	else 
		freq_cnt <= freq_cnt + 1;
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		freq_ttl <= 0;
	else if(trig_dac_en)
		freq_ttl <= 0;
	else if(freq_cnt>=PROT_FREQ)
		freq_ttl <= 1;
	else
		freq_ttl <= 0;
end

reg [7:0]	end_cnt;
//freetrig AOM TTL信号输出
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		trig_state <= 0;	//状态机
		trig_per_cnt <= 0;	//选单频率计数器
		trig_bst <= 0;		//burst数量计数器
		trig_aom_ttl <= 1;	//freetrig模式，一级声光TTL
		trig_dac_en <= 0;	//一级声光DAC输出控制寄存器
		end_cnt <= 0;		//后凹坑长度控制计数器
        trig_aom_ttl_to_aom2 <= 0;	//FREETRIG模式下，AOM2提前开启的信号
	end 
	else if(AOM_CTRL_SEL==3)
		case(trig_state)
	0:	begin 
			trig_state <= 1;
			trig_per_cnt <= 0;
			trig_bst <= 0;
			trig_aom_ttl <= freq_ttl;
			trig_dac_en <= 0;
			end_cnt <= 0;
            trig_aom_ttl_to_aom2 <= 0;
			end 
	1:	begin 
			trig_aom_ttl <= freq_ttl;
			if(EXT_TRIG_reg0 && !EXT_TRIG_reg1)	//外部TRIG信号上升沿
				trig_state <= 2;
			end 
	2:	if(trig_aom_ttl) begin 	//保护电平放完能量后，进入前凹坑，开始蓄能
			trig_aom_ttl <= 0;	//前凹坑：前凹坑时间为关：一个选单周期
			trig_state <= 3;
			end
		else 
			trig_aom_ttl <= freq_ttl;
	3:	if(trig_per_cnt >= BST_PERIOD_reg) begin//按照选单频率设定凹坑长度(比如100k，凹坑长度就是10us)，凹坑长度放完后，开始放burst 
			trig_per_cnt <= 0;
            trig_aom_ttl <= 1;	
			trig_dac_en <= 1;
			trig_state <= 4;
            trig_aom_ttl_to_aom2 <= 1;
			end
		else 
			trig_per_cnt <= trig_per_cnt+1;
	4:	if(trig_bst>=BST_NUM_reg) begin //burst数量全部放完
			trig_dac_en <= 0;
			trig_aom_ttl <= 0;
            trig_state <= 5;
            trig_aom_ttl_to_aom2 <= 0;
			end 
		else 
			trig_bst <= trig_bst+1;
	5:	if(end_cnt < BST_END_CNT)//后凹坑的长度控制
			end_cnt <= end_cnt+1;
		else begin 
			end_cnt <= 0;
			trig_state <= 0;
		end 
	default : ;
	endcase
	else begin   
		trig_state <= 0;
		trig_per_cnt <= 0;
		trig_aom_ttl <= 1;
		trig_dac_en <= 0;
	end 
end
/***************************free trigger end********************************/

/***************************正常模式********************************/
//选单频率设定
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		period_cnt <= 0;
	else if(period_cnt >= BST_PERIOD_reg)	
		period_cnt <= 0;
	else 
		period_cnt <= period_cnt+1;
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		TTL_tem <= 0;
	else if(period_cnt == BST_PERIOD_reg)
		TTL_tem <= 1;
	else if(period_cnt == BST_PERIOD_reg>>1)
		TTL_tem <= 0;
end
//burst数量设定
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		bst_cnt <= 0;
	else if(bst_cnt>=BST_NUM_reg)
		bst_cnt <= 0;
	else if(FIBER_AOM_TTL_tem && bst_cnt<BST_NUM_reg) 
		bst_cnt <= bst_cnt+1;
end
//一级声光TTL信号
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		FIBER_AOM_TTL_tem <= 0;
		state <= 0;
		end 
    else if(FIBER_AOM_FULL_OPEN_EN==1 && BST_PERIOD_reg <= FIBER_AOM_FULL_OPEN_FRQ)	//设定的选单频率高于一级声光全放的频率设定，则一级声光TTL置高全放
    	FIBER_AOM_TTL_tem <= 1;
	else case(state)
	0	:	if(period_cnt >= BST_PERIOD_reg)  //选单频率，开始放burst 
				state <= 1;
	1	:	begin 
				FIBER_AOM_TTL_tem <= 1;
				state <= 3;
			end 
	3	:	if(bst_cnt>=BST_NUM_reg) begin //burst数量，burst放完
				FIBER_AOM_TTL_tem <= 0;
				state <= 0;
			end 
	/*5	:	if(TTL_tem==0)
				state <= 0;*/
	default : state <= 0;
	endcase
end

//AOM2提前开启信号
assign AOM2_EXP = (AOM_CTRL_SEL == 3)?trig_aom_ttl_to_aom2:FIBER_AOM_TTL_tem;    
/*提前开启AOM2的标定信号，AOM2开启后，AOM1经过寄存器延时和线延时，再开启。因为AOM2开启较慢,所以AOM2必须提前AOM1先开，
或者可以认为是AOM2先开，延时一段时间后，AOM1再开，这个延迟的时间=AOM2电信号延时+光信号延时，每一台不同。*/

//选单信号寄存器延时+门延时+展宽
 wire FIBER_AOM_TTL_SELD;//FREETRIG模式，或者正常TRIG/GATE/内控模式下，TTL的信号不同
assign FIBER_AOM_TTL_SELD = (AOM_CTRL_SEL == 3)? trig_aom_ttl : FIBER_AOM_TTL_tem;
(*keep*) wire 	FIBER_AOM_TTL_tem0;	//粗调后的TTL信号
(*keep*) wire   FIBER_AOM_TTL_tem1;	//细调后的TTL信号
(*keep*) wire   FIBER_AOM_TTL_tem2;	//展宽后的TTL信号
reg_delay	REG_AOM1_TTL(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_TTL_SELD),
	.dly_num			(AOM1_DLY_COARSE),	//粗调
	.dly_out			(FIBER_AOM_TTL_tem0)
);
AND_DELAY	AND_AOM1_TTL(
	.dly_in		(FIBER_AOM_TTL_tem0),
    .dly_num 	(AOM1_DLY_FINE),	//细调
    .line		(rstn_i),
    .dly_out	(FIBER_AOM_TTL_tem1)
);
OR_GATE_16	AOM1_TTL_PUL(
	.dly_in				(FIBER_AOM_TTL_tem1),
	.dly_num			(BST_PUL_NUM),	//展宽
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_TTL_tem2)
);
//一级声光TTL线延时(0-255)*150ps,调节TTL和DAC之间的硬线延时，使得TTL和DAC中心对齐，保证TTL早开和晚关1个clk
AND_DELAY	AND_DELAY_TTL2DAC(
	.dly_in				(FIBER_AOM_TTL_tem2),
	.dly_num			(AOM1_TTL2DAC_DLY),//一级声光TTL相对于DAC之间的延时
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_TTL)	//一级声光输出
);

/*************正常和freetrig模式的一级声光模拟信号**************/
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		FIBER_AOM_DATA_tem <= 0;
	else case(AOM_CTRL_SEL)
	3:	//freetrigger模式
		if(trig_state==3 && trig_per_cnt >= BST_PERIOD_reg-1) //BURST_DATA1提前多一个周期，以方便TTL切模拟量
			FIBER_AOM_DATA_tem <= BURST_DATA1;
		else if(trig_dac_en && trig_bst>=BST_NUM_reg)	//BURST结束的时候，多保持一个周期
			FIBER_AOM_DATA_tem <=FIBER_AOM_DATA_tem;
		else if(trig_state==3 || trig_state==5)	
			FIBER_AOM_DATA_tem <= 0; 
		else if(trig_dac_en)
			case (trig_bst)
				0:	FIBER_AOM_DATA_tem <= BURST_DATA2;
				1:	FIBER_AOM_DATA_tem <= BURST_DATA3;
				2:	FIBER_AOM_DATA_tem <= BURST_DATA4;
				3:	FIBER_AOM_DATA_tem <= BURST_DATA5;
				4:	FIBER_AOM_DATA_tem <= BURST_DATA6;
				5:	FIBER_AOM_DATA_tem <= BURST_DATA7;
				6:	FIBER_AOM_DATA_tem <= BURST_DATA8;
				7:	FIBER_AOM_DATA_tem <= BURST_DATA9;
				8:	FIBER_AOM_DATA_tem <= BURST_DATA10;	
                9:	FIBER_AOM_DATA_tem <= BURST_DATA11;
				10:	FIBER_AOM_DATA_tem <= BURST_DATA12;
				11:	FIBER_AOM_DATA_tem <= BURST_DATA13;
				12:	FIBER_AOM_DATA_tem <= BURST_DATA14;
				13:	FIBER_AOM_DATA_tem <= BURST_DATA15;
				14:	FIBER_AOM_DATA_tem <= BURST_DATA16;
				15:	FIBER_AOM_DATA_tem <= BURST_DATA17;
				16:	FIBER_AOM_DATA_tem <= BURST_DATA18;
				17:	FIBER_AOM_DATA_tem <= BURST_DATA19;	
                18:	FIBER_AOM_DATA_tem <= BURST_DATA20;                 
			default : FIBER_AOM_DATA_tem <= TRIG_PRE;	//保护电平
			endcase
		else if(freq_ttl)
			FIBER_AOM_DATA_tem <= TRIG_PRE;
		else if(!freq_ttl)
			FIBER_AOM_DATA_tem <= 0;
	default : 
		if(FIBER_AOM_FULL_OPEN_EN==1 && BST_PERIOD_reg <= FIBER_AOM_FULL_OPEN_FRQ)//设定的选单频率高于一级声光全放的频率设定，则一级声光TTL置高全放
        	FIBER_AOM_DATA_tem <= BURST_DATA1;
        else if(period_cnt >= BST_PERIOD_reg)
			FIBER_AOM_DATA_tem <= BURST_DATA1;
		else if(FIBER_AOM_TTL_tem && bst_cnt==BST_NUM_reg)
			FIBER_AOM_DATA_tem <= FIBER_AOM_DATA_tem;	//data最后一个数据保存一个时钟
		else if(state==5)	//延后一个时钟清零
			FIBER_AOM_DATA_tem <= 0;
		else if(FIBER_AOM_TTL_tem)
			case (bst_cnt)
				0:	FIBER_AOM_DATA_tem <= BURST_DATA2;
				1:	FIBER_AOM_DATA_tem <= BURST_DATA3;
				2:	FIBER_AOM_DATA_tem <= BURST_DATA4;
				3:	FIBER_AOM_DATA_tem <= BURST_DATA5;
				4:	FIBER_AOM_DATA_tem <= BURST_DATA6;
				5:	FIBER_AOM_DATA_tem <= BURST_DATA7;
				6:	FIBER_AOM_DATA_tem <= BURST_DATA8;
				7:	FIBER_AOM_DATA_tem <= BURST_DATA9;
				8:	FIBER_AOM_DATA_tem <= BURST_DATA10;	
                9:	FIBER_AOM_DATA_tem <= BURST_DATA11;
				10:	FIBER_AOM_DATA_tem <= BURST_DATA12;
				11:	FIBER_AOM_DATA_tem <= BURST_DATA13;
				12:	FIBER_AOM_DATA_tem <= BURST_DATA14;
				13:	FIBER_AOM_DATA_tem <= BURST_DATA15;
				14:	FIBER_AOM_DATA_tem <= BURST_DATA16;
				15:	FIBER_AOM_DATA_tem <= BURST_DATA17;
				16:	FIBER_AOM_DATA_tem <= BURST_DATA18;
				17:	FIBER_AOM_DATA_tem <= BURST_DATA19;	
                18:	FIBER_AOM_DATA_tem <= BURST_DATA20;                
				default : FIBER_AOM_DATA_tem <= BURST_DATA1;
			endcase
	endcase 
end

//一级声光模拟量寄存器延时+门延时，和一级声光TTL同步延时
wire      FIBER_AOM_DATA_tem10;  
wire      FIBER_AOM_DATA_tem11;    
wire      FIBER_AOM_DATA_tem12;    
wire      FIBER_AOM_DATA_tem13;
wire      FIBER_AOM_DATA_tem14;
wire      FIBER_AOM_DATA_tem15;
wire      FIBER_AOM_DATA_tem16;
wire      FIBER_AOM_DATA_tem17;

reg_delay	REG_DAC_DATA0(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[0]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem10)
);

reg_delay	REG_DAC_DATA1(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[1]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem11)
);

reg_delay	REG_DAC_DATA2(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[2]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem12)
);

reg_delay	REG_DAC_DATA3(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[3]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem13)
);

reg_delay	REG_DAC_DATA4(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[4]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem14)
);

reg_delay	REG_DAC_DATA5(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[5]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem15)
);

reg_delay	REG_DAC_DATA6(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[6]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem16)
);
reg_delay	REG_DAC_DATA7(
	.clk_i				(clk_i),
	.dly_in				(FIBER_AOM_DATA_tem[7]),
	.dly_num			(AOM1_DLY_COARSE),
	.dly_out			(FIBER_AOM_DATA_tem17)
);
//细延时
AND_DELAY	AND_DAC_DATA0(
	.dly_in				(FIBER_AOM_DATA_tem10),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[0])
);
AND_DELAY	AND_DAC_DATA1(
	.dly_in				(FIBER_AOM_DATA_tem11),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[1])
);
AND_DELAY	AND_DAC_DATA2(
	.dly_in				(FIBER_AOM_DATA_tem12),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[2])
);
AND_DELAY	AND_DAC_DATA3(
	.dly_in				(FIBER_AOM_DATA_tem13),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[3])
);
AND_DELAY	AND_DAC_DATA4(
	.dly_in				(FIBER_AOM_DATA_tem14),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[4])
);
AND_DELAY	AND_DAC_DATA5(
	.dly_in				(FIBER_AOM_DATA_tem15),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[5])
);

AND_DELAY	AND_DAC_DATA6(
	.dly_in				(FIBER_AOM_DATA_tem16),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[6])
);
AND_DELAY	AND_DAC_DATA7(
	.dly_in				(FIBER_AOM_DATA_tem17),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_DATA[7])
);
AND_DELAY	AND_DAC_CLK(
	.dly_in				(clk_i	),
	.dly_num			(AOM1_DLY_FINE),
	.line				(rstn_i),
	.dly_out			(FIBER_AOM_CLK)
);




//分频因子功能，控制二级声光分频
reg [23:0]	div_cnt;
reg EOM_TTL;
reg [6:0]EOM_pul_cnt;

//always @(posedge clk_i or negedge rstn_i) begin
//	if(!rstn_i)begin
//		div_cnt <= 0;
//        EOM_TTL<=0;
//        end
//	else if(div_cnt>=FREQ_DIV_NUM && period_cnt == BST_PERIOD_reg)begin
//		div_cnt <= 0;
//        EOM_pul_cnt<=0;
//        EOM_TTL<=1;
//        end
//	else if(period_cnt == BST_PERIOD_reg)begin
//		div_cnt <= div_cnt+1;
//        end
//     else if(EOM_pul_cnt>=AOM3_PUL_NUM[11:6]) begin
//    	 EOM_TTL<=0;
//        end
//    else begin
//        EOM_pul_cnt<=EOM_pul_cnt+1;
//        end
     
//end



always @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
        div_cnt     <= 0;
        EOM_TTL     <= 0;
        EOM_pul_cnt <= 0;
    end else begin
        if (period_cnt == BST_PERIOD_reg) begin
            // 更新分频计数器
            div_cnt <= (div_cnt >= FREQ_DIV_NUM) ? 0 : div_cnt + 1;
            // 脉冲起始：清零脉冲计数，拉高TTL
            EOM_pul_cnt <= 0;
            EOM_TTL     <= 1;
        end else begin
            // 脉冲宽度控制
            if (EOM_pul_cnt >= AOM3_PUL_NUM[11:6])
                EOM_TTL <= 0;
            else
                EOM_pul_cnt <= EOM_pul_cnt + 1;
        end
    end
end







reg	TTL_DIV_tem;
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		TTL_DIV_tem <= 0;
	else if(AOM_CTRL_SEL == 3)
		TTL_DIV_tem <= 1;
	else if(div_cnt==0 && period_cnt >= BST_PERIOD_reg)
		TTL_DIV_tem <= 1;
	else if(div_cnt>0 && period_cnt >= (BST_PERIOD_reg-1))//分频产生的GATE信号宽度要小一点。由于空间声光带宽较窄，太宽的话，会导致前后漏光
		TTL_DIV_tem <= 0;
end






(*keep*)reg [2:0]  state2 ;
reg  TTL_DIV_tem_dly ;
always @(posedge clk_i or negedge rstn_i) begin   //延迟两拍，防止TTL_DIV和AOM2_SW相与的时候产生竞争冒险
    if(!rstn_i)
    begin
	   TTL_DIV_tem_dly <= 0 ;
	   state2          <= 0 ;
    end 
	else case(state2)
	0     :     state2 <= 1 ;
	1     :     state2 <= 2 ;
	2     :     TTL_DIV_tem_dly <= TTL_DIV_tem ; 
	default :   TTL_DIV_tem_dly <= 0 ;
	endcase
end
assign TTL_DIV  = TTL_DIV_tem_dly;





//AOM3延时展宽调节
 wire 	FIBER_AOM3_TTL_tem0;	//粗调后的TTL信号
 wire   FIBER_AOM3_TTL_tem1;	//细调后的TTL信号
 wire   FIBER_AOM3_TTL_tem2;	//展宽后的TTL信号
reg_delay	REG_AOM3_TTL(
	.clk_i				(clk_i),
	.dly_in				(EOM_TTL),
	.dly_num			(AOM3_DLY_COARSE),	//粗调和AOM1一致
	.dly_out			(FIBER_AOM3_TTL_tem0)
);
AND_DELAY	AND_AOM3_TTL(
	.dly_in		(FIBER_AOM3_TTL_tem0),
    .dly_num 	(AOM3_DLY_FINE),	//细调
    .line		(rstn_i),
    .dly_out	(FIBER_AOM3_TTL_tem1)
);


OR_GATE_16	AOM3_TTL_PUL1(
	.dly_in				(FIBER_AOM3_TTL_tem1),
	.dly_num			(AOM3_PUL_NUM),	
	.line				(rstn_i),
	.dly_out			(FIBER_AOM3_TTL_tem2)
);




////AOM4延时展宽调节
//(*keep*) wire 	FIBER_AOM4_TTL_tem0;	//粗调后的TTL信号
//(*keep*) wire   FIBER_AOM4_TTL_tem1;	//细调后的TTL信号
//(*keep*) wire   FIBER_AOM4_TTL_tem2;	//展宽后的TTL信号
//reg_delay	REG_AOM4_TTL(
//	.clk_i				(clk_i),
//	.dly_in				(EOM_TTL),
//	.dly_num			(AOM4_DLY_COARSE),	//粗调和AOM1一致
//	.dly_out			(FIBER_AOM4_TTL_tem0)
//);
//AND_DELAY	AND_AOM4_TTL(
//	.dly_in		(FIBER_AOM4_TTL_tem0),
//    .dly_num 	(AOM4_DLY_FINE),	//细调
//    .line		(rstn_i),
//    .dly_out	(FIBER_AOM4_TTL_tem1)
//);


//OR_GATE_16	AOM4_TTL_PUL(
//	.dly_in				(FIBER_AOM4_TTL_tem1),
//	.dly_num			(AOM4_PUL_NUM),	//展宽和AOM1一致
//	.line				(rstn_i),
//	.dly_out			(FIBER_AOM4_TTL_tem2)
//);


assign FIBER_AOM3_TTL= FIBER_AOM3_TTL_tem2;
assign FIBER_AOM4_TTL= 1'd0;


//assign TTL_DIV  = FIBER_AOM3_TTL;

endmodule 