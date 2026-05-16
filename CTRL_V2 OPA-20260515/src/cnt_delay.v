module cnt_delay(
	input 			clk_i,
	input 			rstn_i,
	
	input 			dly_in,
	input [7:0]		dly_num,
	
	output reg		dly_out
);

reg [7:0]	cnt;
reg 		flag;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		flag <= 0;
	else if(dly_in)
		flag <= 1;
	else if(cnt == dly_num)
		flag <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
		cnt <= 0;
		dly_out <= 0;
	end 
	else if(cnt == dly_num && flag) begin 
		cnt <= 0;
		dly_out <= 1;
	end 
	else if(flag) begin 
		cnt <= cnt+1;
		dly_out <= 0;
	end 
	else begin 
		cnt <= 0;
		dly_out <= 0;
	end 





endmodule 