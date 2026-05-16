module MS5510_ADC(
	input			clk_i,
	input			rstn_i,
	
	input [7:0]	din,
	output 		OE,
	output reg			AD_CLK,
	output reg [7:0]	dout

);

reg [3:0]	cnt;	//50m / 4 = 12.5m;

parameter CNT_MAX = 1;

assign OE = 1'B0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		cnt <= 0;
	else if(cnt==CNT_MAX)
		cnt <= 0;
	else 
		cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		AD_CLK <= 0;
	else if(cnt==CNT_MAX)
		AD_CLK <= ~AD_CLK;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		dout <= 0;
	else 
		dout <= din;



endmodule