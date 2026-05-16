module pump_ramp(
    input 			clk_i,	//50M 20ns
	input 			rstn_i,

    input           lock,
    input           PUMP_SW,
    input [23:0]    RAMP_SPEED,
    input [23:0]    SUB_SPEED,
    input [11:0]     PUMP_DATA,

    output reg [11:0]    PUMP_DATA_RAMP

);

reg [23:0]  cnt_add;
reg [23:0]  cnt_sub;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        cnt_add <= 0;
    else if(cnt_add >= RAMP_SPEED)
        cnt_add <= 0;
    else 
        cnt_add <= cnt_add+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        cnt_sub <= 0;
    else if(cnt_sub >= SUB_SPEED)
        cnt_sub <= 0;
    else 
        cnt_sub <= cnt_sub+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        PUMP_DATA_RAMP <= 0;
    else if(lock)
        PUMP_DATA_RAMP <= 0;
    else if(PUMP_SW==0 && cnt_sub >= SUB_SPEED && PUMP_DATA_RAMP>0)    //SW关闭时，把data值降到0
        PUMP_DATA_RAMP <= PUMP_DATA_RAMP - 1;
    else if(PUMP_SW==1 && cnt_add >= RAMP_SPEED && PUMP_DATA_RAMP < PUMP_DATA)
        PUMP_DATA_RAMP <= PUMP_DATA_RAMP + 1;
    else if(PUMP_SW==1 && cnt_sub >= SUB_SPEED && PUMP_DATA_RAMP > PUMP_DATA)
        PUMP_DATA_RAMP <= PUMP_DATA_RAMP - 1;

endmodule 