`timescale 1ns/1ns

module tb_PCA9555();

	reg 		clk_i		;	//50M 20ns
	reg 		rstn_i	;	
	reg 		AD_START	;
	wire 		SCL;	//max 400k,set 200k
	reg 		SDA;
	wire [7:0]	data0;
	wire [7:0]	data1;

defparam PCA9555.DIV_MAX=40;

initial begin 
clk_i		= 0;
rstn_i	= 0;
AD_START	= 0;
SDA = 0;

#100 rstn_i = 1;
#500 AD_START = 1;

end 

//always @(posedge clk_i)
//	if()

always #10 clk_i = ~clk_i;

PCA9555	PCA9555(
	.clk_i		(clk_i		),	//50M 20ns
	.rstn_i		(rstn_i		),	
	.AD_START	(AD_START	),
	.SCL			(SCL			),	//max 400k,set 200k
	.SDA			(SDA			),
	.data0		(data0		),
	.data1      (data1      )

);







endmodule