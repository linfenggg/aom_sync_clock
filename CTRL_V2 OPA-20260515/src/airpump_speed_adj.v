module airpump_speed_adj(
	input			clk_i,		//50m 20ns
	input			rstn_i,
	input [15:0]	freq,
	input [15:0]	duty,
	output reg 		PWM		//0-气泵开；1-气泵关
);

reg [15:0]	cnt; 

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		cnt <= 0;
	else if(cnt == freq-1)
		cnt <= 0;
	else 
		cnt <= cnt+1;
end
		
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		PWM <= 1;
    else if(duty == 0)
    	PWM <= 0;
    else if(duty == freq)
    	PWM <= 1;
	else if(cnt == duty-1)
		PWM <= 0;
	else if(cnt ==0)
		PWM <= 1;
end

endmodule 