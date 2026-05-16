/*-----------------------------------------------
程序说明：
此模块为水流检测模块
-------------------------------------------------*/
module 	FRENC_WATER(
	input				clk_i,
	input				rstn_i,		//低电平复位
	input				pd_signal,	//TTL输入接口
	output reg [31:0] 	pd_freq 	//输出是周期个数，测频周期 = (X+1)*系统时钟周期
);

reg [31:0]	cnt;
reg [31:0]	delay_2s;	//2_000_000_000 / 20 = 100_000_000
reg 		pd_signal_reg0, pd_signal_reg1;

always @(posedge clk_i) begin 
	pd_signal_reg0 <= pd_signal;
	pd_signal_reg1 <= pd_signal_reg0;
end 

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		delay_2s <= 0;
	else if(!pd_signal_reg0 && pd_signal_reg1)	//下降沿
		delay_2s <= 0;
	else if(delay_2s < 100_000_000-1)
		delay_2s <= delay_2s+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		cnt <= 0;
	else if(!pd_signal_reg0 && pd_signal_reg1)	//下降沿
		cnt <= 0;
	else 
		cnt <= cnt+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		pd_freq <= 0;
	else if(delay_2s == 100_000_000-1)
		pd_freq <= 0;
	else if(!pd_signal_reg0 && pd_signal_reg1)	//下降沿
		pd_freq <= cnt;
end

endmodule