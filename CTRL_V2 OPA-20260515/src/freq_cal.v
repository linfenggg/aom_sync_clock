module freq_cal(
	input			clk_i,	//100M, 10ns
	input 			rstn_i,

	input			fx,	//待测信号1M - 100M

	output reg [16:0]	freq	//单位:kHz

);

parameter SLACK = 220;	//被测频率不能低于参考频率 除以 该参数
parameter DELY_MAX = 100_000-1; 

reg [17:0]	delay_1ms;	//1_000_000 / 10 = 100_000
reg 		enable;
reg [16:0]	fx_cnt;		//跨时钟域

(*keep*)reg 		fx_reg0,fx_reg1,fx_reg2;

always @(posedge clk_i) begin 
		fx_reg0 <= fx;
		fx_reg1 <= fx_reg0;
		fx_reg2 <= fx_reg1;
	end 

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		fx_cnt <= 0;
	else if(enable==0)
		fx_cnt <= 0;
	else if(fx_reg1 && !fx_reg2)	//上升沿
		fx_cnt <= fx_cnt+1;

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
		freq <= fx_cnt;	


endmodule 