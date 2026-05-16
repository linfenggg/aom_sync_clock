/******随机噪声信号，转换为10bit数据******/
module Random_pulse2data(
   input				clk_i	, 
   input				rstn_i	,
   input				din		,
   output	reg [9:0] 	dout
);
reg din_reg0,din_reg1;
always @(posedge clk_i) begin 
	din_reg0 <= din;
	din_reg1 <= din_reg0;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
    	dout <= 10'd0;
    else	
    	dout <= {dout[8:0],din_reg1};
end
	
endmodule