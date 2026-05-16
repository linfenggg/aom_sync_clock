module AD9748_bst(
	input		clk_i,	//种子倍频时钟
	input		rstn_i,
	input 		TTL_OUT,

	input [7:0]		data_in,	//目标值
	
	output [7:0]	data_out,
	output 			clock		

);

assign clock = clk_i;
assign data_out = (TTL_OUT)? data_in : 0;

//always @(posedge clk_i or negedge rstn_i)
//	if(!rstn_i)
//		data_out <= 0;
//	else if(TTL_OUT)
//		data_out <= data_in;
//	else 
//		data_out <= 0;

	
	

endmodule