module on_dly(
    input			clk_i,	//50M 20ns
	input			rstn_i,	

    input [7:0]     data_set,
    input [7:0]     data_out,
    input           din,    //高电平认为开启
    input [15:0]    dly_num,
    output reg      dly_ok
);

reg [15:0]  cnt;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        cnt <= 0;
    else if(din==0 || data_out<10)
        cnt <= 0;
    else if(data_out==data_set && cnt<dly_num)
        cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        dly_ok <= 0;
    else if(din==0 || data_out<10)
        dly_ok <= 0;
    else if(cnt==dly_num)
        dly_ok <= 1;


endmodule