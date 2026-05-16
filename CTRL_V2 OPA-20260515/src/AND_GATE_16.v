`timescale 1ns/1ns

module AND_GATE_16(
	dly_in,
	dly_out,
	line,
	dly_num
);

input dly_in;
input[4:0] dly_num;			//延时参数，
input line;
output dly_out;

(*keep*) wire t1;	(*keep*) wire t15;		
(*keep*) wire t2;   (*keep*) wire t16;       
(*keep*) wire t3;   (*keep*) wire t17;       
(*keep*) wire t4;   (*keep*) wire t18;       
(*keep*) wire t5;   (*keep*) wire t19;       
(*keep*) wire t6;   (*keep*) wire t20;       
(*keep*) wire t7;   (*keep*) wire t21;       
(*keep*) wire t8;   (*keep*) wire t22;       
(*keep*) wire t9;   (*keep*) wire t23;       
(*keep*) wire t10;  (*keep*) wire t24;      
(*keep*) wire t11;  (*keep*) wire t25;      
(*keep*) wire t12;  (*keep*) wire t26;      
(*keep*) wire t13;  (*keep*) wire t27;      
(*keep*) wire t14;  (*keep*) wire t28;      
(*keep*) wire t15;  (*keep*) wire t29;          
  

/////////////////////////////////////
assign t1  = dly_in&line;	assign t17 = t16&line;
assign t2  = t1&line;		assign t18 = t17&line;	
assign t3  = t2&line;       assign t19 = t18&line;    
assign t4  = t3&line;       assign t20 = t19&line;    
assign t5  = t4&line;       assign t21 = t20&line;    
assign t6  = t5&line;       assign t22 = t21&line;    
assign t7  = t6&line;       assign t23 = t22&line;    
assign t8  = t7&line;       assign t24 = t23&line;    
assign t9  = t8&line;       assign t25 = t24&line;    
assign t10 = t9&line;       assign t26 = t25&line;    
assign t11 = t10&line;      assign t27 = t26&line;   
assign t12 = t11&line;      assign t28 = t27&line;   
assign t13 = t12&line;      assign t29 = t28&line;   
assign t14 = t13&line;      assign t30 = t29&line;   
assign t15 = t14&line;      assign t31 = t30&line;  
assign t16 = t15&line;     

reg out;
always@(*) 
    case(dly_num)
	0  	:	out = dly_in	& dly_in;      
	1  	:	out = t1        & dly_in;
	2  	:	out = t2        & dly_in;
	3  	:	out = t3        & dly_in;
	4  	:	out = t4        & dly_in;
	5  	:	out = t5        & dly_in;
	6  	:	out = t6        & dly_in;
	7  	:	out = t7        & dly_in;
	8  	:	out = t8        & dly_in;
	9  	:	out = t9        & dly_in;
	10 	:	out = t10       & dly_in;
	11 	:	out = t11       & dly_in;
	12 	:	out = t12       & dly_in;
	13 	:	out = t13       & dly_in;
	14 	:	out = t14       & dly_in;
	15 	:	out = t15       & dly_in;
	16 	:	out = t16       & dly_in;
	17 	:	out = t17       & dly_in;
	18 	:	out = t18       & dly_in;
	19 	:	out = t19       & dly_in;
	20 	:	out = t20       & dly_in;
	21 	:	out = t21       & dly_in;
	22 	:	out = t22       & dly_in;
	23 	:	out = t23       & dly_in;
	24 	:	out = t24       & dly_in;
	25 	:	out = t25       & dly_in;
	26 	:	out = t26       & dly_in;
	27 	:	out = t27       & dly_in;
	28 	:	out = t28       & dly_in;
	29 	:	out = t29       & dly_in;
	30 	:	out = t30       & dly_in;
	31 	:	out = t31       & dly_in;
	
	default out = dly_in	& dly_in;
    endcase

assign dly_out =  out ;  

endmodule 





