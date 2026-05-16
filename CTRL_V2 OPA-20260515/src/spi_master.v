module spi_master(
	input 			clk_i,	//50M 20ns
	input 			rstn_i,
	input 			enable,
	//
	input [15:0]	wr_data,
	input [7:0]		wr_addr,	
	output reg 		wr_compl,	//只拉高一个周期
	//spi
	output reg		SPI_CS	,
	output reg		SPI_SCLK,
	output 	 		SPI_SDI
);

reg [3:0]	state;
reg [3:0]	div_cnt;
reg [23:0]	data_tem;
reg [7:0]	bit_cnt;
reg [3:0]	delay;

parameter DIV_POS = 4;
parameter DIV_NEG = 9;

assign SPI_SDI = data_tem[23];

always @(posedge clk_i or negedge rstn_i) 
	if(!rstn_i)
		div_cnt <= 0;
	else if(SPI_CS)
		div_cnt <= 0;
	else if(div_cnt==DIV_NEG)
		div_cnt <= 0;
	else 
		div_cnt <= div_cnt+1;
		
always @(posedge clk_i or negedge rstn_i) 
	if(!rstn_i)
		SPI_SCLK <= 0;
	else if(SPI_CS)
		SPI_SCLK <= 0;
	else if(div_cnt==DIV_POS)
		SPI_SCLK <= 1;
	else if(div_cnt==DIV_NEG)
		SPI_SCLK <= 0;

always @(posedge clk_i or negedge rstn_i) 
	if(!rstn_i)
	begin 
		state 	<= 0;
		data_tem <= 0;
		wr_compl <= 0;
		bit_cnt 	<= 0;
		delay		<= 0;
		SPI_CS	<= 1;
	end 
	else case(state)
	0	:	if(enable)
				state <= 1;
	1	:	begin 
				SPI_CS <= 0;
				bit_cnt <= 0;
				data_tem <= {wr_addr,wr_data};
				state <= 2;
			end 
	2	:	if(bit_cnt < 23 && div_cnt==DIV_NEG) begin
				data_tem <= data_tem<<1;
				bit_cnt <= bit_cnt+1;
			end 
			else if(div_cnt==DIV_NEG)
				state <= 3;
	3	:	if(div_cnt==DIV_POS-1)
			begin 
				SPI_CS <= 1;
				bit_cnt <= 0;
				wr_compl <= 1;	
				state <= 4;
			end 
	4	:	begin 	
				wr_compl <= 0;
				if(delay < 9)
					delay <= delay+1;
				else begin
					delay <= 0;
					state <= 0;
				end 
			end 
	default : state <= 0;
endcase

/*
//仿真测试用
spi_slave	spi_slave(
	.clk_i		(clk_i	),	//50M 20ns
	.rstn_i		(rstn_i	),
	.rd_addr		(),
	.rd_data		(),
	.rd_en		(),
	//spi
	.SPI_CS		(SPI_CS	),
	.SPI_SCLK	(SPI_SCLK),
	.SPI_SDI    (SPI_SDI )

);
*/


endmodule 