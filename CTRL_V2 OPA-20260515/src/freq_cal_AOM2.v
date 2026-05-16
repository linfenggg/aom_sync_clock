

module freq_cal_AOM2(
	input			clk_i,	//100M, 10ns
	input 			rstn_i,
	
	input 			TTL,	//来自burst模块，一个高电平期间只测一次脉冲
	input			fx,		//待测信号100k - 30M

	output reg [15:0]	freq	//单位:kHz

);

parameter SLACK = 3200;	//被测频率不能低于参考频率 除以 该参数
parameter DELY_MAX = 100_000-1; 

reg [17:0]	delay_1ms;	//1_000_000 / 10 = 100_000
reg 		enable;
reg [15:0]	fx_cnt;		//跨时钟域
reg [3:0]	state;
reg 		TTL_reg0,TTL_reg1;
reg [15:0]	freq_reg0,freq_reg1;
reg 		fx_reg0,fx_reg1,fx_reg2;

always @(posedge clk_i) begin 
	TTL_reg0 <= TTL;
	TTL_reg1 <= TTL_reg0;
	end 

always @(posedge clk_i) begin 
		fx_reg0 <= fx;
		fx_reg1 <= fx_reg0;
		fx_reg2 <= fx_reg1;
	end 

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
		fx_cnt <= 0;
		state <= 0;
		end 
	else if(enable==0) begin 
		fx_cnt <= 0;
		state <= 0;
		end 
	else case(state)
	0	:	if(TTL_reg0 && !TTL_reg1) //上升沿 
				state <= 1;
	1	:	if(fx_reg1 && !fx_reg2)	begin //上升沿 
				fx_cnt <= fx_cnt+1;
				state <= 0;
				end 
//	2	:	if(TTL==0) 
//				state <= 0;
				
	default : state <= 0;
	endcase

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		delay_1ms <= 0;
	else if(delay_1ms == DELY_MAX+SLACK)
		delay_1ms <= 0;
	else 
		delay_1ms <= delay_1ms+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		enable <= 0;
	else if(delay_1ms==SLACK)
		enable <= 1;
	else if(delay_1ms==DELY_MAX+SLACK)
		enable <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		freq <= 0;
	else if(delay_1ms==DELY_MAX+SLACK)
		freq <= fx_cnt;	//只要 delay_1ms 的时间不改变，这里不用变

endmodule 
