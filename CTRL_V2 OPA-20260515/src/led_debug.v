module led_debug(
	input			clk_i,	//50m 20ns
	input			rstn_i,
	output reg 		led_out	//0亮1灭
);

reg [25:0]	cnt_slow; 	//1s = 1_000_000_000 / 20 /2 = 25_000_000

parameter SLOW_MAX = 25_000_000-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt_slow <= 0;
	else if(cnt_slow == SLOW_MAX)
		cnt_slow <= 0;
	else 
		cnt_slow <= cnt_slow+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		led_out <= 1;
	else if(cnt_slow == SLOW_MAX)
		led_out <= ~led_out;
	
endmodule 