module feed_dog(
    input			clk_i,	//50M 20ns
	input			rstn_i,
    output reg      dout
);

reg [15:0]  cnt;    //

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        cnt <= 0;
    else 
        cnt <= cnt+1;
end

always @(posedge clk_i or negedge rstn_i) begin
	if(!rstn_i)
        dout <= 0;
    else if(cnt == 16'hffff)
        dout <= ~dout;
end

endmodule