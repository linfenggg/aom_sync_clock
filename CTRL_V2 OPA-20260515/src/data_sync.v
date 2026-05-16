module data_sync(
	input			clk_i,	//50M 20ns
	input			rstn_i,
	input [7:0]		AD7801_data_in,		
	input 			AD7801_LATCH,

	output reg [7:0] dout
);

reg [7:0]	AD7801_data_reg0,AD7801_data_reg1;
reg 	AD7801_LATCH_reg0,AD7801_LATCH_reg1;


always @(posedge clk_i) 
	begin 
		AD7801_data_reg0 <= AD7801_data_in;
		AD7801_data_reg1 <= AD7801_data_reg0;
	end 
	
always @(posedge clk_i) 
	begin
		AD7801_LATCH_reg0 <= AD7801_LATCH;
		AD7801_LATCH_reg1 <= AD7801_LATCH_reg0;
	end 
	
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		dout <= 0;
	else if(AD7801_LATCH_reg1 && !AD7801_LATCH_reg0)
		dout <= AD7801_data_reg1;



endmodule 