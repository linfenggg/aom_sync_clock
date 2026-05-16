module led(
	input			clk_i,		//50m 20ns
	input			rstn_i,

	input			on,
	input			flash,
	
	output reg 		led_out		//1亮0灭
);

reg [23:0]	cnt; 	//0.4s = 400_000_000 / 20 /2 = 10_000_000

parameter CNT_MAX = 10_000_000-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt <= 0;
	else if(cnt == CNT_MAX)
		cnt <= 0;
	else 
		cnt <= cnt+1;
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		led_out <= 0;
	else if(on==0 && flash==0)
		led_out <= 0;
	else if(on)
		led_out <= 1;
	else if(flash && cnt == CNT_MAX)
		led_out <= ~led_out;
	else if(cnt == CNT_MAX)
		led_out <= 0;
		


endmodule 