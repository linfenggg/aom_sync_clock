//
module calibration_aom(
	input					clk_i,
	input					rstn_i,
	input [3:0]				POWER_CTRL_SEL,	//4bit，激光功率控制选择，0-外部8bit，1-外部模拟量,2-内部设置,3-功率校准
	input [9:0]				din_i,			//功率设定值
	input 					start_status,	
	input [11:0]			AOM_MAX,		//AOM DAC最大值
	
    input [9:0]				START_THR,	 
    input [9:0]				P3_THR	,
    input [9:0]				P6_THR	,
	input [9:0]				THR1_i , 		//十段AD校准值(段值)
	input [9:0]				THR2_i , 
	input [9:0]				THR3_i , 
	input [9:0]				THR4_i , 
	input [9:0]				THR5_i , 
	input [9:0]				THR6_i , 
	input [9:0]				THR7_i , 
	input [9:0]				THR8_i , 
	input [9:0]				THR9_i , 
	input [9:0]				THR10_i,
	
    input [31:0]			P3_K ,
    input [31:0]			P6_K ,
	input [31:0] 			K1_i ,    		//校准K值   15位定点数+8位数据   
	input [31:0] 	     	K2_i , 
	input [31:0] 	     	K3_i , 
	input [31:0] 	     	K4_i , 
	input [31:0] 	     	K5_i , 
	input [31:0] 	     	K6_i , 
	input [31:0] 	     	K7_i , 
	input [31:0] 	     	K8_i , 
	input [31:0] 	     	K9_i , 
	input [31:0] 	     	K10_i,
	
    input [9:0]				P92_THR,	
	input [31:0]			P92_K ,
    input [9:0]				P94_THR,	
	input [31:0]			P94_K ,
    input [9:0]				P96_THR,	
	input [31:0]			P96_K ,
    input [9:0]				P98_THR,	
	input [31:0]			P98_K ,
	output reg [9:0]		cal_dout_o	
);
`include "parameter_def.v"

parameter BASE_AD = 102;	//基础AD量，等于满量程时的AD量的十分之一 2^10=1024

reg [31:0]			K_SEL;
reg [9:0]			THR_AD;		//当前功率区间前段
reg [9:0]			THR_CAL;	//当前校准功率DA值的前段
reg	[2:0]			den_dly;
reg [9:0]			mult_a; 	//不可能出现负数
reg [31:0]			mult_b;
wire [41:0]			result;
reg [11:0]			cal_data;	//位宽搞大点
reg [9:0]			din_reg0;

PH1A_MULT8X32 PH1A_MULT8X32(	//10x32
	.a		(mult_a),
	.y		(mult_b),
	.p      (result)
);

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		din_reg0 <= 0;
	else 
		din_reg0 <= din_i;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin
		mult_a <= 0;
		mult_b <= 0;
	end
	else begin
		mult_a <= din_reg0 - THR_AD;	//din延后一拍
		mult_b <= K_SEL;	//结果需要右移15位
	end
end
		
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		cal_data <= 0;
	else 	
		cal_data <= result[24:15] + THR_CAL;
end
		
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) 
		cal_dout_o <= 0;
	else if(start_status==0)
		cal_dout_o <= 0;
	else if(POWER_CTRL_SEL==3)
		cal_dout_o <= din_i;
	else if(cal_data > AOM_MAX)
		cal_dout_o <= AOM_MAX;
	else 
		cal_dout_o <= cal_data;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		K_SEL <= 32768;
		THR_AD <= 0;
		THR_CAL <= 0;
	end 
	else begin
    if(din_i==0) begin //0%时，DAC输出为0，不出光
		K_SEL <= 32768;
		THR_AD <= 0;
		THR_CAL <= 0;
	end 
	if(din_i > 0 &&din_i<=30) begin //0-3%
		K_SEL <= P3_K;
		THR_AD <= 0;
		THR_CAL <= START_THR;
	end 
		//
	if(din_i > 30 && din_i<=60)begin 	//3-6%
		K_SEL <= P6_K;
		THR_AD <= 30;
		THR_CAL <= P3_THR;
	end 
		//
	if(din_i > 60 && din_i<=BASE_AD*1)begin 	//6-10%
		K_SEL <= K1_i;
		THR_AD <= 60;
		THR_CAL <= P6_THR;
	end 
	if(din_i>BASE_AD*1 && din_i<=BASE_AD*2)begin //10-20%
		K_SEL <= K2_i;
		THR_AD <= BASE_AD*1;
		THR_CAL <= THR1_i;
	end 
	if(din_i>BASE_AD*2 && din_i<=BASE_AD*3)begin //20-30%
		K_SEL <= K3_i;
		THR_AD <= BASE_AD*2;
		THR_CAL <= THR2_i;
	end 
	if(din_i>BASE_AD*3 && din_i<=BASE_AD*4)begin //30-40%
		K_SEL <= K4_i;
		THR_AD <= BASE_AD*3;
		THR_CAL <= THR3_i;
	end
	if(din_i>BASE_AD*4 && din_i<=BASE_AD*5)begin //40-50%
		K_SEL <= K5_i;
		THR_AD <= BASE_AD*4;
		THR_CAL <= THR4_i;
	end 
	if(din_i>BASE_AD*5 && din_i<=BASE_AD*6)begin //50-60%
		K_SEL <= K6_i;
		THR_AD <= BASE_AD*5;
		THR_CAL <= THR5_i;
	end 
	if(din_i>BASE_AD*6 && din_i<=BASE_AD*7)begin //60-70%
		K_SEL <= K7_i;
		THR_AD <= BASE_AD*6;
		THR_CAL <= THR6_i;
	end 
	if(din_i>BASE_AD*7 && din_i<=BASE_AD*8)begin //70-80%
		K_SEL <= K8_i;
		THR_AD <= BASE_AD*7;
		THR_CAL <= THR7_i;
	end 
	if(din_i>BASE_AD*8 && din_i<=BASE_AD*9)begin //80-90%
		K_SEL <= K9_i;
		THR_AD <= BASE_AD*8;
		THR_CAL <= THR8_i;
	end 
	if(din_i>BASE_AD*9 && din_i<=938) begin 	//90-92%
		K_SEL <= P92_K;
		THR_AD <= BASE_AD*9;
		THR_CAL <= THR9_i;
	end 
	if(din_i>938 && din_i<=958) begin 	//92-94%
		K_SEL <= P94_K;
		THR_AD <= 938;
		THR_CAL <= P92_THR;
	end 
	if(din_i>958 && din_i<=979) begin 	//94-96%
		K_SEL <= P96_K;
		THR_AD <= 958;
		THR_CAL <= P94_THR;
	end 
	if(din_i>979 && din_i<=999) begin 	//96-98%
		K_SEL <= P98_K;
		THR_AD <= 979;
		THR_CAL <= P96_THR;
	end 
	if(din_i>999 && din_i<=1024) begin 	//98-100%
		K_SEL <= K10_i;
		THR_AD <= 999;
		THR_CAL <= P98_THR;
	end
    /*if(din_i>BASE_AD*9 && din_i<=1024) begin 	//90-100%
		K_SEL <= K10_i;
		THR_AD <= BASE_AD*9;
		THR_CAL <= THR9_i;
	end*/
	end 
end		
				
endmodule