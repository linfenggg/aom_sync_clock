module ICR( 
	input		clk_i		,
	input		rstn_i		,
	input		ICR_OPEN	,//0-->1,滤波片进入光路
    input		ICR_CLOSE	,//0-->1,滤波片离开光路
	output	reg	ICR_A		,
	output	reg	ICR_B		
);

parameter CNT_MAX_PWR = 10000000 ; //线圈通电时间200mS
reg [31:0]  cnt_pwr;
reg	ICR_OPEN_reg0,ICR_OPEN_reg1;
reg	ICR_CLOSE_reg0,ICR_CLOSE_reg1;

always @(posedge clk_i) begin 
	ICR_OPEN_reg0 <= ICR_OPEN;
	ICR_OPEN_reg1 <= ICR_OPEN_reg0;
end 

always @(posedge clk_i) begin 
	ICR_CLOSE_reg0 <= ICR_CLOSE;
	ICR_CLOSE_reg1 <= ICR_CLOSE_reg0;
end 

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        cnt_pwr <= 0;
    else if((ICR_OPEN_reg0 && !ICR_OPEN_reg1)||(ICR_CLOSE_reg0 && !ICR_CLOSE_reg1))
    	cnt_pwr <= 0;  
    else if(cnt_pwr < CNT_MAX_PWR-1)
        cnt_pwr <= cnt_pwr+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i) begin
        ICR_A <= 0;
        ICR_B <= 0;
        end
	else if(ICR_OPEN_reg0 && !ICR_OPEN_reg1) begin//上升沿
        ICR_A <= 1;
        ICR_B <= 0;
    end
    else if(ICR_CLOSE_reg0 && !ICR_CLOSE_reg1) begin//上升沿
    	ICR_A <= 0;
        ICR_B <= 1;
    end
    else if(cnt_pwr==CNT_MAX_PWR-1) begin
    	ICR_A <= 0;
        ICR_B <= 0;
    end       	
end

endmodule
