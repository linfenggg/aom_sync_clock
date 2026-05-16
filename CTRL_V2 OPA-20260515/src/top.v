/*-----------奥创光子Ultron 注释开始------------
文件名：top.v
功能描述：控制系统顶层代码，适用于飞秒固体激光器
设计者：Roc
设计时间：2024.5.29
版权所属：杭州奥创光子技术有限公司
修改信息：首版--2023.7.27
	 	第二版--2024.5.29更改为PH1A系列FPGA,资源55k
-------------奥创光子Ultron 注释结束------------*/
module top(
	input 				clk_in,			//50MHz系统时钟(一个周期是20ns，1/50MHz=0.02us=20ns)
    /*********************测频信号************************/ 
    input 				FREQ_PD1,		//测频1,种子基频(type值：30-100MHz)
	input 				FREQ_PD2,		//测频2,选单频率(type值：10kHz-2MHz)
	input 				FREQ_PD3,   	//测频3,预留
    /************4*声光模拟量及TTL控制信号******************/                	
	output [13:0]		AOM1_DB,		//AOM1 14bit 并口DAC数据接口
	output [13:0]		AOM2_DB,		//AOM2 14bit 并口DAC数据接口
	output [13:0]		AOM3_DB,    	//AOM3 14bit 并口DAC数据接口
	output [13:0]		AOM4_DB,    	//AOM4 14bit 并口DAC数据接口
	output 				AOM1_CLK,		//AOM1 14bit 并口DAC单端时钟接口，50MHz
	output 				AOM2_CLK,		//AOM2 14bit 并口DAC单端时钟接口，50MHz
	output 				AOM3_CLK,		//AOM3 14bit 并口DAC单端时钟接口，50MHz
	output 				AOM4_CLK,		//AOM4 14bit 并口DAC单端时钟接口，50MHz
	output 				AOM1_TTL,		//AOM1 TTL信号，光纤AOM控制信号
	output 				AOM2_TTL,		//AOM2 TTL信号，空间AOM控制信号
	output 				AOM3_TTL,		//AOM3 TTL信号
	output 				AOM4_TTL,		//AOM4 TTL信号
    /*****************泵源供电及电流控制信号******************/
	output[14:0]		MD_DAC_CS,		//泵源驱动电流设定DAC，片选引脚
    output[14:0]		MD_DAC_SCLK,	//泵源驱动电流设定DAC，时钟引脚
    output[14:0]		MD_DAC_DOUT,	//泵源驱动电流设定DAC，数据引脚
    output reg [14:0]	PUMP_SW,		//泵源驱动模拟开关控制信号
	output [1:0]		FPGA_SW,		//泵源驱动PMOS开关控制信号
    output 	 			FPGA_WDI,		//喂狗信号
    output [1:0]		ONLINE_PROG,	//串口在线升级MCU或者FPGA固件时，MCU控制该引脚置高
    /**********************报警信号检测**********************/
	output				online1_SCL,	//在位报警信号IIC-1采集，时钟信号，预留
	inout				online1_SDA,	//在位报警信号IIC-1采集，数据信号，预留
	input				online1_INT,	//在位报警信号IIC-1采集，中断信号，预留
	output				online2_SCL,	//在位报警信号IIC-2采集，时钟信号，预留
	inout				online2_SDA,	//在位报警信号IIC-2采集，数据信号，预留
	input 				online2_INT,	//在位报警信号IIC-2采集，中断信号，预留
	output				TIME_SEQ_ALM_SCL,   //欠压报警信号IIC采集，时钟信号
	inout				TIME_SEQ_ALM_SDA,	//欠压报警信号IIC采集，数据信号
	input				TIME_SEQ_ALM_INT1, 	//欠压报警信号IIC采集，中断信号
    input				TIME_SEQ_ALM_INT2, 	//欠压报警信号IIC采集，中断信号，预留
    input				PTOTE_PD1,		//烧纤
	input				PTOTE_PD2,		//断纤
	input				PTOTE_PD3,		//烧纤
	input 				LOW_24V,		//24V欠压报警      
	/********************外部隔离信号******************************/
    input 				EXT_INTLK1,		//外部输入连锁信号，CH1
	input 				EXT_INTLK2,		//外部输入连锁信号，CH2
	input				EXT_WATER_ALM,	//水流检测/报警信号
    output 				EXT_ALM,		//告警输出信号,红灯，高级报警--常亮，低级报警--闪烁(频率2.5Hz)
	input				EXT_GATE,		//外部输入GATE信号
	input				EXT_PWM,		//外部输入PWM信号
	input				EXT_TRIG,		//外部输入TRIG信号
	output reg			EXT_SYNC1,		//同步输出信号，SYNC1
    output reg			EXT_SYNC2,		//同步输出信号，SYNC2
	output				EXT_STATE,		//激光器状态输出信号，绿灯：不开，熄灭-->开种子，慢闪-->开AP，快闪-->开APM，更快闪-->开声光，常亮
    input	[7:0]		EXT_DATA,		//外部输入8bit数字信号量，控制功率大小
	input				EXT_LAT,		//外部输入8bit数字信号量锁存信号
    output				EXT_AD_CS,		//外部模拟量12bit串行ADC，片选信号
    output				EXT_AD_SCLK,	//外部模拟量12bit串行ADC，时钟信号
    input				EXT_AD_SDO,		//外部模拟量12bit串行ADC，数据信号
    input				EXT_PRR,		//外部输入PRR信号，	预留
	input				EXT_GUID,		//指示光控制,			预留 
    input				EXT_INMODE,		//工作模式控制-内控，	预留
    input				EXT_EXMODE,		//工作模式控制-外控，	预留
    input				EXT_OFF,		//工作模式控制-关机，	预留
    input				EXT_RESERVE1,	//预留
    input				EXT_RESERVE2,	//预留
    /***************双光子/风冷/水冷分体式机型相关信号(隔离)**************/
  //  input 				PANEL_KEY,  	//钥匙开关
//	input 				PANEL_ESTOP,	//急停开关
  //  input				HEAD_ERROR,		//激光头硬件报警信号
//    output reg 			DOUT_TO_HEAD,	//给到激光头的硬件控制信号，预留       
	/*****************电机控制及限位开关采集信号(隔离)*******************/
	input 				MOTOR1_cw,		//电机顺时针限位报警信号，1报警
	input 				MOTOR1_ccw,     //电机逆时针限位报警信号，1报警
	output 				MOTOR1_pulse,	//电机速度控制信号
	output 				MOTOR1_direct,	//电机方向控制信号
    input 				MOTOR1_origin,	//电机原点限位开关报警信号，1报警，预留
    output				MOTOR1_enable,	//电机使能控制信号，预留    
    output				AIRPUMP_PWM1,	//气泵1速度控制
    output				AIRPUMP_PWM2,  	//气泵2速度控制
    output				AIR_VALVES_CTL,	//泄压阀控制
    output				ICR1_A,			//ICR控制
    output				ICR1_B,			
    output				ICR2_A,
    output				ICR2_B,
	/*
    input 				MOTOR2_cw,		
	input 				MOTOR2_ccw,    
	input 				MOTOR2_origin,	
	output 				MOTOR2_pulse,	
	output 				MOTOR2_direct,	
	input 				MOTOR3_cw,		
	input 				MOTOR3_ccw,    
	input 				MOTOR3_origin,	
	output 				MOTOR3_pulse,	
	output 				MOTOR3_direct,	
	input 				MOTOR4_cw,		
	input 				MOTOR4_ccw,    
	input 				MOTOR4_origin,	
	output 				MOTOR4_pulse,	
	output 				MOTOR4_direct,	*/
    /*****************FPGA与MCU SPI通信*******************/
	input				SPI_CS,		//FPGA_MCU1
	input				SPI_SCLK,	//FPGA_MCU2
	input				SPI_SDI,	//FPGA_MCU3
	output  			SPI_SDO,	//FPGA_MCU4
	input 				MCU_ERR	,	//FPGA_MCU8,
	input 				MCU_ESTOP,	//FPGA_MCU9,
    input				FPGA_MCU5,	//预留
    input				FPGA_MCU6,	//预留
    input				FPGA_MCU7,	//预留
    input				FPGA_MCU10,	//预留
    input				FPGA_MCU11,	//预留
    input				FPGA_MCU12,	//预留
	//debug调试用接口，需要信号打出时再配置
	
    output [3:0]		debug_led				
);
`include "parameter_def.v"


	wire 				clk_50m;		//50MHz系统时钟，用于常规信号及通信总线全局时钟
    wire 				clk_100m;		//100MHz系统时钟
	wire 				clk_160m;		//160MHz系统时钟，用于PD1和PD2测频报警的时序逻辑电路时钟
	wire 				clk_PD;
	wire 				clk_PD_4times;

wire 			pll_reset; 		//PLL复位信号，高电平复位
wire 			pll_lock;		//锁相环锁相(PLL产生目标频率所需要的时间大概为15ms)后，该信号由低-->高
wire 			pll_pd_lock;
wire 			PD1_EXP_FALSE;	//FPGA内部系统时钟PLL产生的，32MHz系统时钟，模拟外部种子源产生的假信号，主要用于软件调试
wire 			PD1_EXP_TRUE;	//展宽后的PD1测频信号，外部种子源产生的真信号
wire			PD1_EXP;		//展宽后的PD1测频信号
wire 			PD2_EXP;		//展宽后的PD2测频信号
//wire 			PD3_EXP;		//展宽后的PD3测频信号
wire	[3:0]	PD1_PULSE_LV;	//PD1脉宽展宽等级,0不展宽，1-5逐级(0.6-3ns)展宽
wire 	[3:0]	PD2_PULSE_LV;	//PD2脉宽展宽等级,0不展宽，1-5逐级(0.6-3ns)展宽
reg 			clk_PD_2divided;//PD1测频二分频信号
wire 			PD1_MEAS;		//用于测频的信号PD1
wire 	[3:0]	SEED_SOURCE;	//种子信号源选择，0-真实种子源；1-32MHz假种子源
wire 			SEED_OK;		//种子源开启成功信号，1-开启完成，-开启失败0
wire  	[23:0]	FREQ_DIV_NUM;	//分频因子,（x+1）分频。 0是不分频，1是二分频，2是三分频
wire  	[3:0]	WORK_MODE	;
wire  	[15:0]	AOM2_HEAD_DLY;
wire  	[3:0]	AOM2_TAIL_DLY;
wire 			FREE_TRIG_AOM2_MODE;
wire  			SEED_SYNC_AOM1	;
wire [9:0]		THR1			;
wire [9:0]		THR2			;
wire [9:0]		THR3			;
wire [9:0]		THR4			;
wire [9:0]		THR5			;
wire [9:0]		THR6			;
wire [9:0]		THR7			;
wire [9:0]		THR8			;
wire [9:0]		THR9			;
wire [9:0]		THR10			;
wire [31:0]		K1				;
wire [31:0]		K2				;
wire [31:0]		K3				;
wire [31:0]		K4				;
wire [31:0]		K5				;
wire [31:0]		K6				;
wire [31:0]		K7				;
wire [31:0]		K8				;
wire [31:0]		K9				;
wire [31:0]		K10				;
wire [9:0]		P3_THR			;
wire [31:0]		P3_K			;
wire [9:0]		P6_THR			;
wire [31:0]		P6_K			;
wire [17:0]		POWER_K_SET		;
wire [9:0]		START_THR		;
wire [9:0]		P92_THR			;
wire [31:0]		P92_K			;
wire [9:0]		P94_THR			;
wire [31:0]		P94_K			;
wire [9:0]		P96_THR			;
wire [31:0]		P96_K			;
wire [9:0]		P98_THR			;
wire [31:0]		P98_K			;

wire  			BST_SEL			;
wire [7:0]		BST_PUL_NUM		;
wire [7:0]		TRIG_PRE		;
wire [7:0]		PROT_FREQ		;
wire [7:0]		BURST_DATA1		;
wire [7:0]		BURST_DATA2		;
wire [7:0]		BURST_DATA3		;
wire [7:0]		BURST_DATA4		;
wire [7:0]		BURST_DATA5		;
wire [7:0]		BURST_DATA6		;
wire [7:0]		BURST_DATA7		;
wire [7:0]		BURST_DATA8		;
wire [7:0]		BURST_DATA9		;
wire [7:0]		BURST_DATA10	;
wire [7:0]		BURST_DATA11	;
wire [7:0]		BURST_DATA12	;
wire [7:0]		BURST_DATA13	;
wire [7:0]		BURST_DATA14	;
wire [7:0]		BURST_DATA15	;
wire [7:0]		BURST_DATA16	;
wire [7:0]		BURST_DATA17	;
wire [7:0]		BURST_DATA18	;
wire [7:0]		BURST_DATA19	;
wire [7:0]		BURST_DATA20	;

wire			AOM2_CTRL		;
wire 			AOM1_PULSE_CLR	;
wire 			TTL_DIV			;
wire [15:0]		AOM1_PULSE_NUM	;
wire [7:0]		AOM2_DLY_COARSE	;
wire [7:0]		AOM2_DLY_FREE_TRIG;
wire [11:0]		ANALOG_12BIT	;
wire [9:0]		INT_8BIT		;
wire [9:0]		cal_dac_set		;
wire [3:0]		POWER_CTRL_SEL	;
wire [3:0]		AOM_CTRL_SEL	;	//声光控制选择,0-内部设置，1-外部gate，2-常规trigger，3-free trigger
wire [7:0]		BST_END_CNT		;
wire [9:0]		AOM1_DATA		;
wire [7:0]		AOM2_DATA		;
wire 			AD_START		;
wire 			AOM2_EXP		;
wire 			TTL_tem			;
wire 			AOM2_SW			;
wire 			start_status	;
wire 			error			;	//低级报警
wire 			mode_lock_alm	;
wire 			lock			;	//高级报警
wire [15:0]		ONLINE_DATA1	;
wire [15:0]		ONLINE_DATA2	;
wire [15:0]		SEQ_ALM			;
//wire [7:0]		MOTOR_state;
wire 			MOTOR1_reset	;
wire [31:0]		MOTOR1_period	;
wire [17:0]		MOTOR1_step_num	;
wire [17:0]		MOTOR1_step_sta ;
wire			MOTOR2_reset	;
wire [31:0]		MOTOR2_period	;
wire [17:0]		MOTOR2_step_num	;
wire [17:0]		MOTOR2_step_sta ;
wire 			MOTOR3_reset	;
wire [31:0]		MOTOR3_period	;
wire [17:0]		MOTOR3_step_num	;
wire [17:0]		MOTOR3_step_sta ;
wire 			MOTOR4_reset	;
wire [31:0]		MOTOR4_period	;
wire [17:0]		MOTOR4_step_num	;
wire [17:0]		MOTOR4_step_sta ;
wire [4:0]		BST_NUM			;	//选单burst数量
wire [4:0]		GHZ_BST_NUM		;	//GHZ选单burst数量
wire 		    AOM3_FULL_OPEN		;	//GHZ选单burst数量
wire 		    AOM4_FULL_OPEN		;	//GHZ选单burst数量
wire [15:0]		BST_PERIOD		;	//选单周期
wire [7:0]		AOM1_DLY_FINE	;
wire [7:0]		AOM3_DLY_FINE	;
wire [7:0]		AOM4_DLY_FINE	;
wire [7:0]		AOM1_DLY_COARSE	;
wire [7:0]		AOM3_DLY_COARSE	;
wire [7:0]		AOM4_DLY_COARSE	;
wire [11:0]		AOM3_PUL_NUM	;
wire [7:0]		AOM4_PUL_NUM	;
wire [7:0]		AOM1_TTL2DAC_DLY;
wire			FIBER_AOM_TTL_tem;
wire			AOM2_TTL_tem;
wire [16:0]		PD1_freq	;
wire [15:0]		PD2_freq	;
wire [15:0]		PD3_freq	;
wire [31:0]		WATER_FREQ	;		//水流量测周期
wire [31:0]		alarm_en		;	
wire 			clear			;
wire [31:0]		alarm_now		;
wire [31:0]		alarm_lat		;
wire [31:0]		alarm_out		;
wire [31:0]		alarm_en2		;	
wire [31:0]		alarm_now2		;
wire [31:0]		alarm_lat2		;
wire [31:0]		alarm_out2		;
wire [19:0]		fiber_break_delay;
wire [16:0]		FREQ1_THR_H		;
wire [15:0]		FREQ1_THR_L		;
wire [15:0]		FREQ2_THR_H		;
wire [15:0]		FREQ2_THR_L		;
wire [15:0]		FREQ3_THR_H		;
wire [15:0]		FREQ3_THR_L		;	
wire [7:0]		FREQ_ALARM_DLY	;
wire 			fiber_alarm		;
wire			PD1_LOW_ALM		;
wire			PD2_LOW_ALM		;
wire			PD3_LOW_ALM		;
wire [7:0]		EXT_8BIT_SYNC;
wire 			overflow_1,overflow_2,overflow_3,overflow_4;
wire 			BREAK_OUT_1,BREAK_OUT_2,BREAK_OUT_3,BREAK_OUT_4;
wire 			EXT_GATE_OUT;
wire [9:0]		AOM3_DATA;
wire [9:0]		AOM4_DATA;

wire 			AP_OK		;
wire			APM1_OK		;
wire 			APM_OK		;
reg  [9:0]		cal_din		;
reg  [9:0]		cal_dout	;
wire [9:0]		cal_dout1	;
wire [7:0]		TEST_IO_SEL	;
wire [7:0]		TEST2_IO_SEL;
wire 			pll_alm;
wire   			ICR1_OPEN,ICR1_CLOSE,ICR2_OPEN,ICR2_CLOSE;
wire [15:0]		FIBER_AOM_FULL_OPEN_FRQ;
wire			FIBER_AOM_FULL_OPEN_EN;
wire [15:0]		SPACE_AOM_FULL_OPEN_FRQ;
wire			SPACE_AOM_FULL_OPEN_EN;
wire			SPACE_AOM_LEV_CTL;  
//wire			SPACE_AOM_SYNCLEV_CTL;

wire [7:0]  	LASER_TYPE;	//激光器类型，8bit，0-30~50W固体激光器，1-120W固体激光器，2-200W固体激光器，16-10W光纤激光器,17-20W光纤激光器
wire [7:0]		POD_NUM;
wire [24:0]		POD_DATA;
reg  [15:0] 	int_trig_cnt;
reg	 			INT_TRIG;
wire 			SYS_TRIG;
wire 			SYS_GATE;
wire [15:0] 	INT_TRIG_PERIOD;
wire [3:0] 		TRIG_SOURCE;
/*=======================================================================================================================================
=======================================================================================================================================*/
/****************系统复位PLL模块****************/
//功能：系统上电后，FPGA内部晶振工作，PLL开始复位，14.5ms后停止复位，PLL开始工作。(不复位的话，PLL会工作异常)
//RstUnit	RstUnit(
//	.rst			(pll_reset)
//);

/****************系统时钟硬件PLL模块****************/
//功能：上电后开始复位PLL等待14.5ms输入时钟稳定后，PLL产生频率和相位稳定的50MHz/160MHz/100MHz时钟，并输出PLL锁定信号0-->1
PH1A_SYS_PLL	SYS_PLL(
	.refclk			(clk_in), 		
	.reset			(1'b0), 
	.lock	    	(pll_lock),  	
	.clk0_out		(clk_50m),
	.clk1_out		(clk_160m),
	.clk2_out		(clk_100m),
    .clk3_out		(PD1_EXP_FALSE)
);

/****************PD1测频模块(展宽-模拟开关-锁相环-测频)****************/
//PD1信号门延时展宽(其实质是把信号整体延时，然后与当前信号相或，把延时时间对应的低电平转换为高电平，以达到周期不变、占空比调大的效果)，展宽时间分别为0/0.6ns/1.2ns/1.8ns/2.4ns/3ns
PD_WAVE	PD_WAVE1(
	.PD_IN			(FREQ_PD1),
	.line			(pll_lock),
	.PD_PULSE_LV	(PD1_PULSE_LV),	
	.PD_OUT			(PD1_EXP_TRUE)
);
assign 	PD1_EXP = (SEED_SOURCE==0)?PD1_EXP_TRUE:PD1_EXP_FALSE;
//PD1测频锁相环
PLL_BASE_FREQ	pd1_4times(
	.refclk			(PD1_EXP	),		
	.reset			(~SEED_OK	),		//种子没开时，一直复位pll(高电平复位)
	.lock    		(pll_pd_lock),	//作为AOM输出的复位信号
	.clk0_out		(clk_PD		),		//用于同步选单信号输出
	.clk1_out		(clk_PD_4times)	//AOM2展宽和二分频时钟
);
//PD1测频低报警--快速检测
freq_alarm_feed	PD1_LOW(
	.clk_i			(clk_160m),		//6.25ns
	.rstn_i			(pll_lock),
	.laser			(pll_pd_lock),
	.alarm_en		(alarm_en[6]),	//告警屏蔽
	.clear			(clear),		//清除所有告警
	.THR_L			(FREQ1_THR_L),	//告警低阈值，周期小于10X ns时告警
	.freq			(PD1_EXP),		//PD信号
	.alarm_out		(PD1_LOW_ALM),
    .BST_PERIOD			(16'b0),
    .FIBER_AOM_FULL_OPEN_FRQ(16'b0),
    .FIBER_AOM_FULL_OPEN_EN (1'b0)
);
//PD1二分频
always @(posedge PD1_EXP or negedge pll_lock) begin
if(!pll_lock)
	clk_PD_2divided <= 1'b0;
else
	clk_PD_2divided <= ~clk_PD_2divided;
end
assign PD1_MEAS = (LASER_TYPE == 21 ) ? clk_PD_2divided : PD1_EXP;	//双光子机型(考虑80MHz种子)采用种子二分频进行测量，其他机型不分频
//PD1测频
freq_cal	freq_cal_1(
	.clk_i			(clk_100m),	//
	.rstn_i			(pll_lock),
	.fx				(PD1_MEAS),	//待测信号1M - 100M
	.freq			(PD1_freq)	//单位:kHz
);

/****************PD2测频展宽模块****************/
//PD2信号门延时展宽(其实质是把信号整体延时，然后与当前信号相或，把延时时间对应的低电平转换为高电平，以达到周期不变、占空比调大的效果)，展宽时间分别为0/0.6ns/1.2ns/1.8ns/2.4ns/3ns
PD_WAVE	PD_WAVE2(
	.PD_IN			(FREQ_PD2),
	.line			(pll_lock),
	.PD_PULSE_LV	(PD2_PULSE_LV),
	.PD_OUT			(PD2_EXP)
);
//PD2测频低报警
freq_alarm_feed	PD2_LOW(
	.clk_i			(clk_160m),		//6.25ns
	.rstn_i			(pll_lock),
	.laser			(AP_OK & (AOM_CTRL_SEL!=3)),	//free trigger模式不告警
	.alarm_en		(alarm_en[7]),	//告警屏蔽
	.clear			(clear),		//清除所有告警
	.THR_L			(FREQ2_THR_L),	//告警低阈值，周期小于10X ns时告警
	.freq			(PD2_EXP),		//PD信号
	.alarm_out		(PD2_LOW_ALM),
    .BST_PERIOD			(BST_PERIOD),
    .FIBER_AOM_FULL_OPEN_FRQ(FIBER_AOM_FULL_OPEN_FRQ),
    .FIBER_AOM_FULL_OPEN_EN (FIBER_AOM_FULL_OPEN_EN)
);
//PD2测频
freq_cal_AOM2	freq_cal_2(
	.clk_i			(clk_100m),	//100M, 10ns
	.rstn_i			(pll_lock),
	.TTL			(TTL_tem),	//来自burst模块，一个高电平期间只测一次脉冲
	.fx				(PD2_EXP),	//待测信号100k - 30M
	.freq			(PD2_freq)	//单位:kHz
);

/****************泵浦模拟开关信号控制模块****************/
always@(*) begin
	if(lock)
    	PUMP_SW <= 15'd0;
    else if((LASER_TYPE == 21)&&(WORK_MODE == NORMAL))//激光器类型是双光子(无声光)类型，外部触发信号控制PUMP5的模拟量开关，作为整台机器的出光控制
    	PUMP_SW <= {10'h3ff,AOM2_CTRL,4'hf};
    else	//激光器类型是其他类型，或者双光子(无声光)debug模式下，PUMP5_SW正常控制
       	PUMP_SW <= 15'h7fff;
end
//assign PUMP_SW = (lock)? 15'd0 : 15'h7fff; //泵浦DAC模拟开关控制，高级报警关闭开关

/*************内部产生gate/trig INT_TRIG信号，用于测试**************/
//内部TRIG信号计数器
always @(posedge clk_50m or negedge pll_pd_lock) begin
	if(!pll_pd_lock)
		int_trig_cnt <= 0;
	else if(int_trig_cnt >= INT_TRIG_PERIOD)	
		int_trig_cnt <= 0;
	else 
		int_trig_cnt <= int_trig_cnt+1;
end
//内部TRIG信号
always @(posedge clk_50m or negedge pll_pd_lock) begin
	if(!pll_pd_lock)
		INT_TRIG <= 0;
	else if(int_trig_cnt == INT_TRIG_PERIOD)
		INT_TRIG <= 1;
	else if(int_trig_cnt == INT_TRIG_PERIOD>>1)
		INT_TRIG <= 0;
end
assign 	SYS_TRIG = (TRIG_SOURCE==0)?EXT_TRIG:INT_TRIG;		//选择TRIG源是外部给入的，还是内部产生的
assign	SYS_GATE = (TRIG_SOURCE==0)?EXT_GATE_OUT:INT_TRIG;	//选择GATE源是外部给入的，还是内部产生的

/***************硬件喂狗***************/
feed_dog	feed_dog(
    .clk_i			(clk_50m),	//50M 20ns
	.rstn_i			(pll_lock),
    .dout			(FPGA_WDI)
);

/**************空间AOM TTL粗调延时输出*******/
wire SPACE_AOM_FULL_OPEN;
wire SPACE_AOM_TTL_DLY;
wire SPACE_AOM_TTL;
wire AOM2_TTL_temp;

assign AOM2_TTL = SPACE_AOM_LEV_CTL ? (~AOM2_TTL_temp):AOM2_TTL_temp;
//assign AOM3_TTL_SYNC = SPACE_AOM_SYNCLEV_CTL ? (~AOM2_TTL_temp):AOM2_TTL_temp;
assign AOM2_TTL_temp = (SPACE_AOM_FULL_OPEN==1&&INT_ENABLE==1)?0:SPACE_AOM_TTL;
//assign AOM3_TTL = (SPACE_AOM_FULL_OPEN==1&&INT_ENABLE==1)?0:SPACE_AOM_TTL;
assign SPACE_AOM_TTL = ~SPACE_AOM_TTL_DLY;	//AOM2 低开高关
assign AOM2_TTL_tem = AOM2_SW ;//& TTL_DIV & start_status;
wire [7:0] AOM2_DLY_sel;
assign AOM2_DLY_sel = (AOM_CTRL_SEL==3)? AOM2_DLY_FREE_TRIG : AOM2_DLY_COARSE;	//分2个参数
reg_delay	reg_delay(
	.clk_i			(clk_PD_4times),//AOM2的TTL与种子源倍频信号时钟同步
	.dly_in			(AOM2_TTL_tem),
	.dly_num		(AOM2_DLY_sel),	//(AOM2_DLY),
	.dly_out		(SPACE_AOM_TTL_DLY)
);

/***********100M系统时钟监测PD1测频信号是否正常***********/
pll_feed_dog	pll_feed_dog(	
    .clk_i			(clk_100m), //100M
    .rstn_i			(pll_lock),
    .en				(pll_pd_lock),
	.alm_en			(alarm_en[9]),
    .pll_in			(clk_PD),
    .pll_alm		(pll_alm)
);

wire [11:0]	ANALOG_8BIT_AMP;
wire [11:0]	PUMP5_DATA_out;
wire [11:0]  PUMP5_IMAX;	//PUMP5电流最大值，即全光纤10W/20W APM1最大值
reg  [11:0] DATA_MAX;	
wire [11:0]	AOM_MAX;	//AOM DAC最大值
core	core( 
	.clk_i					(clk_50m),
	.clk_100m				(clk_100m),
	.clk_PD					(clk_PD),
	.clk_PD_4times			(clk_PD_4times),
	.rstn_i					(pll_lock	),
	//.MOTOR_state			(MOTOR_state),
	.AOM2_CTRL				(AOM2_CTRL	),
	.TTL_DIV				(TTL_DIV	),
	.EXT_GATE				(SYS_GATE	),
	.EXT_PWM				(EXT_PWM	),
	.EXT_TRIG				(SYS_TRIG	),
	.EXT_SYNC1				(EXT_SYNC1	),
	.EXT_STATE				(EXT_STATE	),
	.EXT_PRR				(EXT_PRR	),
	.EXT_SYNC2				(EXT_SYNC2	),
	.EXT_GUID				(EXT_GUID	),
//	.PANEL_KEY				(PANEL_KEY	),  
//	.PANEL_ESTOP			(PANEL_ESTOP),
	.EXT_DATA				(EXT_DATA	),
	.EXT_LAT				(EXT_LAT	),
	.WATER_ALM				(EXT_WATER_ALM	),
	.SEED_OK				(SEED_OK	),
	.AP_OK					(AP_OK		),
	.APM_OK					(APM_OK		),
	.AD_START				(AD_START		),			
	.WORK_MODE				(WORK_MODE		),			
	.INT_ENABLE				(INT_ENABLE		),
	.AOM_MAX				(AOM_MAX		),
	.ONLINE_PRG1			(ONLINE_PROG[0]),
	.ONLINE_PRG2			(ONLINE_PROG[1]),
	.TEST_IO_SEL			(TEST_IO_SEL	),
    .TEST2_IO_SEL			(TEST2_IO_SEL	),
	.FPGA_SW				(FPGA_SW		),
	.PD1_freq				(PD1_freq		),	
	.PD2_freq				(PD2_freq		),	
	.PD3_freq				(PD3_freq		),	
	.WATER_FREQ				(WATER_FREQ		),
	.alarm_en				(alarm_en			),	
	.clear					(clear				),
	.alarm_now				(alarm_now			),
	.alarm_lat				(alarm_lat			),
	.alarm_out				(alarm_out			),
	.alarm_en2				(alarm_en2			),	
	.alarm_now2				(alarm_now2			),
	.alarm_lat2				(alarm_lat2			),
	.alarm_out2				(alarm_out2			),
	.lock					(lock				),
	.fiber_break_delay		(fiber_break_delay	),
	.FREQ1_THR_H			(FREQ1_THR_H		),
	.FREQ1_THR_L			(FREQ1_THR_L		),
	.FREQ2_THR_H			(FREQ2_THR_H		),
	.FREQ2_THR_L			(FREQ2_THR_L		),
	.FREQ3_THR_H			(FREQ3_THR_H		),
	.FREQ3_THR_L			(FREQ3_THR_L		),	
	.FREQ_ALARM_DLY			(FREQ_ALARM_DLY		),

	.AOM2_DLY_COARSE		(AOM2_DLY_COARSE	),
	.AOM2_DLY_FREE_TRIG		(AOM2_DLY_FREE_TRIG),

	.INT_8BIT				(INT_8BIT		),
	.cal_dac_set			(cal_dac_set	),
	.ANALOG_8BIT			(ANALOG_8BIT_AMP),
	.POWER_CTRL_SEL			(POWER_CTRL_SEL	),
	.AOM_CTRL_SEL			(AOM_CTRL_SEL	),
	.BST_END_CNT			(BST_END_CNT	),
	.ONLINE_DATA1			(ONLINE_DATA1),
	.ONLINE_DATA2			(ONLINE_DATA2),
	.SEQ_ALM				(SEQ_ALM		),
	.cal_din				(cal_din		),
	.cal_dout				(cal_dout1		),
	.AOM1_DATA				(AOM1_DATA		), 
	.AOM2_DATA				(AOM2_DB		),
	.AOM3_DATA				(AOM3_DATA		),
	.AOM4_DATA				(AOM4_DATA		),
	//.AOM4_TTL				(AOM4_TTL		),	
	.MOTOR1_reset			(MOTOR1_reset	),	
	.MOTOR1_period			(MOTOR1_period	),
	.MOTOR1_step_num		(MOTOR1_step_num),
	.MOTOR1_step_sta		(MOTOR1_step_sta),
	/*.MOTOR2_reset			(MOTOR2_reset	),	
	.MOTOR2_period			(MOTOR2_period	),
	.MOTOR2_step_num		(MOTOR2_step_num),
	.MOTOR2_step_sta		(MOTOR2_step_sta),
	.MOTOR3_reset			(MOTOR3_reset	),	
	.MOTOR3_period			(MOTOR3_period	),
	.MOTOR3_step_num		(MOTOR3_step_num),
	.MOTOR3_step_sta		(MOTOR3_step_sta),
	.MOTOR4_reset			(MOTOR4_reset	),	
	.MOTOR4_period			(MOTOR4_period	),
	.MOTOR4_step_num		(MOTOR4_step_num),
	.MOTOR4_step_sta		(MOTOR4_step_sta),*/
	.MOTOR_overflow			({overflow_4,overflow_3,overflow_2,overflow_1}),
	.MOTOR_BREAK_OUT		({BREAK_OUT_4,BREAK_OUT_3,BREAK_OUT_2,BREAK_OUT_1}),
	.BST_NUM				(BST_NUM		),
    .GHZ_BST_NUM			(GHZ_BST_NUM    ),
    .AOM3_FULL_OPEN			(AOM3_FULL_OPEN    ),
    .AOM4_FULL_OPEN			(AOM4_FULL_OPEN    ),
	.BST_PERIOD				(BST_PERIOD		),
    .AOM1_DLY_COARSE		(AOM1_DLY_COARSE),
	.AOM1_DLY_FINE			(AOM1_DLY_FINE	),
    .AOM3_DLY_FINE			(AOM3_DLY_FINE	),
    .AOM4_DLY_FINE			(AOM4_DLY_FINE	),
    .AOM3_DLY_COARSE		(AOM3_DLY_COARSE	),
    .AOM4_DLY_COARSE		(AOM4_DLY_COARSE	),
    .AOM3_PUL_NUM			(AOM3_PUL_NUM	),
    .AOM4_PUL_NUM			(AOM4_PUL_NUM	),
	.BST_SEL				(BST_SEL		),
	.BST_PUL_NUM			(BST_PUL_NUM	),
	.PROT_FREQ				(PROT_FREQ		),
	.TRIG_PRE				(TRIG_PRE		),
	.BURST_DATA1			(BURST_DATA1	),
	.BURST_DATA2			(BURST_DATA2	),
	.BURST_DATA3			(BURST_DATA3	),
	.BURST_DATA4			(BURST_DATA4	),
	.BURST_DATA5			(BURST_DATA5	),
	.BURST_DATA6			(BURST_DATA6	),
	.BURST_DATA7			(BURST_DATA7	),
	.BURST_DATA8			(BURST_DATA8	),
	.BURST_DATA9			(BURST_DATA9	),
	.BURST_DATA10			(BURST_DATA10	),
    .BURST_DATA11			(BURST_DATA11	),
	.BURST_DATA12			(BURST_DATA12	),
	.BURST_DATA13			(BURST_DATA13	),
	.BURST_DATA14			(BURST_DATA14	),
	.BURST_DATA15			(BURST_DATA15	),
	.BURST_DATA16			(BURST_DATA16	),
	.BURST_DATA17			(BURST_DATA17	),
	.BURST_DATA18			(BURST_DATA18	),
	.BURST_DATA19			(BURST_DATA19	),
	.BURST_DATA20			(BURST_DATA20	),
	.FREQ_DIV_NUM			(FREQ_DIV_NUM	),	
	.AOM1_PULSE_NUM			(AOM1_PULSE_NUM	),
	.AOM1_PULSE_CLR			(AOM1_PULSE_CLR	),
	.TRIG_CNT				(		),	
	.TRIG_CLR				(		),	
	.POD_DELAY				(		),
	.AOM2_HEAD_DLY			(AOM2_HEAD_DLY	),
	.AOM2_TAIL_DLY			(AOM2_TAIL_DLY	),
	.FREE_TRIG_AOM2_MODE	(FREE_TRIG_AOM2_MODE),
	.SEED_SYNC_AOM1			(SEED_SYNC_AOM1	),
	.FREQ_TRIG				(		),	
	.THR1					(THR1			),
	.THR2					(THR2			),
	.THR3					(THR3			),
	.THR4					(THR4			),
	.THR5					(THR5			),
	.THR6					(THR6			),
	.THR7					(THR7			),
	.THR8					(THR8			),
	.THR9					(THR9			),
	.THR10					(THR10			),
	.K1						(K1				),
	.K2						(K2				),
	.K3						(K3				),
	.K4						(K4				),
	.K5						(K5				),
	.K6						(K6				),
	.K7						(K7				),
	.K8						(K8				),
	.K9						(K9				),
	.K10					(K10			),	
	.P3_THR					(P3_THR			),
	.P3_K					(P3_K			),
	.P6_THR					(P6_THR			),
	.P6_K					(P6_K			),
	.START_THR				(START_THR		),
	.P92_THR				(P92_THR		),
	.P92_K					(P92_K			),
	.P94_THR				(P94_THR		),
	.P94_K					(P94_K			),
	.P96_THR				(P96_THR		),
	.P96_K					(P96_K			),
	.P98_THR				(P98_THR		),
	.P98_K					(P98_K			),
	.POWER_K_SET			(POWER_K_SET	),
	.start_status			(start_status	),
	.error					(error			),
	.mode_lock_alm			(mode_lock_alm	),
	.PD1_PULSE_LV			(PD1_PULSE_LV	),
	.PD2_PULSE_LV			(PD2_PULSE_LV	),
	.MASTER_SPI_CS			(MASTER_SPI_CS		),
	.MASTER_SPI_SCLK		(MASTER_SPI_SCLK	),
	.MASTER_SPI_SDI 		(MASTER_SPI_SDI 	),
	.SLAVE_SPI_CS			(SLAVE_SPI_CS		),
	.SLAVE_SPI_SCLK			(SLAVE_SPI_SCLK		),
	.SLAVE_SPI_SDI			(SLAVE_SPI_SDI		),
	//spi
	.SPI_CS					(SPI_CS		),
	.SPI_SDI				(SPI_SDI	),
	.SPI_SCLK				(SPI_SCLK	),
	.SPI_SDO				(SPI_SDO	),
    //全光纤激光器新增
    .LASER_TYPE				(LASER_TYPE	),
    .PUMP5_IMAX				(PUMP5_IMAX),
    .PUMP5_DATA_out			(PUMP5_DATA_out),
    .ICR1_OPEN				(ICR1_OPEN),
    .ICR1_CLOSE				(ICR1_CLOSE),
    .ICR2_OPEN				(ICR2_OPEN),
    .ICR2_CLOSE				(ICR2_CLOSE),
    .SPACE_AOM_FULL_OPEN	(SPACE_AOM_FULL_OPEN),
    .AOM1_TTL2DAC_DLY		(AOM1_TTL2DAC_DLY),
    .SEED_SOURCE			(SEED_SOURCE),
    .INT_TRIG_PERIOD		(INT_TRIG_PERIOD),	
	.TRIG_SOURCE			(TRIG_SOURCE),
    .FIBER_AOM_FULL_OPEN_FRQ(FIBER_AOM_FULL_OPEN_FRQ),
    .FIBER_AOM_FULL_OPEN_EN (FIBER_AOM_FULL_OPEN_EN),
    .SPACE_AOM_FULL_OPEN_FRQ(SPACE_AOM_FULL_OPEN_FRQ),
    .SPACE_AOM_FULL_OPEN_EN (SPACE_AOM_FULL_OPEN_EN),
	.AIRPUMP1_PWM			(AIRPUMP_PWM1),
	.AIRPUMP2_PWM			(AIRPUMP_PWM2),
    .POD_DATA				(POD_DATA),
    .POD_NUM				(POD_NUM),
    .APM1_OK				(APM1_OK),
    .SPACE_AOM_LEV_CTL		(SPACE_AOM_LEV_CTL),
    .MD_DAC_CS				(MD_DAC_CS),   
	.MD_DAC_SCLK			(MD_DAC_SCLK),
	.MD_DAC_DOUT			(MD_DAC_DOUT)
    //.SPACE_AOM_SYNCLEV_CTL	(SPACE_AOM_SYNCLEV_CTL)
);
wire [9:0] AOM1_OUT;
wire [7:0] AOM3_OUT;
wire [9:0] AOM4_OUT;
assign	AOM1_DB = {AOM1_OUT,6'b0};
assign	AOM3_DB = {AOM3_OUT,6'b0};
assign	AOM4_DB = {AOM4_OUT,4'b0};

burst	burst(
	.clk_i				(clk_PD),
	.rstn_i				(pll_pd_lock),	//用pd的pll复位
	.EXT_TRIG			(SYS_TRIG),	
	.BST_NUM			(BST_NUM),
    .GHZ_BST_NUM		(GHZ_BST_NUM),
	.BST_PERIOD			(BST_PERIOD),
	.AOM1_DLY_FINE		(AOM1_DLY_FINE),
    .AOM1_DLY_COARSE	(AOM1_DLY_COARSE),
    .AOM1_TTL2DAC_DLY	(AOM1_TTL2DAC_DLY),
    
    .AOM3_DLY_FINE		(AOM3_DLY_FINE),
    .AOM3_DLY_COARSE	(AOM3_DLY_COARSE),
    .AOM3_PUL_NUM		(AOM3_PUL_NUM),
    
    .AOM4_DLY_FINE		(AOM4_DLY_FINE),
    .AOM4_DLY_COARSE	(AOM4_DLY_COARSE),
    .AOM4_PUL_NUM		(AOM4_PUL_NUM),
    
    .AOM1_DATA     (AOM1_DATA),
    .AOM3_DATA     (AOM3_DATA),
    .AOM4_DATA     (AOM4_DATA),
    
    .AOM3_FULL_OPEN (AOM3_FULL_OPEN),	//AOM3高度值
    .AOM4_FULL_OPEN (AOM4_FULL_OPEN),	//AOM4高度值
    
	.FREQ_DIV_NUM		(FREQ_DIV_NUM),
	.AOM_CTRL_SEL		(AOM_CTRL_SEL),
	.BST_END_CNT		(BST_END_CNT	),
//	.AOM2_HEAD_DLY		(AOM2_HEAD_DLY),
//	.AOM2_TAIL_DLY		(AOM2_TAIL_DLY),
	.SEED_SYNC_AOM1		(SEED_SYNC_AOM1),
	.BST_SEL			(BST_SEL),
	.BST_PUL_NUM		(BST_PUL_NUM),
	.PROT_FREQ			(PROT_FREQ		),
	.TRIG_PRE			(TRIG_PRE		),
	.BURST_DATA1		(BURST_DATA1	),
	.BURST_DATA2		(BURST_DATA2	),
	.BURST_DATA3		(BURST_DATA3	),
	.BURST_DATA4		(BURST_DATA4	),
	.BURST_DATA5		(BURST_DATA5	),
	.BURST_DATA6		(BURST_DATA6	),
	.BURST_DATA7		(BURST_DATA7	),
	.BURST_DATA8		(BURST_DATA8	),
	.BURST_DATA9		(BURST_DATA9	),
	.BURST_DATA10		(BURST_DATA10	),
    .BURST_DATA11		(BURST_DATA11	),
	.BURST_DATA12		(BURST_DATA12	),
	.BURST_DATA13		(BURST_DATA13	),
	.BURST_DATA14		(BURST_DATA14	),
	.BURST_DATA15		(BURST_DATA15	),
	.BURST_DATA16		(BURST_DATA16	),
	.BURST_DATA17		(BURST_DATA17	),
	.BURST_DATA18		(BURST_DATA18	),
	.BURST_DATA19		(BURST_DATA19	),
	.BURST_DATA20		(BURST_DATA20	),
	.TTL_DIV			(TTL_DIV),		//用于二级声光分频
	.TTL_tem			(TTL_tem),		//用于PD2测频判断
	.AOM2_EXP			(AOM2_EXP),		//用于AOM2提前开启和关闭判断
	.FIBER_AOM_DATA		(AOM1_OUT),
	.FIBER_AOM_CLK		(AOM1_CLK),
	.FIBER_AOM_TTL		(AOM1_TTL),		//一级声光TTL,实际正在出光
    .FIBER_AOM3_DATA	(AOM3_OUT),
	.FIBER_AOM3_CLK		(AOM3_CLK),
	.FIBER_AOM3_TTL		(AOM3_TTL),		//一级声光TTL,实际正在出光
    .FIBER_AOM4_DATA	(AOM4_OUT),
	.FIBER_AOM4_CLK		(AOM4_CLK),
	.FIBER_AOM4_TTL		(AOM4_TTL),		//一级声光TTL,实际正在出光
    .FIBER_AOM_FULL_OPEN_FRQ(FIBER_AOM_FULL_OPEN_FRQ),
    .FIBER_AOM_FULL_OPEN_EN (FIBER_AOM_FULL_OPEN_EN)
);

AOM2_TTL	AOM2_TTL_inst(
	.clk_i				(clk_PD_4times),
	.rstn_i				(pll_pd_lock),		//用pd的pll复位
	.AOM_CTRL_SEL		(AOM_CTRL_SEL	),
	.AOM2_HEAD_DLY		(AOM2_HEAD_DLY	),	//展宽
	.FREE_TRIG_AOM2_MODE(FREE_TRIG_AOM2_MODE),
	.AOM1_PULSE_CLR		(AOM1_PULSE_CLR),
	.AOM1_SW			(AOM2_EXP),			//一级声光TTL，无需延时
	.gate				(AOM2_CTRL),
	.pulse_data			(AOM1_PULSE_NUM),
	.AOM2_SW_out		(AOM2_SW),
    .SPACE_AOM_FULL_OPEN_FRQ(SPACE_AOM_FULL_OPEN_FRQ),
    .SPACE_AOM_FULL_OPEN_EN (SPACE_AOM_FULL_OPEN_EN),
    .BST_PERIOD			(BST_PERIOD),
    .POD_DATA			(POD_DATA),
    .POD_NUM			(POD_NUM),
    .LASER_TYPE			(LASER_TYPE	)
);

//EXT_PWM外接随机噪声信号，随机脉冲转换为10bit数据，与二级声光模拟量10bit数据按位相与，进而控制实际功率输出
//wire [9:0] RANDOM_DATA;
//Random_pulse2data	Random_pulse1(
//    .clk_i				(clk_50m),
//    .rstn_i				(pll_lock),
//    .din				(EXT_PWM),	
//    .dout				(RANDOM_DATA)
//);

//wire [13:0]	AOM3_OUT;
//assign AOM3_DB = (LASER_TYPE==18)?(AOM3_OUT>>4)&RANDOM_DATA:(AOM3_OUT>>4);//激光器类型为光纤20W带随机噪声发生模块时
//assign AOM3_DB = (RANDOM_DATA!=0&&LASER_TYPE==18)?(AOM3_OUT)& (~RANDOM_DATA):(AOM3_OUT);




//MS9714	AOM3(
//    .clk_i				(clk_50m),
//    .rstn_i				(pll_lock),
//    .din				({cal_dout,4'B0000}),	//声光校准后从AOM3输出
//    .clock				(AOM3_CLK),
//    .dout				(AOM3_OUT)
//);


//assign AOM4_DB = AOM4_OUT;
//MS9714	AOM4(
//    .clk_i				(clk_50m),
//    .rstn_i				(pll_lock),
//    .din				({AOM4_DATA,4'B0000}),
//    .clock				(AOM4_CLK),
//    .dout				(AOM4_OUT)
//);

fiber_break	fiber_break(
	.clk_i				(clk_50m),		//50m 20ns
	.rstn_i				(pll_lock),
	.EN					(alarm_en[0]),
	.clear				(clear),
	.protect_PD1		(PTOTE_PD2), //断纤,1正常0断纤
	.emission			(~SPACE_AOM_TTL),
	.start_status		(start_status),
	.fiber_break_delay	(fiber_break_delay),	//设为0不检测告警
	.fiber_alarm		(fiber_alarm)
);

alarm_mon	alarm_mon(
	.clk_i				(clk_50m),		//50m 20ns
	.rstn_i				(pll_lock),
	.PTOTE_PD1			(fiber_alarm),	//断纤,算法告警，1告警
	.PTOTE_PD2			(PTOTE_PD1),	//烧纤
	.PTOTE_PD3			(PTOTE_PD3),	//烧纤
	.LOW_24V			(LOW_24V),
	.INTER_LOCK1		(EXT_INTLK1),	
	.INTER_LOCK2		(EXT_INTLK2),	
	.MCU_ERR			(MCU_ERR),
	.MCU_ESTOP			(MCU_ESTOP),
	.ONLINE_DATA1		(ONLINE_DATA1),
	.ONLINE_DATA2		(ONLINE_DATA2),
	.mode_lock_alm		(mode_lock_alm),
	.SEQ_ALM			(SEQ_ALM),
	.pll_alm			(pll_alm),
	.SEED_OK			(SEED_OK),
	.PD1_LOW_ALM		(PD1_LOW_ALM),
	.PD2_LOW_ALM 		(PD2_LOW_ALM),
	.PD3_LOW_ALM 		(PD3_LOW_ALM),
	.PD1_freq			(PD1_freq),
	.PD2_freq    		(PD2_freq),
	.PD3_freq    		(PD3_freq),
	.FREQ1_THR_H		(FREQ1_THR_H),
	.FREQ2_THR_H 		(FREQ2_THR_H),
	.FREQ3_THR_H 		(FREQ3_THR_H),	
	.alarm_en			(alarm_en),		//告警屏蔽
	.clear				(clear),		//清除所有告警
	.alarm_now			(alarm_now),	//当前告警
	.alarm_lat			(alarm_lat),	//历史告警
	.alarm_out			(alarm_out),	//总告警，高级加低级
//	.PANEL_KEY		    (PANEL_KEY),
  //  .PANEL_ESTOP		(PANEL_ESTOP),
//    .HEAD_ERROR			(HEAD_ERROR),
    .alarm_en2			(alarm_en2	),	
	.alarm_now2			(alarm_now2	),
	.alarm_lat2			(alarm_lat2	),
	.alarm_out2			(alarm_out2	),
	.error				(error),		//任何告警输出，低级告警
	.lock				(lock),			//锁机输出,高级告警
	.FPGA_SW			(FPGA_SW)		//关断保护，正常输出1，异常输出0
);

/***********************外部输入8bit数字量同步采样********************/
data_sync	data_sync(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),
	.AD7801_data_in		(EXT_DATA),		
	.AD7801_LATCH		(EXT_LAT),
	.dout				(EXT_8BIT_SYNC)
);

/********************外部输入8bit(模拟量转数字量)采样*****************/
adc_ADS7883	ext_adc(
	.clk_i		(clk_50m		),
	.rstn_i		(pll_lock		),
    .AD_START	(AD_START		),
	.din		(EXT_AD_SDO		),
	.cs			(EXT_AD_CS		),
	.sclk		(EXT_AD_SCLK	),
	.dout		(ANALOG_12BIT	)	//外部模拟量
);
wire [13:0]			ad_result1;
PH1A_MULT12X2 PH1A_MULT18X4(	//12x2
	.a		(ANALOG_12BIT),
	.y		(3),
	.p      (ad_result1)
);
assign ANALOG_8BIT_AMP = ((ad_result1>>5)>=255)?255:(ad_result1>>5);	//外部输入模拟量放大1.5倍后(模拟量最大值2->3V)，再由12bit转为8bit

/********************激光功率控制模式选择*****************/
always @(*) begin
    case(POWER_CTRL_SEL)
		0:	cal_din = {EXT_8BIT_SYNC,2'b00};	//外部8bit数字量
		1:	cal_din = {ANALOG_8BIT_AMP,2'b00};	//外部模拟量转换成的8bit数据
		2:	cal_din = INT_8BIT;					//上位机设定的8bit(实际为10bit)
		3:	cal_din = cal_dac_set;				//功率校准模式下设定的8bit数据
		default : cal_din = INT_8BIT;
	endcase
end

/********************激光功率校准*****************/
wire 	[9:0]	din_lim	;
reg 	[9:0]	cal_din1; //校准限制前

power_lim	power_lim(
    .clk_i				(clk_50m),
	.rstn_i				(pll_lock),
    .din				(cal_din1),
    .POWER_K_SET		(POWER_K_SET),	//声光功率K值
    .dout				(din_lim)
);
always@(*) begin
	if(LASER_TYPE == 16 || LASER_TYPE == 17 || LASER_TYPE == 18 || LASER_TYPE == 21) begin//激光器类型是全光纤10W/20W，APM1是校准后电流输出，作为激光器整机功率控制
    	DATA_MAX = PUMP5_IMAX;  //最大值
        cal_dout = AOM_MAX;     //实际声光输出
        cal_din1 = (PUMP5_DATA_out>>2);  //实际是百分比值，接入泵浦驱动模块实现慢开关,12转10bit
        end
    else begin	//激光器类型是固体激光器或者控制二级声光的光纤激光器，APM1作为泵源正常输出电流
        DATA_MAX = AOM_MAX;    //声光最大值
        cal_dout = cal_dout1;  //实际声光输出
        cal_din1 = cal_din;
    end
end

calibration_aom	calibration_aom(
	.clk_i				(clk_50m),
	.rstn_i				(pll_lock),
	.POWER_CTRL_SEL		(POWER_CTRL_SEL),
	.din_i				(din_lim), //(cal_din	)
	.start_status		(start_status),
	.AOM_MAX			(DATA_MAX),
	.THR1_i 			(THR1), //十段AD校准值(段值)
	.THR2_i 			(THR2), 
	.THR3_i 			(THR3), 
	.THR4_i 			(THR4), 
	.THR5_i 			(THR5), 
	.THR6_i 			(THR6), 
	.THR7_i 			(THR7), 
	.THR8_i 			(THR8), 
	.THR9_i 			(THR9), 
	.THR10_i			(THR10),
	.K1_i 				(K1),    //校准K值   15位定点数+8位数据   
	.K2_i 				(K2), 
	.K3_i 				(K3), 
	.K4_i 				(K4), 
	.K5_i 				(K5), 
	.K6_i 				(K6), 
	.K7_i 				(K7), 
	.K8_i 				(K8), 
	.K9_i 				(K9), 
	.K10_i				(K10),
	.P3_THR				(P3_THR	),
	.P3_K				(P3_K	),
	.P6_THR				(P6_THR	),
	.P6_K				(P6_K	),
	.START_THR			(START_THR),
	.P92_THR			(P92_THR		), 
    .P92_K				(P92_K			), 
    .P94_THR			(P94_THR		), 
    .P94_K				(P94_K			), 
    .P96_THR			(P96_THR		), 
    .P96_K				(P96_K			), 
    .P98_THR			(P98_THR		), 
    .P98_K				(P98_K			), 
	.cal_dout_o			(cal_dout1)
);

wire [13:0]	AOM2_OUT;
assign AOM2_DB = AOM2_OUT;
MS9714	aom2_dac(
    .clk_i				(clk_50m),
    .rstn_i				(pll_lock),
    .din				({cal_dout,4'B0000}),	//声光校准后从AOM3输出
    .clock				(AOM2_CLK),
    .dout				(AOM2_OUT)
);





wire online_flag; //读取成功标志位

//50W桥接版在位信号和欠压信号检测    --地址7'b0100000
//300W桥接版2在位信号和欠压信号检测  --地址7'b0100001
reg [6:0] online_addr=7'b0100000;
reg [3:0] online_check_status=0;
wire [15:0] online_data_temp;
reg [15:0] online_data1_temp;
reg [15:0] online_data2_temp;


always @(posedge online_flag or negedge pll_lock)begin
	if(!pll_lock)
    begin
        online_addr<=7'b0100000;
        online_check_status<=0;
        online_data1_temp<=0;
        online_data2_temp<=0;
    end
	else case (online_check_status)
    
    0: begin 
    	online_data1_temp<=online_data_temp;
        online_addr<=7'b0100001;
        online_check_status<=1;
     end
    1:  begin	
     online_data2_temp<=online_data_temp;
     online_addr<=7'b0100000;
     online_check_status<=0;
       end
    default:
     begin	
    
     online_addr<=7'b0100000;
     online_check_status<=0;
     end

    endcase
end




PCA9555	online_1(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),	
	.AD_START			(AD_START),
	.SLAVE_ADDR			(online_addr),
    .SCL				(online1_SCL),	//max 400k,set 200k
	.SDA				(online1_SDA),
	.dout				(online_data_temp),
    .flag				(online_flag)
);




assign SEQ_ALM = {online_data1_temp[8],online_data2_temp[15:8],online_data1_temp[15:9]};	//欠压保护报警
assign ONLINE_DATA1={1'b0,online_data2_temp[7:0],online_data1_temp[6:0]};
assign ONLINE_DATA2=0;


/*
PCA9555	online_2(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),	
	.AD_START			(AD_START),
	.SLAVE_ADDR			(7'b0100001),
    .SCL				(online2_SCL),	//max 400k,set 200k
	.SDA				(online2_SDA),
	.dout				(ONLINE_DATA2),
    .flag				(flag2)
);


PCA9555	undervoltage_alarm(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),	
	.AD_START			(AD_START),
	.SCL				(TIME_SEQ_ALM_SCL),	//max 400k,set 200k
	.SDA				(TIME_SEQ_ALM_SDA),
	.dout				(SEQ_ALM)
);
*/

MOTOR	motor_1(
	.clk_i				(clk_50m),			//50M 20ns
	.rstn_i				(pll_lock),
	.AD_START			(AD_START),
	//.state			(MOTOR_state),
	.reset				(MOTOR1_reset	),	//1有效，拉高一个脉冲
	.period				(MOTOR1_period	),	//脉冲周期
	.step_num			(MOTOR1_step_num ),	//移动步数
	.step_sta			(MOTOR1_step_sta ),	//当前状态
	.overflow			(overflow_1),
	.BREAK_OUT			(BREAK_OUT_1),
	.cw					(MOTOR1_cw),		//正端
	.ccw				(MOTOR1_ccw),		//反端
	.pulse				(MOTOR1_pulse),		//周期大于1us，f<1MHz
	.direct				(MOTOR1_direct)		//1-正转，0-反转
);

/*------------水流量检测报警 -------------*/
FRENC_WATER	water_flow_detection(
	.clk_i			(clk_50m),
	.rstn_i			(pll_lock),			//低电平复位
	.pd_signal		(EXT_WATER_ALM),	//TTL输入接口
	.pd_freq 		(WATER_FREQ)		//输出是周期个数，测频周期 = (X+1)*系统时钟周期
);


//迭代版本使用EXT_TRIG 作为外控GATE入口
filter	filter_U0(
	.clk_i			(clk_100m),
	.rstn_i			(pll_lock),	//用pd的pll复位
	.signal			(EXT_TRIG),
	.dout			(EXT_GATE_OUT)
);

ICR	icr_1(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),
	.ICR_OPEN			(ICR1_OPEN),//上升沿进入光路
    .ICR_CLOSE			(ICR1_CLOSE),//上升沿离开光路
    .ICR_A				(ICR1_A),
    .ICR_B				(ICR1_B)
);
ICR	icr_2(
	.clk_i				(clk_50m),	//50M 20ns
	.rstn_i				(pll_lock),
	.ICR_OPEN			(ICR2_OPEN),//上升沿进入光路
    .ICR_CLOSE			(ICR2_CLOSE),//上升沿离开光路
    .ICR_A				(ICR2_A),
    .ICR_B				(ICR2_B)
);
/***********************面板绿色STATE状态指示灯状态********************/
led_green	led_green(
	.clk_i				(clk_50m),		//50m 20ns
	.rstn_i				(pll_lock),
	.emission			(~SPACE_AOM_TTL),
	.AP_OK				(SEED_OK),	//(AP_OK),	//开种子快闪
	.APM_OK				(AP_OK),	//(APM_OK),	//开预放更快闪
	.start_status		(start_status),
	.led_out			(EXT_STATE)	//1亮0灭
);

/***********************面板红色报警灯状态********************/
led	led_red(
	.clk_i				(clk_50m),		//50m 20ns
	.rstn_i				(pll_lock),
	.on					(lock),
	.flash				(error),
	.led_out			(EXT_ALM)		//1亮0灭
);
/*************选择信号打出到面板SYNC口，用于测试**************/
//wire AOM3_TTL_SYNC;
always @(*) begin
	case(TEST_IO_SEL)
			0:	EXT_SYNC1 = PD1_EXP;			//展宽后的PD1测频信号
			1:	EXT_SYNC1 = PD2_EXP;			//展宽后的PD2测频信号
			2:	EXT_SYNC1 = AOM1_TTL;			//AOM1选单信号	
			3:	EXT_SYNC1 = AOM2_TTL;			//AOM3二分频信号/出光信号	
			4:	EXT_SYNC1 = SYS_TRIG;			//外部给进来的TRIG信号
			5:	EXT_SYNC1 = AOM3_TTL;			//外部给进来的GATE异步信号同步化后的信号
			6:	EXT_SYNC1 = TTL_DIV;			//二分频因子信号
			7:	EXT_SYNC1 = clk_PD;				//测频信号，PLL后输出
    		8:	EXT_SYNC1 = FREQ_PD1;			//PD1进FPGA的原始信号
    		9:	EXT_SYNC1 = FREQ_PD2;			//PD2进FPGA的原始信号
    		10: EXT_SYNC1 = (AOM1_DB!=0)?1:0;	//AOM1 DAC模拟量有无
    		11: EXT_SYNC1 = (AOM2_DB!=0)?1:0;	//AOM3 DAC模拟量有无
			12:	EXT_SYNC1 = APM1_OK;
    		13: EXT_SYNC1 = error || lock; 		//报警信号
			14: EXT_SYNC1 = EXT_WATER_ALM;		//流量检测信号
    		15: EXT_SYNC1 = ~AOM2_TTL;			//空间声光TTL反向信号 
    		100:EXT_SYNC1 = AOM2_EXP;
    		101:EXT_SYNC1 = AOM2_CTRL;
            102:EXT_SYNC1 = online1_SCL;
            103:EXT_SYNC1 = online1_SDA;
            104:EXT_SYNC1 = clk_in;
	default :   EXT_SYNC1 = AOM1_TTL;
	endcase 
end
always @(*) begin
	case(TEST2_IO_SEL)
			0:	EXT_SYNC2 = PD1_EXP;			//展宽后的PD1测频信号
			1:	EXT_SYNC2 = PD2_EXP;			//展宽后的PD2测频信号
			2:	EXT_SYNC2 = AOM1_TTL;			//AOM1选单信号	
			3:	EXT_SYNC2 = AOM2_TTL;			//AOM3二分频信号/出光信号	
			4:	EXT_SYNC2 = SYS_TRIG;			//外部给进来的TRIG信号
			5:	EXT_SYNC2 = AOM3_TTL;			//外部给进来的GATE异步信号同步化后的信号
			6:	EXT_SYNC2 = TTL_DIV;			//二分频因子信号
			7:	EXT_SYNC2 = clk_PD;				//测频信号，PLL后输出
    		8:	EXT_SYNC2 = FREQ_PD1;			//PD1进FPGA的原始信号
    		9:	EXT_SYNC2 = FREQ_PD2;			//PD2进FPGA的原始信号
    		10: EXT_SYNC2 = (AOM1_DB!=0)?1:0;	//AOM1 DAC模拟量有无
    		11: EXT_SYNC2 = (AOM2_DB!=0)?1:0;	//AOM3 DAC模拟量有无
    		12: EXT_SYNC2 = APM1_OK;			//APM1
			13: EXT_SYNC2 = error || lock; 		//报警信号
    		14: EXT_SYNC2 = EXT_WATER_ALM;		//流量检测信号
    		15: EXT_SYNC2 = ~AOM2_TTL;			//空间声光TTL反向信号
            102:EXT_SYNC2 = online1_SCL;
            103:EXT_SYNC2 = online1_SDA;
	default :   EXT_SYNC2 = AOM1_TTL;
	endcase 
end

wire debug_led0;
led_debug	led_debug(
	.clk_i				(clk_50m),		//50m 20ns
	.rstn_i				(pll_lock),
	.led_out			(debug_led0)
);
assign debug_led[0] = debug_led0;
assign debug_led[1] = 1'b0;
endmodule
