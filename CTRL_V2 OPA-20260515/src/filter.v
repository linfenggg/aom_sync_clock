//IO防抖，数据稍微往后平移
//~~~~~~~|_________|~~~~~~~~
//~~~~~~~~~~~~|_________|~~~
module filter(
	input			clk_i,
	input			rstn_i,
	input			signal,
	output reg 		dout
);

reg  	tem;

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		tem <= 0;
		dout <= 0;
		end 
	else begin 
		tem <= signal;
		dout <= tem;
	end 
end

//reg [7:0]	cnt;
//
//parameter CNT_MAX = 20;
//
//always @(posedge clk_i or negedge rstn_i)
//	if(!rstn_i)
//		cnt <= CNT_MAX/2;
//	else if(signal && cnt<CNT_MAX)
//		cnt <= cnt+1;
//	else if(!signal && cnt>0)
//		cnt <= cnt-1;
//
//always @(posedge clk_i or negedge rstn_i)
//	if(!rstn_i)
//		dout <= signal;
//	else if(cnt==CNT_MAX)
//		dout <= 1;
//	else if(cnt==0)
//		dout <= 0;


endmodule