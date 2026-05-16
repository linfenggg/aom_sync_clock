module PD_WAVE(
	input 		PD_IN,
	input 		line,
	input [3:0]	PD_PULSE_LV,
	output reg	PD_OUT
);

(*keep*) wire 	PD_DLY0 ;
(*keep*) wire 	PD_DLY1 ;
(*keep*) wire 	PD_DLY2 ;
(*keep*) wire 	PD_DLY3 ;
(*keep*) wire 	PD_DLY4 ;
(*keep*) wire 	PD_DLY5 ;
(*keep*) wire 	PD_DLY6 ;
(*keep*) wire 	PD_DLY7 ;
(*keep*) wire 	PD_DLY8 ;
(*keep*) wire 	PD_DLY9 ;
(*keep*) wire 	PD_DLY10;
(*keep*) wire 	PD_DLY11;
(*keep*) wire 	PD_DLY12;
(*keep*) wire 	PD_DLY13;
(*keep*) wire 	PD_DLY14;
(*keep*) wire 	PD_DLY15;
(*keep*) wire 	PD_DLY16;
(*keep*) wire 	PD_DLY17;
(*keep*) wire 	PD_DLY18;
(*keep*) wire 	PD_DLY19;

(*keep*) wire 	tem0;
(*keep*) wire 	tem1;
(*keep*) wire 	tem2;
(*keep*) wire 	tem3;
(*keep*) wire 	tem4;

assign tem0 = PD_IN | PD_DLY0 
					  | PD_DLY1 
					  | PD_DLY2 
					  | PD_DLY3 
					
	;
assign tem1 = PD_IN | PD_DLY0 
					  | PD_DLY1 
					  | PD_DLY2 
					  | PD_DLY3 
					  | PD_DLY4 
					  | PD_DLY5 
					  | PD_DLY6 
					  | PD_DLY7 
	;
assign tem2 = PD_IN | PD_DLY0 
					  | PD_DLY1 
					  | PD_DLY2 
					  | PD_DLY3 
					  | PD_DLY4 
					  | PD_DLY5 
					  | PD_DLY6 
					  | PD_DLY7 
					  | PD_DLY8 
					  | PD_DLY9 
					  | PD_DLY10
					  | PD_DLY11
	;
assign tem3 = PD_IN | PD_DLY0 
					  | PD_DLY1 
					  | PD_DLY2 
					  | PD_DLY3 
					  | PD_DLY4 
					  | PD_DLY5 
					  | PD_DLY6 
					  | PD_DLY7 
					  | PD_DLY8 
					  | PD_DLY9 
					  | PD_DLY10
					  | PD_DLY11
					  | PD_DLY12
					  | PD_DLY13
					  | PD_DLY14
					  | PD_DLY15
	;
assign tem4 = PD_IN | PD_DLY0 
					  | PD_DLY1 
					  | PD_DLY2 
					  | PD_DLY3 
					  | PD_DLY4 
					  | PD_DLY5 
					  | PD_DLY6 
					  | PD_DLY7 
					  | PD_DLY8 
					  | PD_DLY9 
					  | PD_DLY10
					  | PD_DLY11
					  | PD_DLY12
					  | PD_DLY13
					  | PD_DLY14
					  | PD_DLY15
					  | PD_DLY16
					  | PD_DLY17
					  | PD_DLY18
					  | PD_DLY19
	;

assign PD_DLY0  = PD_IN & line;
assign PD_DLY1  = PD_DLY0  & line;
assign PD_DLY2  = PD_DLY1  & line;
assign PD_DLY3  = PD_DLY2  & line;
assign PD_DLY4  = PD_DLY3  & line;
assign PD_DLY5  = PD_DLY4  & line;
assign PD_DLY6  = PD_DLY5  & line;
assign PD_DLY7  = PD_DLY6  & line;
assign PD_DLY8  = PD_DLY7  & line;
assign PD_DLY9  = PD_DLY8  & line;
assign PD_DLY10 = PD_DLY9  & line;
assign PD_DLY11 = PD_DLY10 & line;
assign PD_DLY12 = PD_DLY11 & line;
assign PD_DLY13 = PD_DLY12 & line;
assign PD_DLY14 = PD_DLY13 & line;
assign PD_DLY15 = PD_DLY14 & line;
assign PD_DLY16 = PD_DLY15 & line;
assign PD_DLY17 = PD_DLY16 & line;
assign PD_DLY18 = PD_DLY17 & line;
assign PD_DLY19 = PD_DLY18 & line;

always @(*)
	case(PD_PULSE_LV)
	0:	PD_OUT = PD_IN;
	1:	PD_OUT = tem0;
	2:	PD_OUT = tem1;
	3:	PD_OUT = tem2;
	4:	PD_OUT = tem3;
	5:	PD_OUT = tem4;

	default : PD_OUT = PD_IN;
	endcase

endmodule 

