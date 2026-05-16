/*-----------奥创光子Ultron 注释开始------------
文件名：adc_ADS7883.v
功能描述：ADS7883 ADC采样芯片驱动
设计者：Roc
设计时间：2024.5.29
版权所属：杭州奥创光子技术有限公司
修改信息：首版--2024.6.3
-------------奥创光子Ultron 注释结束------------*/
module adc_ADS7883(
	input				clk_i,		//系统时钟，50MHz
	input				rstn_i,		//复位信号
	input				AD_START,	//采样开始信号
    input 				din,		//SPI,数据信号
	output reg			cs,			//SPI,片选信号
	output reg			sclk,		//SPI,时钟信号，2.7V-4.5V供电时最大32MHz;2.7V-4.5V供电时最大32MHz，本项目采用25MHz
	output  	[11:0]	dout		//串行数据输出，12bit

);

reg [3:0]	cnt;	//50m / 4 = 12.5m;
reg [3:0]	state;
reg [11:0]	data_temp;
parameter CNT_MAX = 11;
assign dout = data_temp;
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		state <= 0;		//状态机
		cs <= 1;
        sclk <= 1;
        cnt <= 0; 
        data_temp <= 12'b0;
	end 
	else if(AD_START) begin
    	case(state)
		0:	begin 				//片选拉低
				sclk <= 1;
                cs <= 0;
            	state <= 1;
			end 
		1:	begin 				//20ns后(>7ns)，时钟引脚拉低
				sclk <= 0;
                state <= 2;
			end
        
        2:	begin				//20ns后，时钟引脚拉高(即时钟频率25MHz)
        		sclk <= 1;
                state <= 3;
            end
        3:	begin				//20ns后，时钟引脚拉低
        		sclk <= 0;		
                state <= 4;
            end
        4:	begin				//20ns后，时钟引脚拉高
        		sclk <= 1;	
                state <= 5;
            end
        5:	begin				//20ns后，时钟引脚拉低，采样数据
        		sclk <= 0;	
                data_temp[11-cnt] <= din; 
                if(cnt == 11) begin
                    cnt <= 0;
                    state <= 6;
                end
                else begin
                	state <= 4;
                    cnt <= cnt+1;
                end
            end
         6:	begin
         		sclk <= 1;
                state <= 7;
         	end
         7:	begin
         		sclk <= 0;
                state <= 8;
         	end
         8:	begin
         		sclk <= 1;
                state <= 9;
         	end
         9:	begin
         		sclk <= 0;
                cs <= 1;
                state <= 0;
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
        data_temp <= 12'b0;
	end 
end

endmodule
