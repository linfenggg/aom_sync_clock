module AD7801(
	input		clk_i,	//50M 20ns
	input		rstn_i,
	input 		AD_START,

	input [7:0]	data_in,	//数据需要降频，不能太快
	
	output reg [7:0]	data_out,
	output wire		CS,
	output reg 		WR,
	output wire 	LDAC,
	output wire 	CLR

);

reg [3:0]	delay;
reg [3:0]	state;

assign CS = WR;
assign LDAC = 1'B0;
assign CLR = 1'B1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
		state <= 0;
		delay <= 0;
		data_out <= 0;
		WR <= 1;
		end 
	else case(state)
		0	:	begin 
					delay <= 0;
					WR <= 1;
					if(AD_START)
						state <= 1;
				end 	
		1	:	begin 
					WR <= 0;
					state <= 2;
					end 
		2	:	begin 
					data_out <= data_in;
					state <= 3;
				end 
				
		3	:	begin 
					state <= 4;		//延时一个周期
				end 
		4	:	begin 
					state <= 5;		//延时一个周期
				end 
		5	:	begin 
					WR <= 1;
					state <= 6;
				end 
		6	:	if(delay <7)
					delay <= delay+1;
				else 
					state <= 0;
				
		default : state <= 0;
	endcase 




endmodule 