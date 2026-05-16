`timescale 1ns/1ns
module tb_burst();

	reg 			clk_i;
	reg				rstn_i;	
	reg 			EXT_TRIG;
	reg [7:0]		TRIG_PRE;
	reg [7:0]		PROT_FREQ;
	reg 			FREQ_PD1;
	reg [3:0]		BST_NUM;
	reg [15:0]		BST_PERIOD;
	reg [7:0]		BST_DLY;
	reg [23:0]		FREQ_DIV_NUM;
	reg [3:0]		AOM_CTRL_SEL;
	reg 			line;
	reg [3:0]		AOM2_HEAD_DLY;
	reg [3:0]		AOM2_TAIL_DLY;
	reg 			SEED_SYNC_AOM1;
	reg 			BST_SEL		;
	reg [3:0]		BST_PUL_NUM	;
	reg [7:0]		BURST_DATA1	 = 100;
	reg [7:0]		BURST_DATA2	 = 101;
	reg [7:0]		BURST_DATA3	 = 102;
	reg [7:0]		BURST_DATA4	 = 103;
	reg [7:0]		BURST_DATA5	 = 104;
	reg [7:0]		BURST_DATA6	 = 105;
	reg [7:0]		BURST_DATA7	 = 106;
	reg [7:0]		BURST_DATA8	 = 107;
	reg [7:0]		BURST_DATA9	 = 108;
	reg [7:0]		BURST_DATA10 = 109;
	wire 			TTL_DIV;		//用于二级声光分频
	wire 		 	TTL_tem;		//用于PD2测频判断
	wire 			AOM2_EXP;		//用于AOM2提前开启和关闭判断
	wire [7:0]		FIBER_AOM_DATA;
	wire 			FIBER_AOM_CLK	;
	wire 			FIBER_AOM_TTL;	//一级声光TTL,实际正在出光

defparam burst.DLY_MAX = 199;

initial begin 
	clk_i		= 0;
	rstn_i	    = 0;
	BST_PERIOD  = 16;//94; //burst最多支持该参数-3
	FREQ_PD1    = 0;
	BST_NUM	    = 3;
	EXT_TRIG	=0;
	TRIG_PRE	=50;
	PROT_FREQ   = 2;

	AOM2_HEAD_DLY	= 1;
	AOM2_TAIL_DLY	= 0;
	line = 1;
	BST_DLY = 1;
	FREQ_DIV_NUM = 2;
	AOM_CTRL_SEL = 2;	//
	SEED_SYNC_AOM1 = 0;
	#500 rstn_i	    = 1;
	#2000 SEED_SYNC_AOM1 = 1;
	#100000 AOM_CTRL_SEL = 3;
end 

always #5 clk_i = ~clk_i;
always #25 FREQ_PD1 = ~FREQ_PD1;

reg [7:0]	cnt;
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt <= 0;
	else if(cnt == 238)
		cnt <= 0;
	else 
		cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		EXT_TRIG <= 0;
	else if(cnt==1)
		EXT_TRIG <= 1; 
	else if(cnt == 3)
		EXT_TRIG <= 0; 


burst	burst(
	.clk_i				(clk_i			),
	.rstn_i				(rstn_i			),	
	.EXT_TRIG			(EXT_TRIG		),
	.TRIG_PRE			(TRIG_PRE		),
	.PROT_FREQ			(PROT_FREQ		),
	.BST_NUM			(BST_NUM		),
	.BST_PERIOD			(BST_PERIOD		),
	.BST_DLY			(BST_DLY		),
	.FREQ_DIV_NUM		(FREQ_DIV_NUM	),
	.AOM_CTRL_SEL			(AOM_CTRL_SEL		),
	//.AOM2_HEAD_DLY		(AOM2_HEAD_DLY	),
	//.AOM2_TAIL_DLY		(AOM2_TAIL_DLY	),
	.SEED_SYNC_AOM1		(SEED_SYNC_AOM1	),
	.BST_SEL			(BST_SEL		),
	.BST_PUL_NUM		(BST_PUL_NUM	),
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
	.TTL_DIV			(TTL_DIV		),		//用于二级声光分频
	.TTL_tem			(TTL_tem		),		//用于PD2测频判断
	.AOM2_EXP			(AOM2_EXP		),		//用于AOM2提前开启和关闭判断
	.FIBER_AOM_DATA		(FIBER_AOM_DATA	),
	.FIBER_AOM_CLK		(FIBER_AOM_CLK	),
	.FIBER_AOM_TTL		(FIBER_AOM_TTL	)	//一级声光TTL,实际正在出光
);


endmodule 