
`timescale 1ns/1ns
module tb_cnt_delay();

    reg 			clk_i;
	reg 			rstn_i;
	reg 			dly_in;
	reg [7:0]		dly_num;
	wire    		dly_out;

initial begin 
clk_i=0;
rstn_i=0;
dly_in=0;
dly_num=9;

# 200 rstn_i=1;

end 

always #231 dly_in = ~dly_in;
always #10 clk_i = ~clk_i;

cnt_delay   cnt_delay(
	.clk_i          (clk_i  ),
	.rstn_i         (rstn_i ),
	.dly_in         (dly_in ),
	.dly_num        (dly_num),   
	.dly_out        (dly_out)
);



endmodule