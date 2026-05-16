module high_alarm(
	input			clk_i,
	input			rstn_i,
	
	input			EN,
	input			clear,
	input [15:0]	DB_TIME,
	input			signal,
	output reg		alarm,
	output reg 		latch

);

reg [15:0]	cnt;
reg 		flag;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt <= 0;
	else if(!EN)
		cnt <= 0;
	else if(!signal)
		cnt <= 0;
	else if(signal && cnt<DB_TIME)
		cnt <= cnt+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		flag <= 0;
	else if(cnt==DB_TIME)
		flag <= 1;
	else
		flag <= 0;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)	
		alarm <= 0;
	else if(!EN || clear)
		alarm <= 0;
	else if(flag)
		alarm <= 1;
	else 
		alarm <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		latch <= 0;
	else if(!EN || clear)
		latch <= 0;
	else if(alarm)
		latch <= 1;



endmodule


