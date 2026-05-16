`timescale 1ns/1ns

module tb_motor();

	reg 			clk_i;	//50M 20ns
	reg 			rstn_i;
	reg 			AD_START;
	reg 			reset;	//1有效，拉高一个脉冲
	reg [15:0]	period;	//脉冲周期
	reg [17:0]	step_num;//移动步数
	wire [17:0]	step_sta;//当前状态
	wire 			overflow;

	reg 	 		cw	;		//正端
	reg 	 		ccw;		//反端
	wire	 		pulse;	//周期大于1us，f<1MHz
	wire	 		direct;	//1-正转，0-反转

initial begin 
	clk_i=0;	
	rstn_i=0;  
	AD_START=0;
	{cw,ccw} = 2'b00;
	reset=0;	
	period=9;	
	step_num=30;
	#100 rstn_i = 1;
	#300 AD_START=1;
	
	#12000 {cw,ccw} = 2'b10;
	#12000 {cw,ccw} = 2'b01;
	#12000 reset = 1; #100 reset=0;
end 

always #10 clk_i = ~clk_i;

motor	motor(
	.clk_i			(clk_i		),	//50M 20ns
	.rstn_i			(rstn_i		),
	.AD_START		(AD_START	),
	.reset			(reset		),	//1有效，拉高一个脉冲
	.period			(period		),	//脉冲周期
	.step_num		(step_num	),//移动步数
	.step_sta		(step_sta	),//当前状态
	.overflow		(overflow	),
	.cw				(cw			),		//正端
	.ccw				(ccw			),		//反端
	.pulse			(pulse		),	//周期大于1us，f<1MHz
	.direct			(direct		)	//1-正转，0-反转
	
);







endmodule

