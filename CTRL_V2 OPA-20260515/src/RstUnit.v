module RstUnit(
	output	reg rst
);

wire clkosc; //defualt XXMHz
PH1_PHY_OSCDIV	U_CCLK(
    			.osc_clk	(clkosc), 
                .rstn		(1'b1),
                .stdby 		(1'b0)
);
	
(*keep*) wire asynrst = 1'b0;
	
reg [15:0]	PowerOnDelayCnt;
always @(posedge clkosc or posedge asynrst) begin
	if(asynrst) 
    	PowerOnDelayCnt <= 0;
	else if(PowerOnDelayCnt != 16'hffff) 
   		PowerOnDelayCnt <= PowerOnDelayCnt + 1;
end
	
always @(posedge clkosc or posedge asynrst) begin
	if(asynrst) 
    	rst <= 1'b1;
	else if(PowerOnDelayCnt != 16'hffff) 
    	rst <= 1'b1;
	else 
    	rst <= 1'b0;
end

endmodule
