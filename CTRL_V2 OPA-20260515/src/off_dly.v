module off_dly(
    input			clk_i,	//50M 20ns
	input			rstn_i,	

    input           din,    //低电平认为OFF
    input [7:0]     data_out,   //pump最终输出
    input [15:0]    dly_num,
    output reg      dly_ok
);

reg [15:0]  cnt;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        cnt <= 0;
    else if(data_out!=0)
        cnt <= 0;
    else if(cnt<dly_num)
        cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        dly_ok <= 0;
    else if(data_out!=0)
        dly_ok <= 0;
    else if(cnt==dly_num)
        dly_ok <= 1;


endmodule