module MOTOR(
	input 			clk_i,	//50M 20ns
	input 			rstn_i,
	input 			AD_START,
//	output reg [7:0]	state,
	
	input 				reset,	//1有效，拉高一个脉冲
	input [31:0]		period,	//脉冲周期
	input [17:0]		step_num,//目标值，移动步数
	
	output reg [17:0]	step_sta,//当前状态
	output reg 			overflow,
	output reg 			BREAK_OUT,

	input 	 			cw,		//正端
	input 	 			ccw,		//反端
	output reg 			pulse,	//周期大于1us，f<1MHz
	output reg 			direct	//1-正转，0-反转
	
);

//不使用指令过滤器时，可以无延时操作马达
//使用指令过滤器时，开和关都是延时5.5ms

reg [7:0]	state;
reg [31:0]	peri_cnt;
reg [17:0]	step_num_reg;


always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		step_num_reg <= 0;
	else 
		step_num_reg <= step_num;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		BREAK_OUT <= 0;
	else if(reset)
		BREAK_OUT <= 0;
	else if(cw && ccw) //两个高电平表示电机未接上
		BREAK_OUT <= 1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin
		state <= 0;
		peri_cnt <= 0;
		pulse <= 0;
		direct <= 0;
		step_sta <= 0;
		overflow <= 0;
	end 
	else if(reset) begin
		state <= 0;
		peri_cnt <= 0;
		pulse <= 0;
		direct <= 0;
		step_sta <= 0;
		overflow <= 0;
	end 
	else case(state)
	0:	if(AD_START) begin 
			state <= 1;
		end
	1:	begin 
		peri_cnt <= 0;
		pulse <= 0;
		direct <= 0;
		step_sta <= 0;
		if(cw)	//最正端
			state <= 10;
		else 
			state <= 2;
		end 
	2:	begin 
			pulse <= 1;
			state <= 3;
		end 
	3:	if(peri_cnt < period)
			peri_cnt <= peri_cnt+1;
		else begin 
			peri_cnt <= 0;
			pulse <= 0;
			state <= 4;
		end
	4:	if(peri_cnt < period)
			peri_cnt <= peri_cnt+1;
		else begin 
			peri_cnt <= 0;
			state <= 5;
		end
	5:	if(cw) begin 	//初始化到最正端
			overflow <= 0;
			state <= 10;
		end 
		else 
			state <= 2;
	10:	begin 
		if(ccw==0 && cw==0)
			overflow <= 0;
		if(step_sta < step_num)
				state <= 11;	//反方向
		else if(step_sta > step_num)
				state <= 21;	//正方向
		end 
	11:	begin 
				direct <= 1;
				state <= 12;
			end 
	12:	begin 
				pulse <= 1;
				state <= 13;
			end 
	13:	if(peri_cnt < period)
				peri_cnt <= peri_cnt+1;
			else begin 
				peri_cnt <= 0;
				pulse <= 0;
				state <= 14;
			end
	14:	if(peri_cnt < period)
				peri_cnt <= peri_cnt+1;
			else begin 
				peri_cnt <= 0;
				state <= 15;
			end
	15:	if(ccw)	begin //到达最反端
				overflow <= 1;
				state <= 30;
			end 
			else begin 
				step_sta <= step_sta+1;
				state <= 10;
			end 
	//
	21:	begin 
				direct <= 0;
				state <= 22;
			end 
	22:	begin 
				pulse <= 1;
				state <= 23;
			end 
	23:	if(peri_cnt < period)
				peri_cnt <= peri_cnt+1;
			else begin 
				peri_cnt <= 0;
				pulse <= 0;
				state <= 24;
			end
	24:	if(peri_cnt < period)
				peri_cnt <= peri_cnt+1;
			else begin 
				peri_cnt <= 0;
				state <= 25;
			end
	25:	if(cw)	begin //到达最正端
				overflow <= 1;
				state <= 30;
			end 
			else begin 
				step_sta <= step_sta-1;
				state <= 10;
			end 
	//
	30:	if(step_num_reg != step_num) begin 
				state <= 10;
			end 
	default : state <= 0;
endcase

 
endmodule