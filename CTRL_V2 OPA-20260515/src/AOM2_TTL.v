//通过给客户同步信号规避半个脉冲问题
module AOM2_TTL(
	input			clk_i,	//100m
	input			rstn_i,
	
	input [3:0]		AOM_CTRL_SEL,
	input [15:0]	AOM2_HEAD_DLY,
	input 			FREE_TRIG_AOM2_MODE,
	input 			AOM1_PULSE_CLR,
	input 			AOM1_SW,	//表示AOM1在出光
	input 			gate,

	output reg [15:0]	pulse_data,
	output reg			AOM2_SW_out,
    input  	   [15:0]	SPACE_AOM_FULL_OPEN_FRQ,
    input 				SPACE_AOM_FULL_OPEN_EN,
    input	   [15:0]	BST_PERIOD,
    input	   [24:0]	POD_DATA,
    input	   [7:0]	POD_NUM,
    input	   [7:0]	LASER_TYPE
);
`include "parameter_def.v"

reg [3:0]	state;
reg [15:0]	cnt,cnt1;
reg 		AOM1_SW_reg0,AOM1_SW_reg1;
reg [15:0]	AOM2_HEAD_DLY_reg0,AOM2_HEAD_DLY_reg1;
reg	[7:0]	cnt_POD; 	//POD脉冲的个数（TRIG信号触发后，放出的选单信号的数量），最多100个
reg [24:0]	pulseen_POD;	//POD脉冲的每一个脉冲选择是放出，还是不放，1：放出，0-不放
reg			AOM2_SW,AOM2_SW_trig;
always @(*) begin 
if((AOM_CTRL_SEL==2)&&(POD_NUM ==1))	//正常TRIG模式
	AOM2_SW_out <= AOM2_SW_trig;
else if((AOM_CTRL_SEL==0)||(AOM_CTRL_SEL==1))	//内控或者GATE模式
	AOM2_SW_out <= AOM2_SW_trig;
else									//POD模式，FRETRIG模式
	AOM2_SW_out <= AOM2_SW;
end

//AOM2_SW_out=(((AOM_CTRL_SEL==2)&&(POD_NUM ==1))||(AOM_CTRL_SEL==0)||(AOM_CTRL_SEL==1))?AOM2_SW_trig:AOM2_SW;
always @(posedge clk_i) begin 
	AOM1_SW_reg0 <= AOM1_SW;
	AOM1_SW_reg1 <= AOM1_SW_reg0;
end

always @(posedge clk_i) begin 
	AOM2_HEAD_DLY_reg0 <= AOM2_HEAD_DLY;
	AOM2_HEAD_DLY_reg1 <= AOM2_HEAD_DLY_reg0;
end 

//TRIG模式下,AOM2展宽处理，从状态机中单独拿出来，主要是展宽影响状态机对TRIG信号的捕捉，会丢脉冲
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin 
		AOM2_SW_trig <= 0;
		cnt1 <= 0;
	end
   else if(SPACE_AOM_FULL_OPEN_EN==1 && BST_PERIOD <= SPACE_AOM_FULL_OPEN_FRQ)
	AOM2_SW_trig<=gate;
	else if(state==1 && AOM1_SW_reg0 && !AOM1_SW_reg1) begin
		cnt1 <= 0;
		AOM2_SW_trig <= 1;//TRIG和一级选单信号来了，AOM2就会打开
	end
	else if(cnt1 >= AOM2_HEAD_DLY_reg1) begin	//AOM2展宽
		AOM2_SW_trig <= 0;
		cnt1 <= 0;
	end
	else
		cnt1 <= cnt1+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)	begin 
		state <= 0;
		cnt <= 0;
		AOM2_SW <= 0;
        cnt_POD <= 8'b0;
        pulseen_POD <= 25'b1;
		end 
	else if((AOM_CTRL_SEL==0 || AOM_CTRL_SEL==1||AOM_CTRL_SEL==3) && SPACE_AOM_FULL_OPEN_EN==1 && BST_PERIOD <= SPACE_AOM_FULL_OPEN_FRQ)	
    	//内控模式/GATE/freetrig模式下，选单频率高于二级声光全开的选单频率设定值时，二级声光全开)
    	begin
        if(gate&&AOM1_SW_reg0 && !AOM1_SW_reg1)
        	AOM2_SW <= 1;
        else if(!gate)	
        	AOM2_SW <= 0;
        end
  	/*else if(AOM_CTRL_SEL==3 && FREE_TRIG_AOM2_MODE==1) //freetrigger模式，AOM2常开出光
		AOM2_SW <= 1;*/
  	else if(AOM_CTRL_SEL==3)//freetrigger模式，AOM2跟随TRIG信号出光
    	case(state)
		0	:	if(gate && AOM1_SW_reg0 && !AOM1_SW_reg1) begin //上升沿，开始放burst
					AOM2_SW <= 1;
					cnt <= 0;
					state <= 2;
				end 
		/*1	:	if(!AOM1_SW_reg0 && AOM1_SW_reg1) begin	//下降沿，burst放完
					state <= 2;
				end*/
		2	:	if(cnt < AOM2_HEAD_DLY_reg1)//展宽,二级声光把burst全部包络，防止切光
					cnt <= cnt+1;
				else begin 
					AOM2_SW <= 0;
					state <= 0;
					cnt <= 0;
				end 
		default : state <= 0;
	endcase
	else if((AOM_CTRL_SEL==2)&&(POD_NUM ==1))//TRIG模式(常规单脉冲的TRIG模式)
    	case(state)
			0 : if(gate) begin//if(EXTSIG_VALID && trig_reg1 && !trig_reg2) //TRIG模式下，trig信号上升沿有效
					state <= 1;
				end
			1 : if(AOM1_SW_reg0 && !AOM1_SW_reg1) begin //上升沿，开始放burst
					state <= 0;
				end
			/*2 :if(!AOM1_SW_reg0 && AOM1_SW_reg1) 		//下降沿，burst放完
					state <= 3;
			3 : begin
            	if(gate)
                	state <= 1;
               	else
					state <= 0;
				end*/
			default : state <= 0;
		endcase
    else if((AOM_CTRL_SEL==2)&&(POD_NUM >1))//TRIG模式(POD模式)
    	case(state)
		0	:	if(gate) 	//TRIG模式下，trig信号上升沿有效
					state <= 1;
		1	:	if(AOM1_SW_reg0 && !AOM1_SW_reg1) begin 	 //上升沿，开始放burst
					if(LASER_TYPE == 22)//医美机型，根据POD数量，直接全放出
                    	AOM2_SW <= 1;
                    else begin
                    	if(POD_DATA & pulseen_POD)	//第几个选单信号是否放出
                    		AOM2_SW <= 1;
                    	else	
                    		AOM2_SW <= 0;
                    end
					cnt <= 0;
                    cnt_POD <= cnt_POD + 1;
                    pulseen_POD <= pulseen_POD << 1;
                    state <= 3;
				end 
		/*2	:	if(!AOM1_SW_reg0 && AOM1_SW_reg1) begin	//下降沿，burst放完
					state <= 3;
				end*/
		3	:	if(cnt < AOM2_HEAD_DLY_reg1)	//AOM2开关信号展宽
					cnt <= cnt+1;
				else begin 
					AOM2_SW <= 0;
                    cnt <= 0;
					if(cnt_POD ==POD_NUM) begin
                    	state <= 0;
                        pulseen_POD <= 25'b1;
                        cnt_POD <= 0;
                    end
                    else	
                    	state <= 1;
				end 
		default : state <= 0;
	endcase  
	else//内控和GATE模式
    	case(state)
		0	:	if(gate) 	//GATE模式下和内控模式下，gate信号高电平有效
					state <= 1;
		1	:	if(AOM1_SW_reg0 && !AOM1_SW_reg1)	//上升沿，开始放burst
                    state <= 0;
		/*2	:	if(!AOM1_SW_reg0 && AOM1_SW_reg1)	//下降沿，burst放完
					state <= 3; 
		3	:	if(gate)
                   	state <= 1;
                else 
                   	state <= 0;*/
		default : state <= 0;
	endcase
    /*else//内控和GATE模式
    	case(state)
		0	:	if(gate) 	//GATE模式下和内控模式下，gate信号高电平有效
					state <= 1;
		1	:	if(AOM1_SW_reg0 && !AOM1_SW_reg1) begin 	 //上升沿，开始放burst
                    AOM2_SW <= 1;
					cnt <= 0;
                    state <= 2;
				end 
		2	:	if(!AOM1_SW_reg0 && AOM1_SW_reg1) begin	//下降沿，burst放完
					state <= 3;
				end
		3	:	if(cnt < AOM2_HEAD_DLY_reg1)	//AOM2开关信号展宽
                   cnt <= cnt+1;
				else begin
                   AOM2_SW <= 0;
                   cnt <= 0;
                   if(gate)
                   		state<= 1;
                   else 
                   		state <= 0;
                end
		default : state <= 0;
	endcase*/
end

//脉冲计数
always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
		pulse_data <= 0;
	else if(AOM1_PULSE_CLR)
		pulse_data <= 0;
	else if((!AOM1_SW_reg0 && AOM1_SW_reg1) && AOM2_SW )
		pulse_data <= pulse_data+1;
end

endmodule 