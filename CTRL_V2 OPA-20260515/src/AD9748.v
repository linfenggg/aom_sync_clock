module AD9748(
	input		clk_i,	//50M 20ns
	input		rstn_i,
	input 		AD_START,

	input [7:0]	data_in,	//目标值
	
	output reg [7:0]	data_out,
	output 				clock	//50M,LVDS差分时钟

);

assign clock = clk_i;

//用下降沿打一拍让数据采集在中间位置
always @(negedge clk_i or negedge rstn_i)
	if(!rstn_i)
		data_out <= 0;
	else if(AD_START)
		data_out <= data_in;


endmodule