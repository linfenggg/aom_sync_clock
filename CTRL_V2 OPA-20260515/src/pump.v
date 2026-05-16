module pump(
    input					clk_i,	//50M
    input					rstn_i,

    input [3:0]		        WORK_MODE,
    input                   lock,
    input [3:0]             PUMP_NUM,
    input                   PUMP_SW,
    input [11:0]             PUMP_DATA,

    input [23:0]            RAMP_SPEED,
    input [23:0]            SUB_SPEED,

    input [14:0]            OTHER_PIR1,
    input [14:0]            OTHER_PIR2,
    input [14:0]            OTHER_PIR3,
    input [14:0]            OTHER_PIR4,
    input [14:0]            OTHER_PIR5,
    input [14:0]            OTHER_PIR6,
    input [14:0]            OTHER_PIR7,
    input [14:0]            OTHER_PIR8,
    input [14:0]            OTHER_PIR9,
    input [14:0]            OTHER_PIR10,
    input [14:0]            OTHER_PIR11,
    input [14:0]            OTHER_PIR12,
    input [14:0]            OTHER_PIR13,
    input [14:0]            OTHER_PIR14,

    input [14:0]            OTHER_OR_PIR1 ,
    input [14:0]            OTHER_OR_PIR2 ,
    input [14:0]            OTHER_OR_PIR3 ,
    input [14:0]            OTHER_OR_PIR4 ,
    input [14:0]            OTHER_OR_PIR5 ,
    input [14:0]            OTHER_OR_PIR6 ,
    input [14:0]            OTHER_OR_PIR7 ,
    input [14:0]            OTHER_OR_PIR8 ,
    input [14:0]            OTHER_OR_PIR9 ,
    input [14:0]            OTHER_OR_PIR10,
    input [14:0]            OTHER_OR_PIR11,
    input [14:0]            OTHER_OR_PIR12,
    input [14:0]            OTHER_OR_PIR13,
    input [14:0]            OTHER_OR_PIR14,

    output [11:0]            PUMP_DATA_RAMP,
    output reg [14:0]       PUMP_PIR,
    output reg [14:0]       PUMP_OR_PIR,
    output reg              PUMP_STA    //1开0关

);
`include "parameter_def.v"

reg     pir_sw; //按优先级开关
wire [14:0] AND_PIR,OR_PIR;
reg PUMP_STA_closed;

assign AND_PIR =    OTHER_PIR1 &
                    OTHER_PIR2 &
                    OTHER_PIR3 &
                    OTHER_PIR4 &
                    OTHER_PIR5 &
                    OTHER_PIR6 &
                    OTHER_PIR7 &
                    OTHER_PIR8 &
                    OTHER_PIR9 &
                    OTHER_PIR10 &
                    OTHER_PIR11 &
                    OTHER_PIR12 &
                    OTHER_PIR13 &
                    OTHER_PIR14 
    ;
assign OR_PIR =     OTHER_OR_PIR1 |
                    OTHER_OR_PIR2 |
                    OTHER_OR_PIR3 |
                    OTHER_OR_PIR4 |
                    OTHER_OR_PIR5 |
                    OTHER_OR_PIR6 |
                    OTHER_OR_PIR7 |
                    OTHER_OR_PIR8 |
                    OTHER_OR_PIR9 |
                    OTHER_OR_PIR10 |
                    OTHER_OR_PIR11 |
                    OTHER_OR_PIR12 |
                    OTHER_OR_PIR13 |
                    OTHER_OR_PIR14 
    ;


always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        pir_sw <= 0;
    else if(WORK_MODE == DEBUG && PUMP_SW)	//调试模式，打开泵浦时
        pir_sw <= PUMP_SW;
    else case(PUMP_NUM)	//调试模式，关闭泵浦时；或者正常手动模式，开关泵浦时，按照此逻辑进行时序开关
    1:  if((|OR_PIR[14:1]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if(PUMP_SW)
            pir_sw <= 1;
    2:  if((|OR_PIR[14:2]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if(AND_PIR[0] == 1 && PUMP_SW)
            pir_sw <= 1;
    3:  if((|OR_PIR[14:3]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[1:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    4:  if((|OR_PIR[14:4]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[2:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    5:  if((|OR_PIR[14:5]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[3:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    6:  if((|OR_PIR[14:6]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[4:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    7:  if((|OR_PIR[14:7]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[5:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    8:  if((|OR_PIR[14:8]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[6:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    9:  if((|OR_PIR[14:9]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[7:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    10:  if((|OR_PIR[14:10]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[8:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    11:  if((|OR_PIR[14:11]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[9:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    12:  if((|OR_PIR[14:12]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[10:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    13:  if((|OR_PIR[14:13]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[11:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    14:  if((OR_PIR[14]) == 0 && !PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[12:0]) == 1 && PUMP_SW)
            pir_sw <= 1;
    15:  if(!PUMP_SW)
            pir_sw <= 0;
        else if((&AND_PIR[13:0]) == 1 && PUMP_SW)
            pir_sw <= 1;

    default : pir_sw <= pir_sw;
    endcase

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        PUMP_PIR <= {15'b111_1111_1111_1111};
    else case(PUMP_NUM)
    1:   PUMP_PIR <= {14'b11_1111_1111_1111,PUMP_STA};
    2:   PUMP_PIR <= {13'b1_1111_1111_1111,PUMP_STA,1'b1};
    3:   PUMP_PIR <= {12'b1111_1111_1111,PUMP_STA,2'b11};
    4:   PUMP_PIR <= {11'b111_1111_1111,PUMP_STA,3'b111};
    5:   PUMP_PIR <= {10'b11_1111_1111,PUMP_STA,4'b1111};
    6:   PUMP_PIR <= {9'b1_1111_1111,PUMP_STA,5'b1_1111};
    7:   PUMP_PIR <= {8'b1111_1111,PUMP_STA,6'b11_1111};
    8:   PUMP_PIR <= {7'b111_1111,PUMP_STA,7'b111_1111};
    9:   PUMP_PIR <= {6'b11_1111,PUMP_STA,8'b1111_1111};
    10:  PUMP_PIR <= {5'b1_1111,PUMP_STA,9'b1_1111_1111};
    11:  PUMP_PIR <= {4'b1111,PUMP_STA,10'b11_1111_1111};
    12:  PUMP_PIR <= {3'b111,PUMP_STA,11'b111_1111_1111};
    13:  PUMP_PIR <= {2'b11,PUMP_STA,12'b1111_1111_1111};
    14:  PUMP_PIR <= {1'b1,PUMP_STA,13'b1_1111_1111_1111};
    15:  PUMP_PIR <= {PUMP_STA,14'b11_1111_1111_1111};
    
    default : PUMP_PIR <= 15'b111_1111_1111_1111;
    endcase

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        PUMP_OR_PIR <= 15'B0;
    else case(PUMP_NUM)
    1:   PUMP_OR_PIR <= {14'B0,PUMP_STA_closed};
    2:   PUMP_OR_PIR <= {13'B0,PUMP_STA_closed,1'B0};
    3:   PUMP_OR_PIR <= {12'B0,PUMP_STA_closed,2'B0};
    4:   PUMP_OR_PIR <= {11'B0,PUMP_STA_closed,3'B0};
    5:   PUMP_OR_PIR <= {10'B0,PUMP_STA_closed,4'B0};
    6:   PUMP_OR_PIR <= {9'B0,PUMP_STA_closed,5'B0};
    7:   PUMP_OR_PIR <= {8'B0,PUMP_STA_closed,6'B0};
    8:   PUMP_OR_PIR <= {7'B0,PUMP_STA_closed,7'B0};
    9:   PUMP_OR_PIR <= {6'B0,PUMP_STA_closed,8'B0};
    10:  PUMP_OR_PIR <= {5'B0,PUMP_STA_closed,9'B0};
    11:  PUMP_OR_PIR <= {4'B0,PUMP_STA_closed,10'B0};
    12:  PUMP_OR_PIR <= {3'B0,PUMP_STA_closed,11'B0};
    13:  PUMP_OR_PIR <= {2'B0,PUMP_STA_closed,12'B0};
    14:  PUMP_OR_PIR <= {1'B0,PUMP_STA_closed,13'B0};
    15:  PUMP_OR_PIR <= {PUMP_STA_closed,14'B0};
    
    default : PUMP_OR_PIR <= 15'B0;
    endcase

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		PUMP_STA <= 0;
	else if(PUMP_DATA_RAMP >= PUMP_DATA && PUMP_DATA_RAMP>=10)	//开启时
		PUMP_STA <= 1; 
	else if(pir_sw==0 && PUMP_DATA_RAMP==0)
		PUMP_STA <= 0;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
		PUMP_STA_closed <= 0;
	else if(PUMP_DATA_RAMP>=1)
		PUMP_STA_closed <= 1; 
	else
		PUMP_STA_closed <= 0;


pump_ramp	ramp(
    .clk_i			    (clk_i),	//50M 20ns
	.rstn_i			    (rstn_i),
	.lock			    (lock),
	.PUMP_SW		    (pir_sw),//
    .RAMP_SPEED		    (RAMP_SPEED),
	.SUB_SPEED		    (SUB_SPEED),
    .PUMP_DATA		    (PUMP_DATA),
    .PUMP_DATA_RAMP	    (PUMP_DATA_RAMP)
);



endmodule