module led_green(
	input			clk_i,		//50m 20ns
	input			rstn_i,

	input 			emission,
	input 			AP_OK,
	input 			APM_OK,
	input			start_status,

	output reg 		led_out	//1亮0灭
);

reg [24:0]	cnt_slow; 	//1s = 1_000_000_000 / 20 /2 = 25_000_000
reg [23:0]	cnt_ap; 	//0.5s = 500_000_000 / 20 /2 = 12_500_000
reg [23:0]	cnt_fast; 	//0.25s = 250_000_000 / 20 /2 = 6_250_000
reg [3:0]	state;
reg 		flag;
reg [24:0]	flag_cnt; 

parameter SLOW_MAX = 25_000_000-1;
parameter AP_MAX = 12_500_000-1;
parameter FAST_MAX = 6_250_000-1;
parameter FLAG_MAX = 20_000_000-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt_slow <= 0;
	else if(cnt_slow == SLOW_MAX)
		cnt_slow <= 0;
	else 
		cnt_slow <= cnt_slow+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt_ap <= 0;
	else if(cnt_ap == AP_MAX)
		cnt_ap <= 0;
	else 
		cnt_ap <= cnt_ap+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt_fast <= 0;
	else if(cnt_fast == FAST_MAX)
		cnt_fast <= 0;
	else 
		cnt_fast <= cnt_fast+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		flag <= 0;
	else if(emission)
		flag <= 1;
	else if(flag_cnt==FLAG_MAX)
		flag <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)  
		flag_cnt <= 0;
	else if(emission)
		flag_cnt <= 0;
	else if(flag_cnt<FLAG_MAX)
		flag_cnt <= flag_cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		led_out <= 0;
	else if(!start_status || (!emission && !AP_OK && !APM_OK))
		led_out <= 0;
	else if(flag==1)
		led_out <= 1;
	else if(flag==0 && APM_OK && cnt_fast == FAST_MAX)
		led_out <= ~led_out;
	else if(flag==0 && !APM_OK && AP_OK && cnt_ap == AP_MAX)
		led_out <= ~led_out;
	else if(flag==0 && !APM_OK && !AP_OK && cnt_slow == SLOW_MAX)
		led_out <= ~led_out;
	


endmodule 