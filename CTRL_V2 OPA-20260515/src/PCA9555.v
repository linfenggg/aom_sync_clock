module PCA9555(
	input			clk_i,	//50M 20ns
	input			rstn_i,	
	input 			AD_START,
	input  [6:0]	SLAVE_ADDR,
    output reg 		SCL,	//max 400k,set 200k
	inout 			SDA,
	output [15:0]	dout,
    output reg		flag
);
reg 		sda_tem;
reg [7:0]	data_tem;
reg [3:0]	bit_cnt;
reg 		en;
reg [8:0]	div_cnt;	//50_000 / 200 = 250
reg [4:0]	state;
reg [7:0]	data0;
reg [7:0]	data1;
parameter DIV_MAX = 500;	
parameter DIV_QUA = DIV_MAX/4;		
parameter DIV_3_QUA = DIV_QUA*3;
parameter WR = 1'B0;
parameter RD = 1'B1;
parameter ACK = 1'B0;
parameter NOACK = 1'B1;
//parameter SLAVE_ADDR = 7'B0100_000;
parameter CMD_BYTE = 8'D0;	//从data0开始读

assign SDA = (en)? sda_tem:1'bz;
assign dout = {data1,data0};
always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		div_cnt <= 0;
	else if(div_cnt==DIV_MAX || state==0)
		div_cnt <= 0;
	else if(state>=1)
		div_cnt <= div_cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		SCL <= 1;
	else if(state==0)
		SCL <= 1;
	else if(div_cnt==DIV_MAX)
		SCL <= 0;
	else if(div_cnt==DIV_MAX/2)
		SCL <= 1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin
		sda_tem <= 1;
		data0 <= 0;
		data1 <= 0;
		bit_cnt <= 0;
		data_tem <= 0;
		state <= 0;
		en <= 1;
        flag <= 0;
	end 
	else case(state)
	0:	begin
		sda_tem <= 1;
		data_tem <= 0;
		en <= 1;
		if(AD_START)	state <= 1;	
        flag <= 0;  //重置标志位
	end 
	1:	if(div_cnt==DIV_MAX/2)
		begin 
			sda_tem <= 0;	//start
			state <= 2;
		end 
	2:	if(div_cnt==DIV_QUA) begin 
		data_tem <= {SLAVE_ADDR,WR};
		state <= 3;
		end 
	3:	begin 
		sda_tem <= data_tem[7];
		if(div_cnt==DIV_QUA) 
			bit_cnt <= bit_cnt+1;
		if(bit_cnt==7 && div_cnt==DIV_QUA) 
			state <= 4;
		if(div_cnt==DIV_QUA)
			data_tem <= data_tem<<1;
		end 
	4:	begin 	//接收 ACK
		en <= 0;
		bit_cnt <= 0;
		if(div_cnt==DIV_3_QUA && SDA==ACK) 
			state <= 5;
		else if(div_cnt==DIV_3_QUA && SDA==NOACK) 
			state <= 18;	//stop
		end 
	5:	if(div_cnt==DIV_QUA) begin 
			data_tem <= CMD_BYTE;
			en <= 1;
			state <= 6;
		end
	6:	begin 
		sda_tem <= data_tem[7];
		if(div_cnt==DIV_QUA) 
			bit_cnt <= bit_cnt+1;
		if(bit_cnt==7 && div_cnt==DIV_QUA) 
			state <= 7;
		if(div_cnt==DIV_QUA)
			data_tem <= data_tem<<1;
		end 
	7:	begin 	//接收 ACK
		en <= 0;
		bit_cnt <= 0;
		if(div_cnt==DIV_3_QUA && SDA==ACK) 
			state <= 8;
		else if(div_cnt==DIV_3_QUA && SDA==NOACK) 
			state <= 18;	//stop
		end 
	8:	if(div_cnt==DIV_QUA) begin 
			sda_tem <= 1;
			en <= 1;
			state <= 9;
		end
	9:	if(div_cnt==DIV_3_QUA) begin 
			sda_tem <= 0;	//repeat start
			state <= 10;
		end 
	10:	if(div_cnt==DIV_QUA) begin 
			data_tem <= {SLAVE_ADDR,RD};
			en <= 1;
			state <= 11;
		end
	11:begin 
		sda_tem <= data_tem[7];
		if(div_cnt==DIV_QUA) 
			bit_cnt <= bit_cnt+1;
		if(bit_cnt==7 && div_cnt==DIV_QUA) 
			state <= 12;
		if(div_cnt==DIV_QUA)
			data_tem <= data_tem<<1;
		end 
	12:begin 	//接收 ACK
		en <= 0;
		bit_cnt <= 0;
		if(div_cnt==DIV_3_QUA && SDA==ACK) 
			state <= 13;
		else if(div_cnt==DIV_3_QUA && SDA==NOACK) 
			state <= 18;	//stop
		end 
	13:if(div_cnt==DIV_QUA) begin 
			state <= 14;
		end
	14:begin 
		en <= 0;
		if(div_cnt==DIV_QUA && bit_cnt==7) 
			state <= 15;
		else if(div_cnt==DIV_QUA) 
			bit_cnt <= bit_cnt+1;
		if(div_cnt==DIV_3_QUA) 
			data_tem <= {data_tem[6:0],SDA};
		end 
	15:begin 	//发送 ACK
		sda_tem <= ACK;
		data0 <= data_tem;
		en <= 1;
		bit_cnt <= 0;
		if(div_cnt==DIV_QUA) state <= 16;
		end 
	16:begin 
		en <= 0;
		if(div_cnt==DIV_QUA && bit_cnt==7) 
			state <= 17;
		else if(div_cnt==DIV_QUA) 
			bit_cnt <= bit_cnt+1;
		if(div_cnt==DIV_3_QUA) 
			data_tem <= {data_tem[6:0],SDA};
		end 
	17:begin 	//发送 NOACK
		sda_tem <= NOACK;
		data1 <= data_tem;
		en <= 1;
		bit_cnt <= 0;
		if(div_cnt==DIV_QUA) state <= 18;
		end 
	18:begin	//stop
			sda_tem <= 0;
			state <= 19;
		end 
	19:if(div_cnt==DIV_3_QUA) begin 
			state <= 20;
			sda_tem <= 1;
		end 
	20:if(div_cnt==0) begin
			//state <= 9;//重复读取
            state <= 0;//0;  //重新取地址读取
            flag <= 1;
		end
	default : state <= 0;
endcase

endmodule