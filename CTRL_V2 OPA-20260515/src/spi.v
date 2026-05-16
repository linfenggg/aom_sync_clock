//
//
//
//
//
//
//
//
//
//
module spi(
	//
	input			CLK,
	input			SPI_CS,
	input			SPI_SDI,
	input			SPI_SCLK,
	input [31:0]	RDData,
	//
	output reg		SPI_SDO,
	output			RD,
	output			WR,
	output [14:0]	RDAddr,
	output [14:0]	WrAddr,
	output [31:0]	WRData
);


parameter 	WR_DATA = 0,
			RD_DATA = 1;
reg [47:0]	SPI_SDIDATAReg;
reg [31:0]	SPI_SDODATAReg;
reg			State;
reg [5:0]	ByteCount;
reg			CLKSignal,CLKSamp;
reg			CSSignal,CSSamp;
reg			SELECT;

assign RDAddr = {SPI_SDIDATAReg[13:0],SPI_SDI};
assign RD = (ByteCount==15) && (!SPI_SDIDATAReg[14]); //0=read,1=write
assign WrAddr = SPI_SDIDATAReg[46:32];
assign WR = (State==WR_DATA) && (ByteCount==48) && (!SELECT);
assign WRData = SPI_SDIDATAReg[31:0];

always @(posedge CLK)
begin
	CLKSamp <= SPI_SCLK;
	CLKSignal <= CLKSamp;
end
always @(posedge CLK)
begin 
	CSSamp <= SPI_CS;
	CSSignal <= CSSamp;
	if(CSSamp && !CSSignal) //上升沿
		SELECT <= 0;
	else if(CSSignal && !CSSamp)
		SELECT <= 1;
end
always @(posedge CLK)
begin 
	if(SELECT)
	begin 
		if (State==WR_DATA)
		begin 
			if(CLKSamp && !CLKSignal) //clk上升沿 
			begin
				/*write fpga*/
				SPI_SDIDATAReg[0] <= SPI_SDI;
				SPI_SDIDATAReg[47:1] <= SPI_SDIDATAReg[46:0];
				if(ByteCount==15 && !SPI_SDIDATAReg[14])
				begin 
					State <= RD_DATA;
					SPI_SDODATAReg <= RDData;
				end 
				ByteCount <= ByteCount+1;
			end 
		end 
		else begin 
			if(CLKSignal && !CLKSamp)
			begin 
				SPI_SDO <= SPI_SDODATAReg[31];
				//
				SPI_SDODATAReg[31:0] <= {SPI_SDODATAReg[30:0],1'b0};
			end 
		end 
	end 
	else begin 
		State <= WR_DATA;
		ByteCount <= 0;
		SPI_SDIDATAReg <= 0;
	end 
end 
endmodule