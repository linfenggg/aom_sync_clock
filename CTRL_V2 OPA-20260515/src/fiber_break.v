//
//断纤告警检测
module fiber_break(
	input			clk_i,		//50m 20ns
	input			rstn_i,
	
	input			EN,
	input			clear,
	input			protect_PD1, //断纤,1正常0断纤
	input 			emission,
	input			start_status,
	input [19:0]	fiber_break_delay,	//设为0不检测告警
	
	output reg 		fiber_alarm
);

//fiber break 
reg [17:0]	pwm_cnt;	//3ms, 3_000_000 / 20 = 150_000	
reg [19:0]	dly_cnt;	//5ms, 5_000_000 / 20 = 250_000
reg 		flag;

parameter PWM_CNT_MAX = 150_000-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)	
		flag <= 0;
	else if(!start_status || protect_PD1 || fiber_break_delay==0)
		flag <= 0;
	else if(dly_cnt >= fiber_break_delay)
		flag <= 0;
	else if(emission)
		flag <= 1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)		
		dly_cnt <= 0;
	else if(flag==0 || dly_cnt>=fiber_break_delay)
		dly_cnt <= 0;
	else 
		dly_cnt <= dly_cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		pwm_cnt <= 0;
	else if(flag==0)
		pwm_cnt <= 0;
	else if(emission && pwm_cnt<PWM_CNT_MAX)
		pwm_cnt <= pwm_cnt+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		fiber_alarm <= 0;
	else if(clear || !EN)
		fiber_alarm <= 0;
	else if(pwm_cnt==PWM_CNT_MAX && dly_cnt == fiber_break_delay)
		fiber_alarm <= 1;
//-----------------------------------------------		

endmodule 