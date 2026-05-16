module core(
	input					clk_i			,	//50M
	input					clk_100m		,
	input 					clk_PD			,
	input 					clk_PD_4times	,
	input					rstn_i			,
	//
	output 		 			AOM2_CTRL		,
	input 					TTL_DIV			,
	input					EXT_GATE		,
	input					EXT_PWM			,
	input					EXT_TRIG		,
	input					EXT_SYNC1		,
	input					EXT_STATE		,
	input					EXT_PRR			,
	input					EXT_SYNC2		,
	input					EXT_GUID		,
//	input 					PANEL_KEY		,  
//	input 					PANEL_ESTOP		,
	input [7:0]				EXT_DATA		,
	input					EXT_LAT			,
	input 					WATER_ALM		,
	//
	output 	 				SEED_OK			,
	output reg				AP_OK			,
	output reg 				APM_OK			,
	output reg 				AD_START		,			
	output reg [3:0]		WORK_MODE		,			
	output reg 				INT_ENABLE		,
	output reg [11:0]		DAC_MAX			,
	output reg [11:0]		AOM_MAX			,
	output reg 				ONLINE_PRG1		,
	output reg 				ONLINE_PRG2		,
	output reg [7:0]		TEST_IO_SEL		,
    output reg [7:0]		TEST2_IO_SEL	,
	input [1:0]				FPGA_SW			,
	input [16:0]			PD1_freq		,	
	input [15:0]			PD2_freq		,	
	input [15:0]			PD3_freq		,	
	input [31:0]			WATER_FREQ		,
	output reg [31:0]		alarm_en		,	
	output reg 				clear			,
	input [31:0]			alarm_now		,
	input [31:0]			alarm_lat		,
	input [31:0]			alarm_out		,
	output reg [31:0]		alarm_en2		,	
	input [31:0]			alarm_now2		,
	input [31:0]			alarm_lat2		,
	input [31:0]			alarm_out2		,
	input 					lock			,
	output reg [19:0]		fiber_break_delay,
	output reg [16:0]		FREQ1_THR_H		,
	output reg [15:0]		FREQ1_THR_L		,
	output reg [15:0]		FREQ2_THR_H		,
	output reg [15:0]		FREQ2_THR_L		,
	output reg [15:0]		FREQ3_THR_H		,
	output reg [15:0]		FREQ3_THR_L		,	
	output reg [7:0]		FREQ_ALARM_DLY	,
	output reg [7:0]		AOM2_DLY_COARSE	,
	output reg [7:0]		AOM2_DLY_FREE_TRIG,
	output reg [9:0]		INT_8BIT		,
	output reg [9:0]		cal_dac_set		,
	output reg [3:0]		POWER_CTRL_SEL	,
	output reg [3:0]		AOM_CTRL_SEL	,
	output reg [7:0]		BST_END_CNT		,
	input [7:0]				ANALOG_8BIT		,
	input [15:0]			ONLINE_DATA1	,
	input [15:0]			ONLINE_DATA2	,
	input [15:0]			SEQ_ALM			,
	input [9:0]				cal_din			,
	input [9:0]				cal_dout		,
	
	output reg [9:0]		AOM1_DATA		,
	input [7:0]				AOM2_DATA		,
	output reg [9:0]		AOM3_DATA		,
	output reg [9:0]		AOM4_DATA		,
	output reg 				AOM1_TTL		,	
	output reg 				AOM2_TTL		,	
	output reg 				AOM3_TTL		,	
	output reg 				AOM4_TTL		,	

	output reg 				MOTOR1_reset	,	
	output reg [31:0]		MOTOR1_period	,
	output reg [17:0]		MOTOR1_step_num	,
	input [17:0]			MOTOR1_step_sta ,
	output reg 				MOTOR2_reset	,	
	output reg [31:0]		MOTOR2_period	,
	output reg [17:0]		MOTOR2_step_num	,
	input [17:0]			MOTOR2_step_sta ,
	output reg 				MOTOR3_reset	,	
	output reg [31:0]		MOTOR3_period	,
	output reg [17:0]		MOTOR3_step_num	,
	input [17:0]			MOTOR3_step_sta ,
	output reg 				MOTOR4_reset	,	
	output reg [31:0]		MOTOR4_period	,
	output reg [17:0]		MOTOR4_step_num	,
	input [17:0]			MOTOR4_step_sta ,
	input [3:0]				MOTOR_overflow	,
	input [3:0]				MOTOR_BREAK_OUT	,
	output reg [4:0]		BST_NUM			,
    output reg [4:0]		GHZ_BST_NUM,
    output reg 				AOM3_FULL_OPEN,
    output reg 				AOM4_FULL_OPEN,
	output reg [15:0]		BST_PERIOD		,
	output reg [7:0]		AOM1_DLY_COARSE	,
    output reg [7:0]		AOM1_DLY_FINE	,
    output reg [7:0]		AOM3_DLY_FINE	,
    output reg [7:0]		AOM4_DLY_FINE	,
    output reg [7:0]		AOM3_DLY_COARSE	,
    output reg [7:0]		AOM4_DLY_COARSE	,
    output reg [11:0]		AOM3_PUL_NUM	,
    output reg [7:0]		AOM4_PUL_NUM	,
	output reg 				BST_SEL			,
	output reg [7:0]		BST_PUL_NUM		,
	output reg [7:0]		PROT_FREQ		,
	output reg [7:0]		TRIG_PRE		,
	output reg [7:0]		BURST_DATA1		,
	output reg [7:0]		BURST_DATA2		,
	output reg [7:0]		BURST_DATA3		,
	output reg [7:0]		BURST_DATA4		,
	output reg [7:0]		BURST_DATA5		,
	output reg [7:0]		BURST_DATA6		,
	output reg [7:0]		BURST_DATA7		,
	output reg [7:0]		BURST_DATA8		,
	output reg [7:0]		BURST_DATA9		,
	output reg [7:0]		BURST_DATA10	,
    output reg [7:0]		BURST_DATA11	,
	output reg [7:0]		BURST_DATA12	,
	output reg [7:0]		BURST_DATA13	,
	output reg [7:0]		BURST_DATA14	,
	output reg [7:0]		BURST_DATA15	,
	output reg [7:0]		BURST_DATA16	,
	output reg [7:0]		BURST_DATA17	,
	output reg [7:0]		BURST_DATA18	,
	output reg [7:0]		BURST_DATA19	,
	output reg [7:0]		BURST_DATA20	,
	output reg [23:0]		FREQ_DIV_NUM	,	
	input [15:0]			AOM1_PULSE_NUM	,
	output reg 				AOM1_PULSE_CLR	,
	input [15:0]			TRIG_CNT		,	
	output reg 				TRIG_CLR		,	
	output reg [7:0]		POD_DELAY		,
	output reg [15:0]		AOM2_HEAD_DLY	,
	output reg [3:0]		AOM2_TAIL_DLY	,
	output reg 				FREE_TRIG_AOM2_MODE,
	output reg 				SEED_SYNC_AOM1	,
	input [15:0]			FREQ_TRIG		,	
	output reg [9:0]		THR1			,
	output reg [9:0]		THR2			,
	output reg [9:0]		THR3			,
	output reg [9:0]		THR4			,
	output reg [9:0]		THR5			,
	output reg [9:0]		THR6			,
	output reg [9:0]		THR7			,
	output reg [9:0]		THR8			,
	output reg [9:0]		THR9			,
	output reg [9:0]		THR10			,
	output reg [31:0]		K1				,
	output reg [31:0]		K2				,
	output reg [31:0]		K3				,
	output reg [31:0]		K4				,
	output reg [31:0]		K5				,
	output reg [31:0]		K6				,
	output reg [31:0]		K7				,
	output reg [31:0]		K8				,
	output reg [31:0]		K9				,
	output reg [31:0]		K10				,
	output reg [9:0]		P3_THR			,
	output reg [31:0]		P3_K			,
	output reg [9:0]		P6_THR			,
	output reg [31:0]		P6_K			,
	output reg [9:0]		START_THR		,
	output reg [17:0]		POWER_K_SET		,
    output reg [9:0]		P92_THR			,
	output reg [31:0]		P92_K			,
 	output reg [9:0]		P94_THR			,
	output reg [31:0]		P94_K			,    
  	output reg [9:0]		P96_THR			,
	output reg [31:0]		P96_K			,   
  	output reg [9:0]		P98_THR			,
	output reg [31:0]		P98_K			,   
	output reg 				start_status	,
	input 					error			,
	output reg 		 		mode_lock_alm	,
	output reg [3:0]		PD1_PULSE_LV	,
	output reg [3:0]		PD2_PULSE_LV	,
	//master spi
	output 					MASTER_SPI_CS	,
	output 					MASTER_SPI_SCLK	,
	output 	 				MASTER_SPI_SDI 	,

	input 					SLAVE_SPI_CS	,
	input 					SLAVE_SPI_SCLK	,
	input 					SLAVE_SPI_SDI	,

	//spi
	input					SPI_CS	,
	input					SPI_SDI	,
	input					SPI_SCLK,
	output  				SPI_SDO	,	
    
    //全光纤激光器新增
    output reg	[7:0]		LASER_TYPE,	//激光器类型，8bit，0-30~50W固体，1-120W固体，2-200W固体，16-10W光纤(控电流),17-20W光纤(控电流),18-20W光纤(随机噪声)，19-10W光纤(控声光)，20-20W光纤(控声光)
    output reg	[11:0]		PUMP5_IMAX,	//PUMP5电流最大值，即全光纤10W/20W APM1最大值
    output		[11:0]		PUMP5_DATA_out,
    output reg				ICR1_OPEN,
    output reg				ICR1_CLOSE,
    output reg				ICR2_OPEN,
    output reg				ICR2_CLOSE,
    output reg				SPACE_AOM_FULL_OPEN,
    output reg	[7:0]		AOM1_TTL2DAC_DLY,
    output reg	[3:0]		SEED_SOURCE,
    output reg [15:0]		INT_TRIG_PERIOD	,
	output reg [3:0]		TRIG_SOURCE,
    output reg [15:0]		FIBER_AOM_FULL_OPEN_FRQ,
    output reg				FIBER_AOM_FULL_OPEN_EN,
    output reg [15:0]		SPACE_AOM_FULL_OPEN_FRQ,
    output reg				SPACE_AOM_FULL_OPEN_EN,
    output 					AIRPUMP1_PWM,
    output 					AIRPUMP2_PWM,
    output reg [24:0]		POD_DATA,
    output reg [7:0]		POD_NUM,
    output reg				APM1_OK,
    output reg				SPACE_AOM_LEV_CTL,
    output[14:0]			MD_DAC_CS,		//泵源驱动电流设定DAC，片选引脚
    output[14:0]			MD_DAC_SCLK,	//泵源驱动电流设定DAC，时钟引脚
    output[14:0]			MD_DAC_DOUT		//泵源驱动电流设定DAC，数据引脚
	//output reg				SPACE_AOM_SYNCLEV_CTL   
);
`include "parameter_def.v" 
//主FPGA版本
parameter FPGA_VER_0 = 6002	;   //大版本迭代：寄存器有增减,涉及到协议变更的，就要更新大版本
parameter FPGA_VER_1 = 4	;	//中版本迭代：不涉及寄存器改变的debug修复，小功能修复等，fpga本身的代码更新迭代
parameter FPGA_VER_2 = 13	;	//小版本迭代：0-测试调试用的版本，1-正式发布版本

//从FPGA版本
wire [15:0]	FPGA2_VER	;
wire [15:0]	FPGA2_VER_0,FPGA2_VER_1,FPGA2_VER_2;
assign FPGA2_VER_0 = 0	;		//大版本迭代：寄存器有增减,涉及到协议变更的，就要更新大版本               
assign FPGA2_VER_1 = 0	;       //中版本迭代：不涉及寄存器改变的debug修复，小功能修复等，fpga本身的代码更新迭代 
assign FPGA2_VER_2 = 0	;       //小版本迭代：0-测试调试用的版本，1-正式发布版本                   

parameter CHECK = 32'h5aa5;
//SPI
reg [31:0]		RDData	;
wire 			RD		;
wire 			WR		;
wire  [14:0]	RDAddr	;
wire  [14:0]	WrAddr	;
wire  [31:0]	WRData	;
//
reg 			PUMP_SW_SYNC;
reg [23:0]		PUMP1_RAMP_SPEED ,	PUMP1_SUB_SPEED		;
reg [23:0]		PUMP2_RAMP_SPEED ,	PUMP2_SUB_SPEED 	;
reg [23:0]		PUMP3_RAMP_SPEED ,	PUMP3_SUB_SPEED 	;
reg [23:0]		PUMP4_RAMP_SPEED ,	PUMP4_SUB_SPEED 	;
reg [23:0]		PUMP5_RAMP_SPEED ,	PUMP5_SUB_SPEED 	;
reg [23:0]		PUMP6_RAMP_SPEED ,	PUMP6_SUB_SPEED 	;
reg [23:0]		PUMP7_RAMP_SPEED ,	PUMP7_SUB_SPEED 	;
reg [23:0]		PUMP8_RAMP_SPEED ,	PUMP8_SUB_SPEED 	;
reg [23:0]		PUMP9_RAMP_SPEED ,	PUMP9_SUB_SPEED 	;
reg [23:0]		PUMP10_RAMP_SPEED,	PUMP10_SUB_SPEED 	;
reg [23:0]		PUMP11_RAMP_SPEED,	PUMP11_SUB_SPEED 	;
reg [23:0]		PUMP12_RAMP_SPEED,	PUMP12_SUB_SPEED 	;
reg [23:0]		PUMP13_RAMP_SPEED,	PUMP13_SUB_SPEED 	;
reg [23:0]		PUMP14_RAMP_SPEED,	PUMP14_SUB_SPEED 	;
reg [23:0]		PUMP15_RAMP_SPEED,	PUMP15_SUB_SPEED 	;
reg 			PUMP1_SW		;
reg 			PUMP2_SW		;
reg 			PUMP3_SW		;
reg 			PUMP4_SW		;
reg 			PUMP5_SW		;
reg 			PUMP6_SW		;
reg 			PUMP7_SW		;
reg 			PUMP8_SW		;
reg 			PUMP9_SW		;
reg 			PUMP10_SW 		;
reg 			PUMP11_SW 		;
reg 			PUMP12_SW 		;
reg 			PUMP13_SW 		;
reg 			PUMP14_SW 		;
reg 			PUMP15_SW 		;

reg [11:0]		PUMP1_DATA		;
reg [11:0]		PUMP2_DATA  	;
reg [11:0]		PUMP3_DATA  	;
reg [11:0]		PUMP4_DATA  	;
reg [11:0]		PUMP5_DATA  	;
reg [11:0]		PUMP6_DATA  	;
reg [11:0]		PUMP7_DATA  	;
reg [11:0]		PUMP8_DATA  	;
reg [11:0]		PUMP9_DATA  	;
reg [11:0]		PUMP10_DATA 	;
reg [11:0]		PUMP11_DATA 	;
reg [11:0]		PUMP12_DATA 	;
reg [11:0]		PUMP13_DATA 	;
reg [11:0]		PUMP14_DATA 	;
reg [11:0]		PUMP15_DATA		;

wire [11:0]		PUMP1_DATA_out	;	
wire [11:0]		PUMP2_DATA_out	;	
wire [11:0]		PUMP3_DATA_out	;	
wire [11:0]		PUMP4_DATA_out	;	
//wire [11:0]		PUMP5_DATA_out	;	
wire [11:0]		PUMP6_DATA_out	;	
wire [11:0]		PUMP7_DATA_out	;	
wire [11:0]		PUMP8_DATA_out	;	
wire [11:0]		PUMP9_DATA_out	;	
wire [11:0]		PUMP10_DATA_out	;
wire [11:0]		PUMP11_DATA_out	;
wire [11:0]		PUMP12_DATA_out	;
wire [11:0]		PUMP13_DATA_out	;
wire [11:0]		PUMP14_DATA_out	;
wire [11:0]		PUMP15_DATA_out	;

reg [3:0]		PUMP1_NUM		;
reg [3:0]		PUMP2_NUM		;
reg [3:0]		PUMP3_NUM		;
reg [3:0]		PUMP4_NUM		;
reg [3:0]		PUMP5_NUM		;
reg [3:0]		PUMP6_NUM		;
reg [3:0]		PUMP7_NUM		;
reg [3:0]		PUMP8_NUM		;
reg [3:0]		PUMP9_NUM		;
reg [3:0]		PUMP10_NUM		;
reg [3:0]		PUMP11_NUM		;
reg [3:0]		PUMP12_NUM		;
reg [3:0]		PUMP13_NUM		;
reg [3:0]		PUMP14_NUM		;
reg [3:0]		PUMP15_NUM		;
                            	
wire 			pump1_on		;
wire 			pump2_on		;
wire 			pump3_on		;
wire 			pump4_on		;
wire 			pump5_on		;
wire 			pump6_on		;
wire 			pump7_on		;
wire 			pump8_on		;
wire 			pump9_on		;
wire 			pump10_on		;
wire 			pump11_on		;
wire 			pump12_on		;
wire 			pump13_on		;
wire 			pump14_on		;
wire 			pump15_on		;

reg [16:0]		SEED_FREQ		;
reg 			mode_lock		;	//锁模	
reg [16:0]		PD1_freq_reg0,PD1_freq_reg1;
reg [16:0]		PD2_freq_reg0,PD2_freq_reg1;
reg [15:0]		AIRPUMP1_freq	;
reg [15:0]		AIRPUMP1_duty	;
reg [15:0]		AIRPUMP2_freq	;
reg [15:0]		AIRPUMP2_duty	;
reg				EXTSIG_VALID	;
reg [31:0]		CNT_APM_OK_DLY	;

reg		[11:0]		wr_data_temp;

reg 	trig_reg0,trig_reg1;
always @(posedge clk_PD_4times) begin 
	trig_reg0 <= EXT_TRIG;	
	trig_reg1 <= trig_reg0;
end 

/********************************************************************
功能：出光触发信号无信号的时候，延时1s，确定在这个时间范围内确实没有触发信号的时候，寄存器置0，给到MCU，MCU检测到
     100次客户触发无信号的时候，据此对激光器进行锁机处理，避免到期报警时客户正在使用出光对工件造成损坏。*/
reg				EXT_SIG_TO_LOCK ; //外部GATE/TRIG信号高电平展宽1s给到MCU，作为到期锁机报警外部输入信号的判断
reg [31:0]  	cnt_ext_sig;      //
parameter CNT_EXTSIG_MAX = 32'd50_000_000;//时间1s
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        cnt_ext_sig <= 0;
    else if(cnt_ext_sig == CNT_EXTSIG_MAX)
    	cnt_ext_sig <= 0;
    else case(AOM_CTRL_SEL)	//4bit，声光控制选择,0-内部设置，1-外部gate，2-常规trigger，3-free trigger
		0 	:	if(INT_ENABLE & TTL_DIV)
                	cnt_ext_sig <= 0;	
                else if(cnt_ext_sig < CNT_EXTSIG_MAX)
                	cnt_ext_sig <= cnt_ext_sig + 1;
		1	:	if(EXTSIG_VALID & EXT_GATE & TTL_DIV)
        			cnt_ext_sig <= 0;
                else if(cnt_ext_sig < CNT_EXTSIG_MAX)
                	cnt_ext_sig <= cnt_ext_sig + 1;
		2	:	if(EXTSIG_VALID && trig_reg0 && !trig_reg1)
					cnt_ext_sig <= 0;
                else if(cnt_ext_sig < CNT_EXTSIG_MAX)
                	cnt_ext_sig <= cnt_ext_sig + 1;
		3	:	if(EXTSIG_VALID && trig_reg0 && !trig_reg1)
					cnt_ext_sig <= 0;
                else if(cnt_ext_sig < CNT_EXTSIG_MAX)
                	cnt_ext_sig <= cnt_ext_sig + 1;
		default	:	cnt_ext_sig <= 0;
	endcase
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        EXT_SIG_TO_LOCK <= 0;  
    else if(cnt_ext_sig == CNT_EXTSIG_MAX)
    	EXT_SIG_TO_LOCK <= 0;        
    else case(AOM_CTRL_SEL)	//4bit，声光控制选择,0-内部设置，1-外部gate，2-常规trigger，3-free trigger
		0 	:	if(INT_ENABLE & TTL_DIV)
                	EXT_SIG_TO_LOCK <= 1;	
		1	:	if(EXTSIG_VALID & EXT_GATE & TTL_DIV)
        			EXT_SIG_TO_LOCK <= 1;
		2	:	if(EXTSIG_VALID && trig_reg0 && !trig_reg1)
					EXT_SIG_TO_LOCK <= 1;
		3	:	if(EXTSIG_VALID && trig_reg0 && !trig_reg1)
					EXT_SIG_TO_LOCK <= 1;
		default	:	EXT_SIG_TO_LOCK <= 0;
          endcase
end
/********************************************************************************************/

always @(posedge clk_i) begin
	PD1_freq_reg0 <= PD1_freq;
	PD1_freq_reg1 <= PD1_freq_reg0;
end 

always @(posedge clk_i) begin 
	PD2_freq_reg0 <= PD2_freq;
	PD2_freq_reg1 <= PD2_freq_reg0;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		start_status = 1'b0;
	else if(lock || error || WORK_MODE==OFF)//切模式不需要关pump || mode_change)
		start_status = 1'b0;
	else 
		start_status = 1'b1;
end

reg	AOM2_CTRL_TEMP;
always @(posedge clk_PD_4times or negedge rstn_i) begin
	if(!rstn_i)
		AOM2_CTRL_TEMP <= 0;
	else if(!start_status)
		AOM2_CTRL_TEMP <= 0;
	else case(AOM_CTRL_SEL)	//4bit，声光控制选择,0-内部设置，1-外部gate，2-常规trigger，3-free trigger
		0 	:	AOM2_CTRL_TEMP <= INT_ENABLE & TTL_DIV;	
		1	:	AOM2_CTRL_TEMP <= EXTSIG_VALID & EXT_GATE & TTL_DIV;
		2	:	if(EXTSIG_VALID && trig_reg0 && !trig_reg1)
					AOM2_CTRL_TEMP <= 1;
				else 
					AOM2_CTRL_TEMP <= 0;
		3	:	if(EXTSIG_VALID)
					AOM2_CTRL_TEMP <= 1;
				else 
					AOM2_CTRL_TEMP <= 0;

		default		:	AOM2_CTRL_TEMP <= INT_ENABLE & TTL_DIV; 
	endcase
end
   
   
 assign   AOM2_CTRL =  AOM2_CTRL_TEMP;
   
//(*keep*)wire AOM2_CTRL_PUL; 
//assign   AOM2_CTRL = AOM2_CTRL_PUL;
//OR_GATE_16	AOM2_CTRL_TEMP_PUL(            //为确保不丢拍，直接对所有的AOM2_CTRL_TEMP信号做4ns展宽，实际可以达到13.5ns的宽度
//	.dly_in				(AOM2_CTRL_TEMP),
//	.dly_num			(4'b1111),
//	.line				(rstn_i),
//	.dly_out			(AOM2_CTRL_PUL)
//);

//
wire [14:0]     PUMP1_PIR;	wire [14:0]     PUMP1_OR_PIR;
wire [14:0]     PUMP2_PIR;	wire [14:0]     PUMP2_OR_PIR;
wire [14:0]     PUMP3_PIR;	wire [14:0]     PUMP3_OR_PIR;
wire [14:0]     PUMP4_PIR;	wire [14:0]     PUMP4_OR_PIR;
wire [14:0]     PUMP5_PIR;	wire [14:0]     PUMP5_OR_PIR;
wire [14:0]     PUMP6_PIR;	wire [14:0]     PUMP6_OR_PIR;
wire [14:0]     PUMP7_PIR;	wire [14:0]     PUMP7_OR_PIR;
wire [14:0]     PUMP8_PIR;	wire [14:0]     PUMP8_OR_PIR;
wire [14:0]     PUMP9_PIR;	wire [14:0]     PUMP9_OR_PIR;
wire [14:0]     PUMP10_PIR;	wire [14:0]     PUMP10_OR_PIR;
wire [14:0]     PUMP11_PIR;	wire [14:0]     PUMP11_OR_PIR;
wire [14:0]     PUMP12_PIR;	wire [14:0]     PUMP12_OR_PIR;
wire [14:0]     PUMP13_PIR;	wire [14:0]     PUMP13_OR_PIR;
wire [14:0]     PUMP14_PIR;	wire [14:0]     PUMP14_OR_PIR;
wire [14:0]     PUMP15_PIR;	wire [14:0]     PUMP15_OR_PIR;


wire  		pump1_on_tem;
wire [14:0]	PUMP1_PIR_tem;

pump	pump1(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP1_NUM		),
    .PUMP_SW			(PUMP1_SW		),
    .PUMP_DATA			(PUMP1_DATA		),
    .RAMP_SPEED			(PUMP1_RAMP_SPEED		),
    .SUB_SPEED			(PUMP1_SUB_SPEED		),

    .OTHER_PIR1			(PUMP2_PIR		),
    .OTHER_PIR2			(PUMP3_PIR		),
    .OTHER_PIR3			(PUMP4_PIR		),
    .OTHER_PIR4			(PUMP5_PIR		),
    .OTHER_PIR5			(PUMP6_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP2_OR_PIR		),
	.OTHER_OR_PIR2 		(PUMP3_OR_PIR		),
	.OTHER_OR_PIR3 		(PUMP4_OR_PIR		),
	.OTHER_OR_PIR4 		(PUMP5_OR_PIR		),
	.OTHER_OR_PIR5 		(PUMP6_OR_PIR		),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR		),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR		),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR		),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR		),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR		),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR		),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR		),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR		),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR		),

    .PUMP_DATA_RAMP		(PUMP1_DATA_out	),
    .PUMP_PIR			(PUMP1_PIR_tem	),
	.PUMP_OR_PIR		(PUMP1_OR_PIR	),
    .PUMP_STA 			(pump1_on_tem 	)   //1开0关
);	

reg [27:0]	dly_3s;		//3_000_000_000 / 20 = 150_000_000
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		dly_3s <= 0;
	else if(PUMP1_DATA_out < PUMP1_DATA || PD1_freq_reg1<SEED_FREQ)
		dly_3s <= 0;
	else if(PUMP1_DATA_out >= PUMP1_DATA && PD1_freq_reg1>=SEED_FREQ && dly_3s<150_000_000)
		dly_3s <= dly_3s+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		mode_lock <= 0;
	else if(PUMP1_DATA_out < PUMP1_DATA &PUMP1_SW==0)
		mode_lock <= 0;
	else if(dly_3s==150_000_000)	//锁模成功
		mode_lock <= 1;
end

reg [28:0]	dly_10s;		//10_000_000_000 / 20 = 500_000_000		
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		dly_10s <= 0;
	else if(PUMP1_DATA_out < PUMP1_DATA) //
		dly_10s <= 0;
	else if(dly_10s < 500_000_000)
		dly_10s <= dly_10s+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		mode_lock_alm <= 0;
	else if(clear || alarm_en[31]==0)
		mode_lock_alm <= 0;
	else if(dly_10s == 500_000_000 && !mode_lock)	//种子电流开启后，超过10s没有稳定锁模，就报锁模报警
		mode_lock_alm <= 1;
end
   
assign pump1_on =  mode_lock & pump1_on_tem;
assign PUMP1_PIR = PUMP1_PIR_tem & {14'b11_1111_1111_1111,mode_lock};

//assign SEED_OK = pump1_on & (PUMP1_DATA_out >= PUMP1_DATA);
assign SEED_OK = pump1_on;

reg AP_OK_TEMP;
always@(*) begin
if((LASER_TYPE == 16 || LASER_TYPE == 17|| LASER_TYPE == 18 || LASER_TYPE == 19 || LASER_TYPE == 20 || LASER_TYPE == 21)&&pump3_on&&(PUMP3_DATA_out >= PUMP3_DATA))
    AP_OK_TEMP <= 1;
else if((LASER_TYPE == 0 || LASER_TYPE == 1 || LASER_TYPE == 2 )&&pump2_on&&(PUMP2_DATA_out >= PUMP2_DATA))
    AP_OK_TEMP <= 1;
else if((LASER_TYPE == 22) && pump4_on && (PUMP4_DATA_out >= PUMP4_DATA))	//医美机型，放在AP3后面
    AP_OK_TEMP <= 1;
else	
	AP_OK_TEMP <= 0;
end
parameter CNT_AP_OK_DLY = 5000000 ; //AP_OK后，延时时间1ms
reg [31:0] cnt_ap_ok;
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) 
		cnt_ap_ok <= 0;
	else if(AP_OK_TEMP&&cnt_ap_ok < CNT_AP_OK_DLY)
		cnt_ap_ok <= cnt_ap_ok+1;
    else if(!AP_OK_TEMP)
		cnt_ap_ok <= 0;
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) 
    	AP_OK <= 0;
    else if(cnt_ap_ok == CNT_AP_OK_DLY)
    	AP_OK <= 1;
    else
    	AP_OK <= 0;
end

/*APM1加载完成信号延时输出*/
reg [31:0] cnt_apm1_ok;
reg		   APM1_OK_TEMP;

always@(*) begin
	if((LASER_TYPE == 21)&&(WORK_MODE == NORMAL)) begin//激光器类型是双光子(无声光)类型，APM1的开关为外部触发信号与PUMP5_ON
    	if(AOM2_CTRL && (PUMP5_DATA_out >= PUMP5_DATA))
    		APM1_OK_TEMP <= 1;
		else	
			APM1_OK_TEMP <= 0;
     end
     else if(pump5_on && (PUMP5_DATA_out >= PUMP5_DATA))
    	APM1_OK_TEMP <= 1;
     else 
     	APM1_OK_TEMP <= 0;
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) 
		cnt_apm1_ok <= 0;
	else if(APM1_OK_TEMP&&cnt_apm1_ok < CNT_APM_OK_DLY)
		cnt_apm1_ok <= cnt_apm1_ok+1;
    else if(!APM1_OK_TEMP)
		cnt_apm1_ok <= 0;
end
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) 
    	APM1_OK <= 0;
    else if(APM1_OK_TEMP && cnt_apm1_ok == CNT_APM_OK_DLY)
    	APM1_OK <= 1;
    else
    	APM1_OK <= 0;
end

pump	pump2(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP2_NUM		),
    .PUMP_SW			(PUMP2_SW		),
    .PUMP_DATA			(PUMP2_DATA		),
    .RAMP_SPEED			(PUMP2_RAMP_SPEED		),
    .SUB_SPEED			(PUMP2_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP3_PIR		),
    .OTHER_PIR3			(PUMP4_PIR		),
    .OTHER_PIR4			(PUMP5_PIR		),
    .OTHER_PIR5			(PUMP6_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR		),
	.OTHER_OR_PIR2 		(PUMP3_OR_PIR		),
	.OTHER_OR_PIR3 		(PUMP4_OR_PIR		),
	.OTHER_OR_PIR4 		(PUMP5_OR_PIR		),
	.OTHER_OR_PIR5 		(PUMP6_OR_PIR		),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR		),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR		),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR		),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR		),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR		),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR		),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR		),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR		),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR		),
	
    .PUMP_DATA_RAMP		(PUMP2_DATA_out	),
    .PUMP_PIR			(PUMP2_PIR		),
	.PUMP_OR_PIR		(PUMP2_OR_PIR),
    .PUMP_STA 			(pump2_on	 	)   //1开0关
);	
pump	pump3(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP3_NUM		),
    .PUMP_SW			(PUMP3_SW		),
    .PUMP_DATA			(PUMP3_DATA		),
    .RAMP_SPEED			(PUMP3_RAMP_SPEED		),
    .SUB_SPEED			(PUMP3_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP4_PIR		),
    .OTHER_PIR4			(PUMP5_PIR		),
    .OTHER_PIR5			(PUMP6_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR		),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR		),
	.OTHER_OR_PIR3 		(PUMP4_OR_PIR		),
	.OTHER_OR_PIR4 		(PUMP5_OR_PIR		),
	.OTHER_OR_PIR5 		(PUMP6_OR_PIR		),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR		),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR		),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR		),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR		),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR		),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR		),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR		),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR		),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR		),
	
    .PUMP_DATA_RAMP		(PUMP3_DATA_out	),
    .PUMP_PIR			(PUMP3_PIR		),
	.PUMP_OR_PIR		(PUMP3_OR_PIR	),
    .PUMP_STA 			(pump3_on	 	)   //1开0关
);
pump	pump4(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP4_NUM		),
    .PUMP_SW			(PUMP4_SW		),
    .PUMP_DATA			(PUMP4_DATA		),
    .RAMP_SPEED			(PUMP4_RAMP_SPEED		),
    .SUB_SPEED			(PUMP4_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP5_PIR		),
    .OTHER_PIR5			(PUMP6_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR		),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR		),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR		),
	.OTHER_OR_PIR4 		(PUMP5_OR_PIR		),
	.OTHER_OR_PIR5 		(PUMP6_OR_PIR		),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR		),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR		),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR		),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR		),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR		),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR		),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR		),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR		),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR		),
	
    .PUMP_DATA_RAMP		(PUMP4_DATA_out	),
    .PUMP_PIR			(PUMP4_PIR		),
	.PUMP_OR_PIR		(PUMP4_OR_PIR	),
    .PUMP_STA 			(pump4_on	 	)   //1开0关
);	

reg [11:0]	PUMP5_DATA1;	//AOM DAC最大值
always@(*) begin
	if((LASER_TYPE == 16 || LASER_TYPE == 17 || LASER_TYPE == 18 || LASER_TYPE == 21)&&(WORK_MODE == NORMAL)) begin//激光器类型是全光纤10W/20W，APM1是校准后电流输出，作为激光器整机功率控制
    	PUMP5_DATA1 <= {cal_din,2'b00};
    end
    else begin	//激光器类型是固体激光器或者光纤(控声光)，APM1作为泵源正常输出电流
        PUMP5_DATA1 <= PUMP5_DATA;
    end
end

pump	pump5(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP5_NUM		),
    .PUMP_SW			(PUMP5_SW		),
    .PUMP_DATA			(PUMP5_DATA1	),		//
    .RAMP_SPEED			(PUMP5_RAMP_SPEED	),
    .SUB_SPEED			(PUMP5_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP6_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP5_DATA_out	),
    .PUMP_PIR			(PUMP5_PIR		),
	.PUMP_OR_PIR		(PUMP5_OR_PIR	),
    .PUMP_STA 			(pump5_on	 	)   //1开0关
);	
pump	pump6(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP6_NUM		),
    .PUMP_SW			(PUMP6_SW		),
    .PUMP_DATA			(PUMP6_DATA		),
    .RAMP_SPEED			(PUMP6_RAMP_SPEED		),
    .SUB_SPEED			(PUMP6_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP7_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR		),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR		),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR		),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR		),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR		),
	.OTHER_OR_PIR6 		(PUMP7_OR_PIR		),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR		),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR		),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR		),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR		),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR		),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR		),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR		),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR		),
	
    .PUMP_DATA_RAMP		(PUMP6_DATA_out	),
    .PUMP_PIR			(PUMP6_PIR		),
	.PUMP_OR_PIR		(PUMP6_OR_PIR	),
    .PUMP_STA 			(pump6_on	 	)   //1开0关
);	
pump	pump7(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP7_NUM		),
    .PUMP_SW			(PUMP7_SW		),
    .PUMP_DATA			(PUMP7_DATA		),
    .RAMP_SPEED			(PUMP7_RAMP_SPEED	),
    .SUB_SPEED			(PUMP7_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP8_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP7_DATA_out	),
    .PUMP_PIR			(PUMP7_PIR		),
	.PUMP_OR_PIR		(PUMP7_OR_PIR	),
    .PUMP_STA 			(pump7_on	 	)   //1开0关
);	
pump	pump8(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP8_NUM		),
    .PUMP_SW			(PUMP8_SW		),
    .PUMP_DATA			(PUMP8_DATA		),
    .RAMP_SPEED			(PUMP8_RAMP_SPEED	),
    .SUB_SPEED			(PUMP8_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP9_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP8_DATA_out	),
    .PUMP_PIR			(PUMP8_PIR		),
	.PUMP_OR_PIR		(PUMP8_OR_PIR	),
    .PUMP_STA 			(pump8_on	 	)   //1开0关
);	
pump	pump9(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP9_NUM		),
    .PUMP_SW			(PUMP9_SW		),
    .PUMP_DATA			(PUMP9_DATA		),
    .RAMP_SPEED			(PUMP9_RAMP_SPEED		),
    .SUB_SPEED			(PUMP9_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP10_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP9_DATA_out	),
    .PUMP_PIR			(PUMP9_PIR		),
	.PUMP_OR_PIR		(PUMP9_OR_PIR	),
    .PUMP_STA 			(pump9_on	 	)   //1开0关
);
pump	pump10(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP10_NUM		),
    .PUMP_SW			(PUMP10_SW		),
    .PUMP_DATA			(PUMP10_DATA		),
    .RAMP_SPEED			(PUMP10_RAMP_SPEED		),
    .SUB_SPEED			(PUMP10_SUB_SPEED		),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP11_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP10_DATA_out),
    .PUMP_PIR			(PUMP10_PIR		),
	.PUMP_OR_PIR		(PUMP10_OR_PIR	),
    .PUMP_STA 			(pump10_on	 	)   //1开0关
);

pump	pump11(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP11_NUM		),
    .PUMP_SW			(PUMP11_SW		),
    .PUMP_DATA			(PUMP11_DATA		),
    .RAMP_SPEED			(PUMP11_RAMP_SPEED	),
    .SUB_SPEED			(PUMP11_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP10_PIR		),
    .OTHER_PIR11		(PUMP12_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP11_DATA_out),
    .PUMP_PIR			(PUMP11_PIR		),
	.PUMP_OR_PIR		(PUMP11_OR_PIR	),
    .PUMP_STA 			(pump11_on	 	)   //1开0关
);
pump	pump12(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP12_NUM		),
    .PUMP_SW			(PUMP12_SW		),
    .PUMP_DATA			(PUMP12_DATA		),
    .RAMP_SPEED			(PUMP12_RAMP_SPEED	),
    .SUB_SPEED			(PUMP12_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP10_PIR		),
    .OTHER_PIR11		(PUMP11_PIR		),
    .OTHER_PIR12		(PUMP13_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP12_DATA_out),
    .PUMP_PIR			(PUMP12_PIR		),
	.PUMP_OR_PIR		(PUMP12_OR_PIR	),
    .PUMP_STA 			(pump12_on	 	)   //1开0关
);
pump	pump13(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP13_NUM		),
    .PUMP_SW			(PUMP13_SW		),
    .PUMP_DATA			(PUMP13_DATA		),
    .RAMP_SPEED			(PUMP13_RAMP_SPEED	),
    .SUB_SPEED			(PUMP13_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP10_PIR		),
    .OTHER_PIR11		(PUMP11_PIR		),
    .OTHER_PIR12		(PUMP12_PIR		),
    .OTHER_PIR13		(PUMP14_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP14_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP13_DATA_out),
    .PUMP_PIR			(PUMP13_PIR		),
	.PUMP_OR_PIR		(PUMP13_OR_PIR	),
    .PUMP_STA 			(pump13_on	 	)   //1开0关
);
pump	pump14(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP14_NUM		),
    .PUMP_SW			(PUMP14_SW		),
    .PUMP_DATA			(PUMP14_DATA		),
    .RAMP_SPEED			(PUMP14_RAMP_SPEED	),
    .SUB_SPEED			(PUMP14_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP10_PIR		),
    .OTHER_PIR11		(PUMP11_PIR		),
    .OTHER_PIR12		(PUMP12_PIR		),
    .OTHER_PIR13		(PUMP13_PIR		),
    .OTHER_PIR14		(PUMP15_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP15_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP14_DATA_out),
    .PUMP_PIR			(PUMP14_PIR		),
	.PUMP_OR_PIR		(PUMP14_OR_PIR	),
    .PUMP_STA 			(pump14_on	 	)   //1开0关
);
pump	pump15(
    .clk_i				(clk_i			),	//50M
    .rstn_i				(rstn_i			),
    .WORK_MODE			(WORK_MODE		),
    .lock				(lock			),
    .PUMP_NUM			(PUMP15_NUM		),
    .PUMP_SW			(PUMP15_SW		),
    .PUMP_DATA			(PUMP15_DATA		),
    .RAMP_SPEED			(PUMP15_RAMP_SPEED	),
    .SUB_SPEED			(PUMP15_SUB_SPEED	),

    .OTHER_PIR1			(PUMP1_PIR		),
    .OTHER_PIR2			(PUMP2_PIR		),
    .OTHER_PIR3			(PUMP3_PIR		),
    .OTHER_PIR4			(PUMP4_PIR		),
    .OTHER_PIR5			(PUMP5_PIR		),
    .OTHER_PIR6			(PUMP6_PIR		),
    .OTHER_PIR7			(PUMP7_PIR		),
    .OTHER_PIR8			(PUMP8_PIR		),
    .OTHER_PIR9			(PUMP9_PIR		),
    .OTHER_PIR10		(PUMP10_PIR		),
    .OTHER_PIR11		(PUMP11_PIR		),
    .OTHER_PIR12		(PUMP12_PIR		),
    .OTHER_PIR13		(PUMP13_PIR		),
    .OTHER_PIR14		(PUMP14_PIR		),
	.OTHER_OR_PIR1 		(PUMP1_OR_PIR	),
	.OTHER_OR_PIR2 		(PUMP2_OR_PIR	),
	.OTHER_OR_PIR3 		(PUMP3_OR_PIR	),
	.OTHER_OR_PIR4 		(PUMP4_OR_PIR	),
	.OTHER_OR_PIR5 		(PUMP5_OR_PIR	),
	.OTHER_OR_PIR6 		(PUMP6_OR_PIR	),
	.OTHER_OR_PIR7 		(PUMP7_OR_PIR	),
	.OTHER_OR_PIR8 		(PUMP8_OR_PIR	),
	.OTHER_OR_PIR9 		(PUMP9_OR_PIR	),
	.OTHER_OR_PIR10		(PUMP10_OR_PIR	),
	.OTHER_OR_PIR11		(PUMP11_OR_PIR	),
	.OTHER_OR_PIR12		(PUMP12_OR_PIR	),
	.OTHER_OR_PIR13		(PUMP13_OR_PIR	),
	.OTHER_OR_PIR14		(PUMP14_OR_PIR	),
	
    .PUMP_DATA_RAMP		(PUMP15_DATA_out),
    .PUMP_PIR			(PUMP15_PIR		),
	.PUMP_OR_PIR		(PUMP15_OR_PIR	),
    .PUMP_STA 			(pump15_on	 	)   //1开0关
);

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
		WORK_MODE <= 1;
		AOM_MAX <= 1000;
		PUMP1_NUM  <= 1;
		PUMP2_NUM  <= 2;
		PUMP3_NUM  <= 3;
		PUMP4_NUM  <= 4;
		PUMP5_NUM  <= 5;
		PUMP6_NUM  <= 6;
		PUMP7_NUM  <= 7;
		PUMP8_NUM  <= 8;
		PUMP9_NUM  <= 9;
		PUMP10_NUM <= 10;
		PUMP11_NUM <= 11;
		PUMP12_NUM <= 12;
		PUMP13_NUM <= 13;
		PUMP14_NUM <= 14;
		PUMP15_NUM <= 15;
		MOTOR1_period <= 196_605;
		MOTOR2_period <= 196_605;
		MOTOR3_period <= 196_605;
		MOTOR4_period <= 196_605;
		fiber_break_delay <= 250_000;
		FREQ1_THR_L <= 9;
		FREQ2_THR_L <= 9;
//		FREQ3_THR_L <= 9;
		TRIG_PRE <= 50;
		PROT_FREQ <= 2;
//		SEED_SYNC_AOM1 <= 1;
		PUMP1_RAMP_SPEED <= 949;	
		PUMP2_RAMP_SPEED <= 949;
		PUMP3_RAMP_SPEED <= 949;
		PUMP4_RAMP_SPEED <= 949;
		PUMP5_RAMP_SPEED <= 949;
		PUMP6_RAMP_SPEED <= 949;
		PUMP7_RAMP_SPEED <= 949;
		PUMP8_RAMP_SPEED <= 949;
		PUMP9_RAMP_SPEED <= 949;
		PUMP10_RAMP_SPEED <= 949; 
		PUMP11_RAMP_SPEED <= 949; 
		PUMP12_RAMP_SPEED <= 949; 
		PUMP13_RAMP_SPEED <= 949; 
		PUMP14_RAMP_SPEED <= 949; 
		PUMP15_RAMP_SPEED <= 949; 

		PUMP1_SUB_SPEED	<= 949;
		PUMP2_SUB_SPEED <= 949;
		PUMP3_SUB_SPEED <= 949;
		PUMP4_SUB_SPEED <= 949;
		PUMP5_SUB_SPEED <= 949;
		PUMP6_SUB_SPEED <= 949;
		PUMP7_SUB_SPEED <= 949;
		PUMP8_SUB_SPEED <= 949;
		PUMP9_SUB_SPEED <= 949;
		PUMP10_SUB_SPEED <= 949;
		PUMP11_SUB_SPEED <= 949;
		PUMP12_SUB_SPEED <= 949;
		PUMP13_SUB_SPEED <= 949;
		PUMP14_SUB_SPEED <= 949;
		PUMP15_SUB_SPEED <= 949;

		THR1  <= 102*1;	
		THR2  <= 102*2;	
		THR3  <= 102*3;	
		THR4  <= 102*4;	
		THR5  <= 102*5;	
		THR6  <= 102*6;	
		THR7  <= 102*7;	
		THR8  <= 102*8;	
		THR9  <= 102*9;	
		//THR10 <= 25*10;	
		K1	<= 32768;
		K2	<= 32768;
		K3	<= 32768;
		K4	<= 32768;
		K5	<= 32768;
		K6	<= 32768;
		K7	<= 32768;
		K8	<= 32768;
		K9	<= 32768;
		K10	<= 32768;

		P3_THR	<= 30;
		P3_K	<= 32768;
		P6_THR	<= 60;
		P6_K	<= 32768;
		START_THR <= 10;

		POWER_K_SET <= 32768;
		P92_THR	<= 102*9;
		P92_K	<= 32768;
		P94_THR	<= 102*9;
		P94_K	<= 32768;
		P96_THR	<= 102*9;
		P96_K	<= 32768;
		P98_THR	<= 102*9;
		P98_K	<= 32768;

		POWER_CTRL_SEL <= 2;
		SEED_FREQ <= 35_000;
		PD1_PULSE_LV <= 0;
		PD2_PULSE_LV <= 4;
		AOM2_HEAD_DLY <= 12;
		FREE_TRIG_AOM2_MODE <= 0;
		BST_END_CNT <= 12;
		LASER_TYPE	<= 8'd0;
        PUMP5_IMAX  <= 12'd200;
        SPACE_AOM_FULL_OPEN <= 0;
        AOM1_TTL2DAC_DLY <= 0;
        SEED_SOURCE <= 0;
        INT_TRIG_PERIOD	<= 4999;//默认10kHz
        TRIG_SOURCE		<= 0;	//默认外部EXT_TRIG信号
        FIBER_AOM_FULL_OPEN_FRQ <= 4;	//默认一级声光全部打开的选单频率为9MHz
        FIBER_AOM_FULL_OPEN_EN  <= 0;
        SPACE_AOM_FULL_OPEN_FRQ <= 36;//默认二级声光全部打开的选单频率为1MHz
        SPACE_AOM_FULL_OPEN_EN  <= 0;
		AIRPUMP1_freq <= 2500;	//气泵PWM频率默认20kHz
        AIRPUMP1_duty <= 1250;	//气泵PWM占空比默认50%
        AIRPUMP2_freq <= 2500;	//气泵PWM频率默认20kHz 
        AIRPUMP2_duty <= 1250;	//气泵PWM占空比默认50%  
        POD_DATA <= 1;
        POD_NUM <= 1;
        EXTSIG_VALID <= 1;
		alarm_en2 <= 0;	
        CNT_APM_OK_DLY <= 0;
        SPACE_AOM_LEV_CTL <= 0;
        
        AOM1_DLY_FINE<=0;
        AOM3_DLY_FINE<=0;
        AOM4_DLY_FINE<=0;
        GHZ_BST_NUM<=3;
        AOM3_FULL_OPEN<=0;
        AOM4_FULL_OPEN<=0;
        //SPACE_AOM_SYNCLEV_CTL <= 0;
		end 
	else if(WR)
		case(WrAddr)
		ID_AD_START				:	AD_START			<= WRData;
		ID_WORK_MODE			:	WORK_MODE			<= WRData;
		ID_INT_ENABLE			:	INT_ENABLE			<= WRData;
		//ID_DAC_MAX			:	DAC_MAX				<= WRData;
		ID_AOM_MAX				:	AOM_MAX				<= WRData;
		ID_ONLINE_PRG1			:	ONLINE_PRG1			<= WRData;
		ID_ONLINE_PRG2			:	ONLINE_PRG2			<= WRData;
		ID_TEST_IO_SEL			:	TEST_IO_SEL			<= WRData;
        ID_TEST2_IO_SEL			:	TEST2_IO_SEL		<= WRData;
		ID_SEED_SOURCE			:	SEED_SOURCE			<= WRData;
        ID_SEED_FREQ			:	SEED_FREQ			<= WRData;
		ID_PD1_PULSE_LV			:	PD1_PULSE_LV		<= WRData;
		ID_PD2_PULSE_LV			:	PD2_PULSE_LV		<= WRData;
		ID_alarm_en				:	alarm_en			<= WRData;
        ID_alarm_en2			:	alarm_en2			<= WRData;
		ID_clear				:	clear				<= WRData;
		ID_fiber_break_delay	:	fiber_break_delay	<= WRData;
		ID_FREQ1_THR_H			:	FREQ1_THR_H			<= WRData;
		ID_FREQ1_THR_L			:	FREQ1_THR_L			<= WRData;
		ID_FREQ2_THR_H			:	FREQ2_THR_H			<= WRData;
		ID_FREQ2_THR_L			:	FREQ2_THR_L			<= WRData;
	//	ID_FREQ3_THR_H			:	FREQ3_THR_H			<= WRData;
	//	ID_FREQ3_THR_L			:	FREQ3_THR_L			<= WRData;
		ID_FREQ_ALARM_DLY		:	FREQ_ALARM_DLY		<= WRData;
		ID_INT_8BIT				:	INT_8BIT			<= WRData;
		ID_cal_dac_set			:	cal_dac_set			<= WRData;
		ID_POWER_CTRL_SEL		:	POWER_CTRL_SEL		<= WRData;
		ID_AOM_CTRL_SEL			:	AOM_CTRL_SEL		<= WRData;
        ID_AOM1_TTL2DAC_DLY		:	AOM1_TTL2DAC_DLY	<= WRData;
		ID_AOM2_DLY_COARSE		:	AOM2_DLY_COARSE		<= WRData;
		ID_AOM2_DLY_FREE_TRIG	:	AOM2_DLY_FREE_TRIG	<= WRData;
		ID_AOM3_DLY_COARSE		:	AOM3_DLY_COARSE		<= WRData;
        ID_AOM4_DLY_COARSE		:	AOM4_DLY_COARSE		<= WRData;
		ID_AOM1_DATA			:	AOM1_DATA			<= WRData;
		//ID_AOM2_DATA			:	AOM2_DATA			<= WRData;
		ID_AOM3_DATA			:	AOM3_DATA			<= WRData;
		ID_AOM4_DATA			:	AOM4_DATA			<= WRData;
		ID_AOM1_TTL				:	AOM1_TTL			<= WRData;
		ID_AOM2_TTL				:	AOM2_TTL			<= WRData;
		ID_AOM3_TTL				:	AOM3_TTL			<= WRData;
		ID_AOM4_TTL				:	AOM4_TTL			<= WRData;

		ID_PUMP1_SW				:	PUMP1_SW 			<= WRData;
		ID_PUMP2_SW				:	PUMP2_SW 			<= WRData;
		ID_PUMP3_SW				:	PUMP3_SW 			<= WRData;
		ID_PUMP4_SW				:	PUMP4_SW 			<= WRData;
		ID_PUMP5_SW				:	PUMP5_SW 			<= WRData;
		ID_PUMP6_SW				:	PUMP6_SW 			<= WRData;
		ID_PUMP7_SW				:	PUMP7_SW 			<= WRData;
		ID_PUMP8_SW				:	PUMP8_SW 			<= WRData;
		ID_PUMP9_SW				:	PUMP9_SW 			<= WRData;
		ID_PUMP10_SW			:	PUMP10_SW 			<= WRData;
		ID_PUMP11_SW			:	PUMP11_SW 			<= WRData;
		ID_PUMP12_SW			:	PUMP12_SW 			<= WRData;
		ID_PUMP13_SW			:	PUMP13_SW 			<= WRData;
		ID_PUMP14_SW			:	PUMP14_SW 			<= WRData;
		ID_PUMP15_SW			:	PUMP15_SW 			<= WRData;

		ID_PUMP_SW_SYNC			:	PUMP_SW_SYNC			<= WRData;
		ID_PUMP1_RAMP_SPEED		:	PUMP1_RAMP_SPEED		<= WRData;
		ID_PUMP2_RAMP_SPEED 	:	PUMP2_RAMP_SPEED 		<= WRData;
		ID_PUMP3_RAMP_SPEED 	:	PUMP3_RAMP_SPEED 		<= WRData;
		ID_PUMP4_RAMP_SPEED 	:	PUMP4_RAMP_SPEED 		<= WRData;
		ID_PUMP5_RAMP_SPEED 	:	PUMP5_RAMP_SPEED 		<= WRData;
		ID_PUMP6_RAMP_SPEED 	:	PUMP6_RAMP_SPEED 		<= WRData;
		ID_PUMP7_RAMP_SPEED 	:	PUMP7_RAMP_SPEED 		<= WRData;
		ID_PUMP8_RAMP_SPEED 	:	PUMP8_RAMP_SPEED 		<= WRData;
		ID_PUMP9_RAMP_SPEED 	:	PUMP9_RAMP_SPEED 		<= WRData;
		ID_PUMP10_RAMP_SPEED	:	PUMP10_RAMP_SPEED		<= WRData;
		ID_PUMP11_RAMP_SPEED	:	PUMP11_RAMP_SPEED		<= WRData;
		ID_PUMP12_RAMP_SPEED	:	PUMP12_RAMP_SPEED		<= WRData;
		ID_PUMP13_RAMP_SPEED	:	PUMP13_RAMP_SPEED		<= WRData;
		ID_PUMP14_RAMP_SPEED	:	PUMP14_RAMP_SPEED		<= WRData;
		ID_PUMP15_RAMP_SPEED	:	PUMP15_RAMP_SPEED		<= WRData;

		ID_PUMP1_DATA			:	PUMP1_DATA				<= WRData;
		ID_PUMP2_DATA  			:	PUMP2_DATA  			<= WRData;
		ID_PUMP3_DATA  			:	PUMP3_DATA  			<= WRData;
		ID_PUMP4_DATA  			:	PUMP4_DATA  			<= WRData;
		ID_PUMP5_DATA  			:	PUMP5_DATA  			<= WRData;
		ID_PUMP6_DATA  			:	PUMP6_DATA  			<= WRData;
		ID_PUMP7_DATA  			:	PUMP7_DATA  			<= WRData;
		ID_PUMP8_DATA  			:	PUMP8_DATA  			<= WRData;
		ID_PUMP9_DATA  			:	PUMP9_DATA  			<= WRData;
		ID_PUMP10_DATA 			:	PUMP10_DATA 			<= WRData;
		ID_PUMP11_DATA 			:	PUMP11_DATA 			<= WRData;
		ID_PUMP12_DATA 			:	PUMP12_DATA 			<= WRData;
		ID_PUMP13_DATA 			:	PUMP13_DATA 			<= WRData;
		ID_PUMP14_DATA 			:	PUMP14_DATA 			<= WRData;
		ID_PUMP15_DATA			:	PUMP15_DATA				<= WRData;

		ID_PUMP1_NUM			:	PUMP1_NUM				<= WRData;
		ID_PUMP2_NUM			:	PUMP2_NUM				<= WRData;
		ID_PUMP3_NUM			:	PUMP3_NUM				<= WRData;
		ID_PUMP4_NUM			:	PUMP4_NUM				<= WRData;
		ID_PUMP5_NUM			:	PUMP5_NUM				<= WRData;
		ID_PUMP6_NUM			:	PUMP6_NUM				<= WRData;
		ID_PUMP7_NUM			:	PUMP7_NUM				<= WRData;
		ID_PUMP8_NUM			:	PUMP8_NUM				<= WRData;
		ID_PUMP9_NUM			:	PUMP9_NUM				<= WRData;
		ID_PUMP10_NUM			:	PUMP10_NUM				<= WRData;
		ID_PUMP11_NUM			:	PUMP11_NUM				<= WRData;
		ID_PUMP12_NUM			:	PUMP12_NUM				<= WRData;
		ID_PUMP13_NUM			:	PUMP13_NUM				<= WRData;
		ID_PUMP14_NUM			:	PUMP14_NUM				<= WRData;
		ID_PUMP15_NUM			:	PUMP15_NUM				<= WRData;

		ID_PUMP1_SUB_SPEED		:	PUMP1_SUB_SPEED			<= WRData;
		ID_PUMP2_SUB_SPEED 		:	PUMP2_SUB_SPEED 		<= WRData;
		ID_PUMP3_SUB_SPEED 		:	PUMP3_SUB_SPEED 		<= WRData;
		ID_PUMP4_SUB_SPEED 		:	PUMP4_SUB_SPEED 		<= WRData;
		ID_PUMP5_SUB_SPEED 		:	PUMP5_SUB_SPEED 		<= WRData;
		ID_PUMP6_SUB_SPEED 		:	PUMP6_SUB_SPEED 		<= WRData;
		ID_PUMP7_SUB_SPEED 		:	PUMP7_SUB_SPEED 		<= WRData;
		ID_PUMP8_SUB_SPEED 		:	PUMP8_SUB_SPEED 		<= WRData;
		ID_PUMP9_SUB_SPEED 		:	PUMP9_SUB_SPEED 		<= WRData;
		ID_PUMP10_SUB_SPEED 	:	PUMP10_SUB_SPEED 		<= WRData;
		ID_PUMP11_SUB_SPEED 	:	PUMP11_SUB_SPEED 		<= WRData;
		ID_PUMP12_SUB_SPEED 	:	PUMP12_SUB_SPEED 		<= WRData;
		ID_PUMP13_SUB_SPEED 	:	PUMP13_SUB_SPEED 		<= WRData;
		ID_PUMP14_SUB_SPEED 	:	PUMP14_SUB_SPEED 		<= WRData;
		ID_PUMP15_SUB_SPEED 	:	PUMP15_SUB_SPEED 		<= WRData;

		ID_MOTOR1_reset			:	MOTOR1_reset			<= WRData;
		ID_MOTOR1_period		:	MOTOR1_period			<= WRData;
		ID_MOTOR1_step_num		:	MOTOR1_step_num		<= WRData;
		ID_MOTOR2_reset			:	MOTOR2_reset			<= WRData;
		ID_MOTOR2_period		:	MOTOR2_period			<= WRData;
		ID_MOTOR2_step_num		:	MOTOR2_step_num		<= WRData;
		ID_MOTOR3_reset			:	MOTOR3_reset			<= WRData;
		ID_MOTOR3_period		:	MOTOR3_period			<= WRData;
		ID_MOTOR3_step_num		:	MOTOR3_step_num		<= WRData;
		ID_MOTOR4_reset			:	MOTOR4_reset			<= WRData;
		ID_MOTOR4_period		:	MOTOR4_period			<= WRData;
		ID_MOTOR4_step_num		:	MOTOR4_step_num		<= WRData;
		ID_BST_NUM				:	BST_NUM				<= WRData;
		ID_BST_PERIOD			:	BST_PERIOD			<= WRData;
        ID_GHZ_BST_NUM			:	GHZ_BST_NUM			<= WRData;
        ID_AOM3_FULL_OPEN		:	AOM3_FULL_OPEN		<= WRData;
        ID_AOM4_FULL_OPEN		:	AOM4_FULL_OPEN		<= WRData;	
        
		ID_AOM1_DLY_COARSE		:	AOM1_DLY_COARSE		<= WRData;
        ID_AOM1_DLY_FINE		:	AOM1_DLY_FINE		<= WRData;
        ID_AOM3_DLY_FINE		:	AOM3_DLY_FINE		<= WRData;
        ID_AOM4_DLY_FINE		:	AOM4_DLY_FINE		<= WRData;
		ID_BST_SEL				:	BST_SEL				<= WRData;
		ID_BST_PUL_NUM			:	BST_PUL_NUM			<= WRData;
		ID_BST_END_CNT			:	BST_END_CNT			<= WRData;
        ID_AOM3_PUL_NUM			:	AOM3_PUL_NUM		<= WRData;
        ID_AOM4_PUL_NUM			:	AOM4_PUL_NUM		<= WRData;
		ID_PROT_FREQ			:	PROT_FREQ			<= WRData;
		ID_TRIG_PRE				:	TRIG_PRE			<= WRData;
		ID_BURST_DATA1			:	BURST_DATA1			<= WRData;
		ID_BURST_DATA2			:	BURST_DATA2			<= WRData;
		ID_BURST_DATA3			:	BURST_DATA3			<= WRData;
		ID_BURST_DATA4			:	BURST_DATA4			<= WRData;
		ID_BURST_DATA5			:	BURST_DATA5			<= WRData;
		ID_BURST_DATA6			:	BURST_DATA6			<= WRData;
		ID_BURST_DATA7			:	BURST_DATA7			<= WRData;
		ID_BURST_DATA8			:	BURST_DATA8			<= WRData;
		ID_BURST_DATA9			:	BURST_DATA9			<= WRData;
		ID_BURST_DATA10			:	BURST_DATA10		<= WRData;
		ID_BURST_DATA11			:	BURST_DATA11		<= WRData;
		ID_BURST_DATA12			:	BURST_DATA12		<= WRData;
		ID_BURST_DATA13			:	BURST_DATA13		<= WRData;
		ID_BURST_DATA14			:	BURST_DATA14		<= WRData;
		ID_BURST_DATA15			:	BURST_DATA15		<= WRData;
		ID_BURST_DATA16			:	BURST_DATA16		<= WRData;
		ID_BURST_DATA17			:	BURST_DATA17		<= WRData;
		ID_BURST_DATA18			:	BURST_DATA18		<= WRData;
		ID_BURST_DATA19			:	BURST_DATA19		<= WRData;
		ID_BURST_DATA20			:	BURST_DATA20		<= WRData;        
        
		ID_FREQ_DIV_NUM			:	FREQ_DIV_NUM			<= WRData;
		ID_AOM1_PULSE_CLR		:	AOM1_PULSE_CLR		<= WRData;
		ID_TRIG_CLR				:	TRIG_CLR				<= WRData;
		ID_POD_DELAY			:	POD_DELAY				<= WRData;
		ID_AOM2_HEAD_DLY		:	AOM2_HEAD_DLY			<= WRData;
//		ID_AOM2_TAIL_DLY		:	AOM2_TAIL_DLY			<= WRData;
		ID_FREE_TRIG_AOM2_MODE	:	FREE_TRIG_AOM2_MODE		<= WRData;
//		ID_SEED_SYNC_AOM1		:	SEED_SYNC_AOM1			<= WRData;
		ID_THR1					:	THR1					<=WRData;
		ID_THR2					:	THR2					<=WRData;
		ID_THR3					:	THR3					<=WRData;
		ID_THR4					:	THR4					<=WRData;
		ID_THR5					:	THR5					<=WRData;
		ID_THR6					:	THR6					<=WRData;
		ID_THR7					:	THR7					<=WRData;
		ID_THR8					:	THR8					<=WRData;
		ID_THR9					:	THR9					<=WRData;
		ID_THR10				:	THR10					<=WRData;
		ID_K1					:	K1						<=WRData;
		ID_K2					:	K2						<=WRData;
		ID_K3					:	K3						<=WRData;
		ID_K4					:	K4						<=WRData;
		ID_K5					:	K5						<=WRData;
		ID_K6					:	K6						<=WRData;
		ID_K7					:	K7						<=WRData;
		ID_K8					:	K8						<=WRData;
		ID_K9					:	K9						<=WRData;
		ID_K10					:	K10						<=WRData;

		ID_P3_THR				:	P3_THR					<= WRData;
		ID_P3_K					:	P3_K					<= WRData;
		ID_P6_THR				:	P6_THR					<= WRData;
		ID_P6_K					:	P6_K					<= WRData;
		ID_START_THR			:	START_THR				<= WRData;
		ID_POWER_K_SET			:	POWER_K_SET				<= WRData;
		ID_P92_THR				:	P92_THR					<= WRData;
        ID_P92_K				:   P92_K					<= WRData;
        ID_P94_THR				:	P94_THR					<= WRData; 
        ID_P94_K				:   P94_K					<= WRData; 
        ID_P96_THR				:	P96_THR					<= WRData; 
        ID_P96_K				:   P96_K					<= WRData; 
        ID_P98_THR				:	P98_THR					<= WRData; 
        ID_P98_K				:   P98_K					<= WRData;       
        ID_LASER_TYPE			:	LASER_TYPE				<= WRData;
        ID_PUMP5_IMAX			:	PUMP5_IMAX				<= WRData;
        ID_ICR1_OPEN			:	ICR1_OPEN				<= WRData;
        ID_ICR1_CLOSE			:	ICR1_CLOSE				<= WRData;
        ID_ICR2_OPEN			:	ICR2_OPEN				<= WRData;
        ID_ICR2_CLOSE			:	ICR2_CLOSE				<= WRData;
        ID_SPACE_AOM_FULL_OPEN	:	SPACE_AOM_FULL_OPEN		<= WRData;
        ID_INT_TRIG_PERIOD		:	INT_TRIG_PERIOD			<= WRData;		
        ID_TRIG_SOURCE			:	TRIG_SOURCE				<= WRData;
        ID_FIBER_AOM_FULL_OPEN_FRQ: FIBER_AOM_FULL_OPEN_FRQ	<= WRData;
        ID_FIBER_AOM_FULL_OPEN_EN:  FIBER_AOM_FULL_OPEN_EN  <= WRData;
        ID_SPACE_AOM_FULL_OPEN_FRQ: SPACE_AOM_FULL_OPEN_FRQ <= WRData; 
        ID_SPACE_AOM_FULL_OPEN_EN : SPACE_AOM_FULL_OPEN_EN  <= WRData;
		ID_AIRPUMP1_freq		:	AIRPUMP1_freq			<= WRData;
		ID_AIRPUMP1_duty		:	AIRPUMP1_duty			<= WRData;
		ID_AIRPUMP2_freq		:	AIRPUMP2_freq			<= WRData;
		ID_AIRPUMP2_duty		:   AIRPUMP2_duty			<= WRData;
        ID_POD_DATA				:	POD_DATA 				<= WRData;
        ID_POD_NUM				:	POD_NUM 				<= WRData;
        ID_EXTSIG_VALID			:	EXTSIG_VALID			<= WRData;
        ID_CNT_APM_OK_DLY		:	CNT_APM_OK_DLY			<= WRData;
        ID_SPACE_AOM_LEV_CTL	:	SPACE_AOM_LEV_CTL		<= WRData;
		//ID_SPACE_AOM_SYNCLEV_CTL:	SPACE_AOM_SYNCLEV_CTL	<= WRData;
		default :	;
	endcase
	else begin 
		PUMP_SW_SYNC <= 0;	//只拉高一个周期
		MOTOR1_reset <= 0;
		MOTOR2_reset <= 0;
		MOTOR3_reset <= 0;
		MOTOR4_reset <= 0;
		if(start_status==0) begin 
			PUMP1_SW  <= 0; 
			PUMP2_SW  <= 0; 
			PUMP3_SW  <= 0; 
			PUMP4_SW  <= 0; 
			PUMP5_SW  <= 0; 
			PUMP6_SW  <= 0; 
			PUMP7_SW  <= 0; 
			PUMP8_SW  <= 0; 
			PUMP9_SW  <= 0; 
			PUMP10_SW <= 0;
			PUMP11_SW <= 0;
			PUMP12_SW <= 0;
			PUMP13_SW <= 0;
			PUMP14_SW <= 0;
			PUMP15_SW <= 0;
			INT_ENABLE <= 0;    
		end 
	end 

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		RDData <= 0;
	else if(RD)
		case(RDAddr)
		10:		RDData <= {lock,error,start_status}; 
        ID_FPGA_VER_0			:	RDData <= FPGA_VER_0	;
		ID_FPGA_VER_1			:	RDData <= FPGA_VER_1	;
		ID_FPGA_VER_2			:	RDData <= FPGA_VER_2	;
        
		ID_FPGA2_VER_0			:	RDData <= FPGA2_VER_0	;
        ID_FPGA2_VER_1			:	RDData <= FPGA2_VER_1	;
		ID_FPGA2_VER_2			:	RDData <= FPGA2_VER_2	;
		ID_AD_START				:	RDData <= AD_START		;
		ID_WORK_MODE			:	RDData <= WORK_MODE		;
		ID_CHECK				:	RDData <= CHECK			;
		ID_INT_ENABLE			:	RDData <= INT_ENABLE	;
		//ID_DAC_MAX				:	RDData <= DAC_MAX		;
		ID_AOM_MAX				:	RDData <= AOM_MAX			;
		ID_ONLINE_PRG1			:	RDData <= ONLINE_PRG1		;
		ID_ONLINE_PRG2			:	RDData <= ONLINE_PRG2		;
		ID_TEST_IO_SEL			:	RDData <= TEST_IO_SEL		;
        ID_TEST2_IO_SEL			:	RDData <= TEST2_IO_SEL		;
        ID_SEED_SOURCE			:	RDData <= SEED_SOURCE		;
		ID_FPGA_SW				:	RDData <= FPGA_SW			;
		ID_SEED_FREQ			:	RDData <= SEED_FREQ			;
		ID_PD1_PULSE_LV			:	RDData <= PD1_PULSE_LV		;
		ID_PD2_PULSE_LV			:	RDData <= PD2_PULSE_LV		;
		ID_mode_lock			:	RDData <= mode_lock			;
		ID_PD1_freq				:	RDData <= PD1_freq_reg1		;
		ID_PD2_freq				:	RDData <= PD2_freq_reg1		;
	//	ID_PD3_freq				:	RDData <= PD3_freq			;
		ID_WATER_FREQ			:	RDData <= WATER_FREQ		;
		ID_alarm_en				:	RDData <= alarm_en			;
		ID_clear				:	RDData <= clear			;
		ID_alarm_now			:	RDData <= alarm_now		;
		ID_alarm_lat			:	RDData <= alarm_lat		;
		ID_alarm_out			:	RDData <= alarm_out		;
        ID_alarm_en2			:	RDData <= alarm_en2		;
		ID_alarm_now2			:	RDData <= alarm_now2	;
		ID_alarm_lat2			:	RDData <= alarm_lat2	;
		ID_alarm_out2			:	RDData <= alarm_out2	;
		ID_fiber_break_delay	:	RDData <= fiber_break_delay;
		ID_FREQ1_THR_H			:	RDData <= FREQ1_THR_H		;
		ID_FREQ1_THR_L			:	RDData <= FREQ1_THR_L		;
		ID_FREQ2_THR_H			:	RDData <= FREQ2_THR_H		;
		ID_FREQ2_THR_L			:	RDData <= FREQ2_THR_L		;
	//	ID_FREQ3_THR_H			:	RDData <= FREQ3_THR_H		;
	//	ID_FREQ3_THR_L			:	RDData <= FREQ3_THR_L		;
		ID_FREQ_ALARM_DLY		:	RDData <= FREQ_ALARM_DLY	;
		ID_EXTER_IO				:	RDData <= {EXT_SIG_TO_LOCK,1'b0,1'b0,WATER_ALM,EXT_STATE,1'b0,1'b0,EXT_LAT,EXT_PRR,EXT_TRIG,EXT_PWM,EXT_GATE}	;
		ID_EXTER_8BIT			:	RDData <= EXT_DATA		;
		ID_AOM2_DLY_COARSE		:	RDData <= AOM2_DLY_COARSE	;	
		ID_AOM2_DLY_FREE_TRIG	:	RDData <= AOM2_DLY_FREE_TRIG	;
		ID_AOM3_DLY_COARSE		:	RDData <= AOM3_DLY_COARSE	;
        ID_AOM4_DLY_COARSE		:	RDData <= AOM4_DLY_COARSE	;
		ID_ANALOG_8BIT			:	RDData <= ANALOG_8BIT	;
		ID_INT_8BIT				:	RDData <= INT_8BIT		;
		ID_ONLINE_DATA1			:	RDData <= ONLINE_DATA1 ;
		ID_ONLINE_DATA2			:	RDData <= ONLINE_DATA2	;
		ID_ONLINE_FPGA2			:	RDData <= SEQ_ALM		;
		ID_cal_din				:	RDData <= cal_din		;
		ID_cal_dout				:	RDData <= cal_dout		;
		ID_cal_dac_set			:	RDData <= cal_dac_set	;
		ID_POWER_CTRL_SEL		:	RDData <= POWER_CTRL_SEL;
		ID_AOM_CTRL_SEL			:	RDData <= AOM_CTRL_SEL	;
		ID_AOM1_TTL2DAC_DLY		:	RDData <= AOM1_TTL2DAC_DLY;
		ID_AOM1_DATA			:	RDData <= AOM1_DATA		;
		ID_AOM2_DATA			:	RDData <= AOM2_DATA		;
		ID_AOM3_DATA			:	RDData <= AOM3_DATA		;
		ID_AOM4_DATA			:	RDData <= AOM4_DATA		;
		ID_AOM1_TTL				:	RDData <= AOM1_TTL			;
		ID_AOM2_TTL				:	RDData <= AOM2_TTL			;
		ID_AOM3_TTL				:	RDData <= AOM3_TTL			;
		ID_AOM4_TTL				:	RDData <= AOM4_TTL			;

		ID_PUMP1_SW				:	RDData <= PUMP1_SW		;
		ID_PUMP2_SW				:	RDData <= PUMP2_SW		;
		ID_PUMP3_SW				:	RDData <= PUMP3_SW		;
		ID_PUMP4_SW				:	RDData <= PUMP4_SW		;
		ID_PUMP5_SW				:	RDData <= PUMP5_SW		;
		ID_PUMP6_SW				:	RDData <= PUMP6_SW		;
		ID_PUMP7_SW				:	RDData <= PUMP7_SW		;
		ID_PUMP8_SW				:	RDData <= PUMP8_SW		;
		ID_PUMP9_SW				:	RDData <= PUMP9_SW		;
		ID_PUMP10_SW			:	RDData <= PUMP10_SW	;
		ID_PUMP11_SW			:	RDData <= PUMP11_SW	;
		ID_PUMP12_SW			:	RDData <= PUMP12_SW	;
		ID_PUMP13_SW			:	RDData <= PUMP13_SW	;
		ID_PUMP14_SW			:	RDData <= PUMP14_SW	;
		ID_PUMP15_SW			:	RDData <= PUMP15_SW	;

		ID_PUMP1_SW_out			:	RDData <= pump1_on	;
		ID_PUMP2_SW_out			:	RDData <= pump2_on	;
		ID_PUMP3_SW_out			:	RDData <= pump3_on	;
		ID_PUMP4_SW_out			:	RDData <= pump4_on	;
		ID_PUMP5_SW_out			:	RDData <= pump5_on	;
		ID_PUMP6_SW_out			:	RDData <= pump6_on	;
		ID_PUMP7_SW_out			:	RDData <= pump7_on	;
		ID_PUMP8_SW_out			:	RDData <= pump8_on	;
		ID_PUMP9_SW_out			:	RDData <= pump9_on	;
		ID_PUMP10_SW_out		:	RDData <= pump10_on	;
		ID_PUMP11_SW_out		:	RDData <= pump11_on	;
		ID_PUMP12_SW_out		:	RDData <= pump12_on	;
		ID_PUMP13_SW_out		:	RDData <= pump13_on	;
		ID_PUMP14_SW_out		:	RDData <= pump14_on	;
		ID_PUMP15_SW_out		:	RDData <= pump15_on	;

		ID_PUMP1_SUB_SPEED		:	RDData <= PUMP1_SUB_SPEED	;
		ID_PUMP2_SUB_SPEED 		:	RDData <= PUMP2_SUB_SPEED 	;
		ID_PUMP3_SUB_SPEED 		:	RDData <= PUMP3_SUB_SPEED 	;
		ID_PUMP4_SUB_SPEED 		:	RDData <= PUMP4_SUB_SPEED 	;
		ID_PUMP5_SUB_SPEED 		:	RDData <= PUMP5_SUB_SPEED 	;
		ID_PUMP6_SUB_SPEED 		:	RDData <= PUMP6_SUB_SPEED 	;
		ID_PUMP7_SUB_SPEED 		:	RDData <= PUMP7_SUB_SPEED 	;
		ID_PUMP8_SUB_SPEED 		:	RDData <= PUMP8_SUB_SPEED 	;
		ID_PUMP9_SUB_SPEED 		:	RDData <= PUMP9_SUB_SPEED 	;
		ID_PUMP10_SUB_SPEED 	:	RDData <= PUMP10_SUB_SPEED 	;
		ID_PUMP11_SUB_SPEED 	:	RDData <= PUMP11_SUB_SPEED 	;
		ID_PUMP12_SUB_SPEED 	:	RDData <= PUMP12_SUB_SPEED 	;
		ID_PUMP13_SUB_SPEED 	:	RDData <= PUMP13_SUB_SPEED 	;
		ID_PUMP14_SUB_SPEED 	:	RDData <= PUMP14_SUB_SPEED 	;
		ID_PUMP15_SUB_SPEED 	:	RDData <= PUMP15_SUB_SPEED 	;
	
		ID_PUMP_SW_SYNC			:	RDData <= PUMP_SW_SYNC		;
		ID_PUMP1_RAMP_SPEED		:	RDData <= PUMP1_RAMP_SPEED	;
		ID_PUMP2_RAMP_SPEED 	:	RDData <= PUMP2_RAMP_SPEED 	;
		ID_PUMP3_RAMP_SPEED 	:	RDData <= PUMP3_RAMP_SPEED 	;
		ID_PUMP4_RAMP_SPEED 	:	RDData <= PUMP4_RAMP_SPEED 	;
		ID_PUMP5_RAMP_SPEED 	:	RDData <= PUMP5_RAMP_SPEED 	;
		ID_PUMP6_RAMP_SPEED 	:	RDData <= PUMP6_RAMP_SPEED 	;
		ID_PUMP7_RAMP_SPEED 	:	RDData <= PUMP7_RAMP_SPEED 	;
		ID_PUMP8_RAMP_SPEED 	:	RDData <= PUMP8_RAMP_SPEED 	;
		ID_PUMP9_RAMP_SPEED 	:	RDData <= PUMP9_RAMP_SPEED 	;
		ID_PUMP10_RAMP_SPEED	:	RDData <= PUMP10_RAMP_SPEED 	;
		ID_PUMP11_RAMP_SPEED	:	RDData <= PUMP11_RAMP_SPEED 	;
		ID_PUMP12_RAMP_SPEED	:	RDData <= PUMP12_RAMP_SPEED 	;
		ID_PUMP13_RAMP_SPEED	:	RDData <= PUMP13_RAMP_SPEED 	;
		ID_PUMP14_RAMP_SPEED	:	RDData <= PUMP14_RAMP_SPEED 	;
		ID_PUMP15_RAMP_SPEED	:	RDData <= PUMP15_RAMP_SPEED 	;

		ID_PUMP1_DATA			:	RDData <= PUMP1_DATA		;
		ID_PUMP2_DATA  			:	RDData <= PUMP2_DATA  		;
		ID_PUMP3_DATA  			:	RDData <= PUMP3_DATA  		;
		ID_PUMP4_DATA  			:	RDData <= PUMP4_DATA  		;
		ID_PUMP5_DATA  			:	RDData <= PUMP5_DATA  		;
		ID_PUMP6_DATA  			:	RDData <= PUMP6_DATA  		;
		ID_PUMP7_DATA  			:	RDData <= PUMP7_DATA  		;
		ID_PUMP8_DATA  			:	RDData <= PUMP8_DATA  		;
		ID_PUMP9_DATA  			:	RDData <= PUMP9_DATA  		;
		ID_PUMP10_DATA 			:	RDData <= PUMP10_DATA 		;
		ID_PUMP11_DATA 			:	RDData <= PUMP11_DATA 		;
		ID_PUMP12_DATA 			:	RDData <= PUMP12_DATA 		;
		ID_PUMP13_DATA 			:	RDData <= PUMP13_DATA 		;
		ID_PUMP14_DATA 			:	RDData <= PUMP14_DATA 		;
		ID_PUMP15_DATA			:	RDData <= PUMP15_DATA		;
		ID_PUMP1_DATA_out		:	RDData <= PUMP1_DATA_out 	;
		ID_PUMP2_DATA_out		:	RDData <= PUMP2_DATA_out 	;
		ID_PUMP3_DATA_out		:	RDData <= PUMP3_DATA_out 	;
		ID_PUMP4_DATA_out		:	RDData <= PUMP4_DATA_out 	;
		ID_PUMP5_DATA_out		:	RDData <= wr_data_temp 		;
		ID_PUMP6_DATA_out		:	RDData <= PUMP6_DATA_out 	;
		ID_PUMP7_DATA_out		:	RDData <= PUMP7_DATA_out 	;
		ID_PUMP8_DATA_out		:	RDData <= PUMP8_DATA_out 	;
		ID_PUMP9_DATA_out		:	RDData <= PUMP9_DATA_out 	;
		ID_PUMP10_DATA_out		:	RDData <= PUMP10_DATA_out	;
		ID_PUMP11_DATA_out		:	RDData <= PUMP11_DATA_out	;
		ID_PUMP12_DATA_out		:	RDData <= PUMP12_DATA_out	;
		ID_PUMP13_DATA_out		:	RDData <= PUMP13_DATA_out	;
		ID_PUMP14_DATA_out		:	RDData <= PUMP14_DATA_out	;
		ID_PUMP15_DATA_out		:	RDData <= PUMP15_DATA_out	;

		ID_PUMP1_NUM			:	RDData <= PUMP1_NUM			;
		ID_PUMP2_NUM			:	RDData <= PUMP2_NUM			;
		ID_PUMP3_NUM			:	RDData <= PUMP3_NUM			;
		ID_PUMP4_NUM			:	RDData <= PUMP4_NUM			;
		ID_PUMP5_NUM			:	RDData <= PUMP5_NUM			;
		ID_PUMP6_NUM			:	RDData <= PUMP6_NUM			;
		ID_PUMP7_NUM			:	RDData <= PUMP7_NUM			;
		ID_PUMP8_NUM			:	RDData <= PUMP8_NUM			;
		ID_PUMP9_NUM			:	RDData <= PUMP9_NUM			;
		ID_PUMP10_NUM			:	RDData <= PUMP10_NUM		;
		ID_PUMP11_NUM			:	RDData <= PUMP11_NUM		;
		ID_PUMP12_NUM			:	RDData <= PUMP12_NUM		;
		ID_PUMP13_NUM			:	RDData <= PUMP13_NUM		;
		ID_PUMP14_NUM			:	RDData <= PUMP14_NUM		;
		ID_PUMP15_NUM			:	RDData <= PUMP15_NUM		;
		ID_MOTOR1_reset			:	RDData <= MOTOR1_reset		;
		ID_MOTOR1_period		:	RDData <= MOTOR1_period		;
		ID_MOTOR1_step_num		:	RDData <= MOTOR1_step_num	;
		ID_MOTOR1_step_sta		:	RDData <= MOTOR1_step_sta	;
		ID_MOTOR2_reset			:	RDData <= MOTOR2_reset		;
		ID_MOTOR2_period		:	RDData <= MOTOR2_period		;
		ID_MOTOR2_step_num		:	RDData <= MOTOR2_step_num	;
		ID_MOTOR2_step_sta		:	RDData <= MOTOR2_step_sta	;
		ID_MOTOR3_reset			:	RDData <= MOTOR3_reset		;
		ID_MOTOR3_period		:	RDData <= MOTOR3_period		;
		ID_MOTOR3_step_num		:	RDData <= MOTOR3_step_num	;
		ID_MOTOR3_step_sta		:	RDData <= MOTOR3_step_sta	;
		ID_MOTOR4_reset			:	RDData <= MOTOR4_reset		;
		ID_MOTOR4_period		:	RDData <= MOTOR4_period		;
		ID_MOTOR4_step_num		:	RDData <= MOTOR4_step_num	;
		ID_MOTOR4_step_sta		:	RDData <= MOTOR4_step_sta	;
		ID_MOTOR_overflow		:	RDData <= MOTOR_overflow	;
		ID_MOTOR_BREAK_OUT		:	RDData <= MOTOR_BREAK_OUT	;
		ID_BST_NUM				:	RDData <= BST_NUM			;
		ID_BST_PERIOD			:	RDData <= BST_PERIOD		;
        ID_GHZ_BST_NUM			:	RDData <= GHZ_BST_NUM	;
        ID_AOM3_FULL_OPEN		:	RDData <= AOM3_FULL_OPEN	;
        ID_AOM4_FULL_OPEN		:	RDData <= AOM4_FULL_OPEN	;
        
		ID_AOM1_DLY_COARSE		:	RDData <= AOM1_DLY_COARSE	;
        ID_AOM1_DLY_FINE		:	RDData <= AOM1_DLY_FINE		;
        ID_AOM3_DLY_FINE		:	RDData <= AOM3_DLY_FINE		;
        ID_AOM4_DLY_FINE		:	RDData <= AOM4_DLY_FINE		;
		ID_BST_SEL				:	RDData <= BST_SEL			;
		ID_BST_PUL_NUM			:	RDData <= BST_PUL_NUM		;
		ID_BST_END_CNT			:	RDData <= BST_END_CNT		;
        ID_AOM3_PUL_NUM			:	RDData <= AOM3_PUL_NUM		;
        ID_AOM4_PUL_NUM			:	RDData <= AOM4_PUL_NUM		;
		ID_PROT_FREQ			:	RDData <= PROT_FREQ			;
		ID_TRIG_PRE				:	RDData <= TRIG_PRE			;
		ID_BURST_DATA1			:	RDData <= BURST_DATA1		;
		ID_BURST_DATA2			:	RDData <= BURST_DATA2		;
		ID_BURST_DATA3			:	RDData <= BURST_DATA3		;
		ID_BURST_DATA4			:	RDData <= BURST_DATA4		;
		ID_BURST_DATA5			:	RDData <= BURST_DATA5		;
		ID_BURST_DATA6			:	RDData <= BURST_DATA6		;
		ID_BURST_DATA7			:	RDData <= BURST_DATA7		;
		ID_BURST_DATA8			:	RDData <= BURST_DATA8		;
		ID_BURST_DATA9			:	RDData <= BURST_DATA9		;
		ID_BURST_DATA10			:	RDData <= BURST_DATA10		;
		ID_BURST_DATA11			:	RDData <= BURST_DATA11		;
		ID_BURST_DATA12			:	RDData <= BURST_DATA12		;
		ID_BURST_DATA13			:	RDData <= BURST_DATA13		;
		ID_BURST_DATA14			:	RDData <= BURST_DATA14		;
		ID_BURST_DATA15			:	RDData <= BURST_DATA15		;
		ID_BURST_DATA16			:	RDData <= BURST_DATA16		;
		ID_BURST_DATA17			:	RDData <= BURST_DATA17		;
		ID_BURST_DATA18			:	RDData <= BURST_DATA18		;
		ID_BURST_DATA19			:	RDData <= BURST_DATA19		;
		ID_BURST_DATA20			:	RDData <= BURST_DATA20		;        
        
        
		ID_FREQ_DIV_NUM			:	RDData <= FREQ_DIV_NUM		;
		ID_AOM1_PULSE_NUM		:	RDData <= AOM1_PULSE_NUM	;
		ID_AOM1_PULSE_CLR		:	RDData <= AOM1_PULSE_CLR	;
		ID_TRIG_CNT				:	RDData <= TRIG_CNT			;
		ID_TRIG_CLR				:	RDData <= TRIG_CLR			;
		ID_POD_DELAY			:	RDData <= POD_DELAY			;
		ID_AOM2_HEAD_DLY		:	RDData <= AOM2_HEAD_DLY		;
//		ID_AOM2_TAIL_DLY		:	RDData <= AOM2_TAIL_DLY		;
//		ID_SEED_SYNC_AOM1		:	RDData <= SEED_SYNC_AOM1	;
		ID_FREQ_TRIG			:	RDData <= FREQ_TRIG			;
		ID_FREE_TRIG_AOM2_MODE	:	RDData <= FREE_TRIG_AOM2_MODE;
		ID_THR1					:	RDData <= THR1				;
		ID_THR2					:	RDData <= THR2				;
		ID_THR3					:	RDData <= THR3				;
		ID_THR4					:	RDData <= THR4				;
		ID_THR5					:	RDData <= THR5				;
		ID_THR6					:	RDData <= THR6				;
		ID_THR7					:	RDData <= THR7				;
		ID_THR8					:	RDData <= THR8				;
		ID_THR9					:	RDData <= THR9				;
		ID_THR10				:	RDData <= THR10				;
		ID_K1					:	RDData <= K1				;
		ID_K2					:	RDData <= K2				;
		ID_K3					:	RDData <= K3				;
		ID_K4					:	RDData <= K4				;
		ID_K5					:	RDData <= K5				;
		ID_K6					:	RDData <= K6				;
		ID_K7					:	RDData <= K7				;
		ID_K8					:	RDData <= K8				;
		ID_K9					:	RDData <= K9				;
		ID_K10					:	RDData <= K10				;
		ID_P3_THR				:	RDData <= P3_THR			;
		ID_P3_K					:	RDData <= P3_K				;
		ID_P6_THR				:	RDData <= P6_THR			;
		ID_P6_K					:	RDData <= P6_K				;
		ID_START_THR			:	RDData <= START_THR			;
		ID_POWER_K_SET			:	RDData <= POWER_K_SET		;
        ID_P92_THR				:	RDData <= P92_THR			;
		ID_P92_K				:	RDData <= P92_K				;
        ID_P94_THR				:	RDData <= P94_THR			;
		ID_P94_K				:	RDData <= P94_K				;
        ID_P96_THR				:	RDData <= P96_THR			;
		ID_P96_K				:	RDData <= P96_K				;
        ID_P98_THR				:	RDData <= P98_THR			;
		ID_P98_K				:	RDData <= P98_K				;
        ID_LASER_TYPE			:	RDData <= LASER_TYPE		;
        ID_PUMP5_IMAX			:	RDData <= PUMP5_IMAX		;
        ID_ICR1_OPEN			:	RDData <= ICR1_OPEN			;
        ID_ICR1_CLOSE			:	RDData <= ICR1_CLOSE		;
        ID_ICR2_OPEN			:	RDData <= ICR2_OPEN			;
        ID_ICR2_CLOSE			:	RDData <= ICR2_CLOSE		;
        ID_SPACE_AOM_FULL_OPEN	:	RDData <= SPACE_AOM_FULL_OPEN;
        ID_INT_TRIG_PERIOD		:	RDData <= INT_TRIG_PERIOD	;
        ID_TRIG_SOURCE			:	RDData <= TRIG_SOURCE		;
        ID_FIBER_AOM_FULL_OPEN_FRQ :RDData <= FIBER_AOM_FULL_OPEN_FRQ;
        ID_FIBER_AOM_FULL_OPEN_EN:	RDData <= FIBER_AOM_FULL_OPEN_EN;
        ID_SPACE_AOM_FULL_OPEN_FRQ: RDData <= SPACE_AOM_FULL_OPEN_FRQ; 
        ID_SPACE_AOM_FULL_OPEN_EN : RDData <= SPACE_AOM_FULL_OPEN_EN ;
        ID_AIRPUMP1_freq		:	RDData <= AIRPUMP1_freq		;
		ID_AIRPUMP1_duty		:	RDData <= AIRPUMP1_duty		;
		ID_AIRPUMP2_freq		:	RDData <= AIRPUMP2_freq		;
		ID_AIRPUMP2_duty		:   RDData <= AIRPUMP2_duty		;
        ID_POD_DATA				:	RDData <= POD_DATA	;
        ID_POD_NUM				:	RDData <= POD_NUM	;
        ID_EXTSIG_VALID			:	RDData <= EXTSIG_VALID	;
        ID_CNT_APM_OK_DLY		:	RDData <= CNT_APM_OK_DLY;
        ID_SPACE_AOM_LEV_CTL	:	RDData <= SPACE_AOM_LEV_CTL		;
		//ID_SPACE_AOM_SYNCLEV_CTL:	RDData <= SPACE_AOM_SYNCLEV_CTL	;
		default		 :	RDData <= 0;
endcase	

//FPGA与MCU SPI通信
spi spi(
	.CLK			(clk_i		),
	.SPI_CS			(SPI_CS		),
	.SPI_SDI		(SPI_SDI	),
	.SPI_SCLK		(SPI_SCLK	),
	.RDData			(RDData		),
	.SPI_SDO		(SPI_SDO	),
	.RD				(RD			),
	.WR				(WR			),
	.RDAddr			(RDAddr		),
	.WrAddr			(WrAddr		),
	.WRData			(WRData		) 
); 

//master spi send data
wire 	[11:0]		wr_data	[14:0];

assign wr_data[0] = PUMP1_DATA_out;	assign wr_data[8]  = PUMP9_DATA_out ;
assign wr_data[1] = PUMP2_DATA_out;	assign wr_data[9]  = PUMP10_DATA_out;
assign wr_data[2] = PUMP3_DATA_out;	assign wr_data[10] = PUMP11_DATA_out;
assign wr_data[3] = PUMP4_DATA_out;	assign wr_data[11] = PUMP12_DATA_out;
assign wr_data[4] = wr_data_temp;	assign wr_data[12] = PUMP13_DATA_out;
assign wr_data[5] = PUMP6_DATA_out;	assign wr_data[13] = PUMP14_DATA_out;
assign wr_data[6] = PUMP7_DATA_out;	assign wr_data[14] = PUMP15_DATA_out;
assign wr_data[7] = PUMP8_DATA_out;
always @(*) begin
	if((LASER_TYPE == 16 || LASER_TYPE == 17 || LASER_TYPE == 18 || LASER_TYPE == 21)&&(WORK_MODE == NORMAL))//激光器类型是全光纤10W/20W，APM1是校准后电流输出，作为激光器整机功率控制
		wr_data_temp <= {cal_dout,2'b00};
	else if((LASER_TYPE == 16 || LASER_TYPE == 17 || LASER_TYPE == 18 || LASER_TYPE == 21)&&(WORK_MODE == DEBUG))//激光器类型是全光纤10W/20W，APM1是校准后电流输出，作为激光器整机功率控制
    	wr_data_temp <= PUMP5_DATA_out;
    else	//激光器类型是固体激光器或者光纤(控声光)，APM1作为泵源正常输出电流
        wr_data_temp <= PUMP5_DATA_out;
end

/********************12bit DAC(数字量转模拟量)*****************/
genvar i;  
    generate  
        for (i=0;i<15;i=i+1) begin: pump_A  
            dac_TPC112S1	pump_dac(
				.clk_i		(clk_i			),
				.rstn_i		(rstn_i			),
    			.AD_START	(AD_START		),
				.din		(wr_data[i]	),
				.cs			(MD_DAC_CS[i]	),
				.sclk		(MD_DAC_SCLK[i]	),
				.dout		(MD_DAC_DOUT[i]	)	//外部模拟量
			);   
        end  
    endgenerate 
 
   
    

//气泵1 速度调节：PWM信号工作频率默认20kHz，调节占空比控制速度
airpump_speed_adj	airpump1_speed_adj(
	.clk_i			(clk_i),	//50M 20ns
	.rstn_i			(rstn_i),
	.freq			(AIRPUMP1_freq),
    .duty			(AIRPUMP1_duty),
    .PWM			(AIRPUMP1_PWM)
);
airpump_speed_adj	airpump2_speed_adj(
	.clk_i			(clk_i),	//50M 20ns
	.rstn_i			(rstn_i),
	.freq			(AIRPUMP2_freq),
    .duty			(AIRPUMP2_duty),
    .PWM			(AIRPUMP2_PWM)
);


endmodule 
