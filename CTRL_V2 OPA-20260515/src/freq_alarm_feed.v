module freq_alarm_feed(
	input			clk_i,		//
	input			rstn_i,
	input 			laser,
	input 			alarm_en,	//告警屏蔽
	input			clear,		//清除所有告警

	input [15:0]	THR_L,		//告警低阈值，周期小于10X ns时告警
	input			freq,		//PD信号
	
	output reg			alarm_out,
    
     input [15:0] BST_PERIOD,
     input [15:0] FIBER_AOM_FULL_OPEN_FRQ,
     input  FIBER_AOM_FULL_OPEN_EN

);

reg [15:0]	cnt;
reg 		alarm_tem;

reg [15:0]	THR_L_reg0,THR_L_reg1;
always @(posedge clk_i) 
begin 
	THR_L_reg0 <= THR_L;
	THR_L_reg1 <= THR_L_reg0;
end 


reg 	freq_reg0,freq_reg1,freq_reg2;
always @(posedge clk_i) begin 
	freq_reg2 <= freq_reg1;
	freq_reg1 <= freq_reg0;
	freq_reg0 <= freq;
	end 
    

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) 
		cnt <= 0;
	else if(laser==0)
		cnt <= 0;
    else if(FIBER_AOM_FULL_OPEN_EN==1 && BST_PERIOD<=FIBER_AOM_FULL_OPEN_FRQ && freq_reg1 && freq_reg2 )//声光全开,检测高电平
    	cnt <= 0;
	else if(freq_reg1 && !freq_reg2) //上升沿
		cnt <= 0;
	else 
		cnt <= cnt+1;
	
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) 
		alarm_tem <= 0;
	else if(laser==0)
		alarm_tem <= 0;
	else if(cnt >= THR_L_reg1)
		alarm_tem <= 1; 
	else 
		alarm_tem <= 0;
	
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		alarm_out <= 0;
	else if(!alarm_en || clear)
		alarm_out <= 0;
	else if(alarm_tem)
		alarm_out <= 1;

endmodule 