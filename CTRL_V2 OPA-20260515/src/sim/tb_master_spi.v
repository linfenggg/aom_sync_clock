`timescale 1ns/1ns
module tb_master_spi();

	reg 			clk_i		;	//50M 20ns
	reg 			rstn_i	;
	reg 			enable	;
	reg [15:0]	wr_data	;
	reg [7:0]	wr_addr	;	
	wire			wr_compl	;
	wire			SPI_CS	;
	wire			SPI_SCLK	;
	wire			SPI_SDI 	;
	
	


initial begin 
	clk_i		 = 0;
	rstn_i	 = 0;
	enable	 = 0;
	wr_data	 = 23205;
	wr_addr	 = 14;
	
	#500 rstn_i = 1;
	#800 enable = 1;  
   
end 

always #10 clk_i = ~clk_i;

spi_master	spi_master(
	.clk_i			(clk_i		),	//50M 20ns
	.rstn_i			(rstn_i		),
	.enable			(enable		),
	.wr_data			(wr_data		),
	.wr_addr			(wr_addr		),	
	.wr_compl		(wr_compl	),
	.SPI_CS			(SPI_CS		),
	.SPI_SCLK		(SPI_SCLK	),
	.SPI_SDI 		(SPI_SDI 	)
);




endmodule 