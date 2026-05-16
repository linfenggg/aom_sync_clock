module spi_rec(
    input 			clk_i,	//50M 20ns
	input 			rstn_i,

    output reg [15:0]    FPGA2_VER	,	
    output reg [15:0]    SEQ_ALM	,

    //spi
	input 			SLAVE_SPI_CS	,
	input 			SLAVE_SPI_SCLK	,
	input 			SLAVE_SPI_SDI

);

(*keep*) wire [7:0]	    rd_addr ;
(*keep*) wire [15:0]	rd_data ;
(*keep*) wire 			rd_en   ;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
        SEQ_ALM <= 16'hffff;
    end 
    else if(rd_en) 
    case(rd_addr)
    0   :   FPGA2_VER	<= rd_data;
    1   :   SEQ_ALM 	<= rd_data;
    
    default : ;
    endcase


spi_slave   spi_slave(
	.clk_i          (clk_i   ),	//50M 20ns
	.rstn_i         (rstn_i  ),
	.rd_addr        (rd_addr ),
	.rd_data        (rd_data ),
	.rd_en          (rd_en   ),
	.SPI_CS	        (SLAVE_SPI_CS   ),
	.SPI_SCLK	    (SLAVE_SPI_SCLK ),
	.SPI_SDI        (SLAVE_SPI_SDI  )
);

endmodule

