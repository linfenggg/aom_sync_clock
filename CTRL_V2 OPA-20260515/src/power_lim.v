module power_lim(
    input				clk_i,
	input				rstn_i,

    input [9:0]         din,
    input [17:0]        POWER_K_SET,

    output [9:0]        dout
);

wire [27:0]			result;
PH1A_MULT10X18 PH1A_MULT10X18(	//10x18
	.a		(din),
	.y		(POWER_K_SET),
	.p      (result)
);

assign dout = result >>15;

endmodule