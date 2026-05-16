module MS9714(
    input       		clk_i,
    input       		rstn_i,
    input 		[13:0]  din,
    output              clock,
    output reg 	[13:0]  dout
);

assign clock = clk_i;

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        dout <= 0;
    else 
        dout <= din;
end

endmodule
