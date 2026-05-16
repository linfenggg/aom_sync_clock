module low_ADC_alarm(
	input 		clk_i,
	input		rstn_i,

	input 			EN,
	input			clear,
	input [11:0]	THR,
	input [11:0]	ADC,
	input 			AD_data_en,
	
	output reg 		alarm,
	output reg 		latch

);

wire [11:0]		ADC_fit;

//AVG_32 AVG_32(
AVG_8 AVG_8(
	.clk_i		(clk_i),
	.rstn_i		(rstn_i),
	.den_i		(AD_data_en),
	.din		(ADC),
	.den_o		(	),
	.dout       (ADC_fit)
);

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		alarm <= 0;
	else if(!EN || clear)
		alarm <= 0;
	else if(ADC_fit < THR)
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