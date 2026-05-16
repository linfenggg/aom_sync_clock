module spi_slave(
	input 			clk_i,	//50M 20ns
	input 			rstn_i,
	
	output reg [7:0]	rd_addr,
	output reg [15:0]	rd_data,
	output reg 			rd_en,
	//spi
	input 			SPI_CS	,
	input 			SPI_SCLK	,
	input 			SPI_SDI

);

(*keep*) reg 			sclk_reg0,sclk_reg1;
(*keep*) reg 			sdi_reg0,sdi_reg1;
(*keep*) reg 			cs_reg0,cs_reg1;
(*keep*) reg [23:0]		data_tem;
(*keep*) reg 			flag;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
		sclk_reg0 <= 0 ;
		sclk_reg1 <= 0 ;
		sdi_reg0 <= 0 ;
		sdi_reg1 <= 0 ;
		cs_reg0 <= 0 ;
		cs_reg1 <= 0 ;
	end
	else 
	begin 
		sclk_reg0 <= SPI_SCLK;
		sclk_reg1 <= sclk_reg0;
		sdi_reg0 <= SPI_SDI;
		sdi_reg1 <= sdi_reg0;
		cs_reg0 <= SPI_CS;
		cs_reg1 <= cs_reg0;
	end 
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		data_tem <= 0;
	else if(sclk_reg0 && !sclk_reg1)	//上升沿
		data_tem <= {data_tem[22:0],sdi_reg1};

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		rd_addr <= 0;
	else if(cs_reg0 && !cs_reg1) //上升沿
		rd_addr <= data_tem[23:16];

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		rd_data <= 0;
	else if(cs_reg0 && !cs_reg1) //上升沿
		rd_data <= data_tem[15:0];
		
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		flag	<= 0;
	else if(cs_reg0 && !cs_reg1) //上升沿
		flag	<= 1;
	else 
		flag	<= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		rd_en	<= 0;
	else 
		rd_en <= flag;
	
endmodule