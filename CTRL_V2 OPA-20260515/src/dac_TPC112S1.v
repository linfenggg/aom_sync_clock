/*-----------奥创光子Ultron 注释开始------------
文件名：dac_TPC112S1.v
功能描述：TPC112S1 DAC采样芯片驱动
设计者：Roc
设计时间：2024.5.29
版权所属：杭州奥创光子技术有限公司
修改信息：首版--2024.6.3
-------------奥创光子Ultron 注释结束------------*/
module dac_TPC112S1(
	input				clk_i,		//系统时钟，50MHz
	input				rstn_i,		//复位信号
	input				AD_START,	//采样开始信号
    input 		[11:0]	din,		//数据信号，12bit
	output reg			cs,			//SPI,片选信号
	output reg			sclk,		//SPI,时钟信号，最大30MHz，本项目采用25MHz
	output  			dout		//SPI,串行数据输出

);

reg [3:0]	cnt;
reg [3:0]	state;
reg data_temp;
parameter	MSB = 0;
parameter	CONTROL_BITS = 0;	//00-normal;01-output 1kΩ pull down;10-output 100kΩ pull down;11-output high-z;
parameter 	CNT_MAX = 11;
assign dout = data_temp;
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		state <= 0;		//状态机
		cs <= 1;
        sclk <= 1;
        cnt <= 0; 
        data_temp <= 1'b0;
	end 
	else if(AD_START) begin
    	case(state)
		0:	begin 				
				sclk <= 1;
            	state <= 1;
			end 
		1:	begin 				
				cs <= 0;
            	state <= 2;
			end 
        2:	begin 				
                sclk <= 1;
                data_temp <= 0;	//发送MSB和CONTROL_BITS
            	state <= 3;
			end 
        3: 	begin
                cnt <= cnt+1;
                if(cnt == 4) begin
                	cnt <= 11;
                	state <= 4;
                end
                else begin
                    sclk <= 0;
                    state <= 2;
                end
        	end	
        4:	begin
        		sclk <= 1;
                data_temp <= din[cnt];	//发送数据
            	state <= 5;
        	end
        5:	begin
                sclk <= 0;       		
                if(cnt == 0) begin
                	cnt <= 0;
                	state <= 6;
                end
                else begin
                	cnt <= cnt-1;
                	state <= 4;
                end
        	end
        6:	begin
        		cs <= 1;
                sclk <= 1;
                if(cnt == 4) begin
               		cnt <= 0;
                	state <= 0;
               	end
                else 
                	cnt <= cnt+1;
        	end
         default : begin
         			cs <= 1;
                    sclk <= 1;
                    state <= 0;
                   end
		endcase
    end
 	else begin 	
		cs <= 1;
        sclk <= 1;
        cnt <= 0; 
        data_temp <= 1'b0;
	end 
end

endmodule
