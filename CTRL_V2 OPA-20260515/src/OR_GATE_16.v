`timescale 1ns/1ns

module OR_GATE_16(
	dly_in,
	dly_out,
	line,
	dly_num
);

input 		dly_in;
input[5:0] 	dly_num;			//延时参数
input 		line;
output 		dly_out;
reg			out;




 parameter DELAY_STEP_MAX =64;
  

 (*keep*)  wire [DELAY_STEP_MAX-1:0]delay;

  assign delay[0]=dly_in;
 genvar index ;
 generate
for(index=1;index<DELAY_STEP_MAX ;index=index+1)begin :delay_loop

(*keep*) PH1_LOGIC_BUF dly(.o(delay[index]),.i(delay[index-1]|dly_in));
end

 endgenerate


 assign  dly_out=delay[dly_num];

endmodule 
