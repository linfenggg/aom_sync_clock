module pll_feed_dog(
    input           clk_i, //100M
    input           rstn_i,

    input           en,
    input           alm_en,
    input           pll_in,
    output reg      pll_alm
);

reg         pll_in_reg0,pll_in_reg1,pll_in_reg2;
reg [7:0]   cnt;    // 100m/1m = 100

parameter CNT_MAX = 100-1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) begin 
        pll_in_reg0 <= 0;
        pll_in_reg1 <= 0;
        pll_in_reg2 <= 0;
    end 
    else begin 
        pll_in_reg0 <= pll_in;
        pll_in_reg1 <= pll_in_reg0;
        pll_in_reg2 <= pll_in_reg1;
    end 

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        cnt <= 0;
    else if(en == 0 || alm_en==0)
        cnt <= 0;
    else if(pll_in_reg1 && !pll_in_reg2)    //posedge
        cnt <= 0;
    else 
        cnt <= cnt+1;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i)
        pll_alm <= 0;
    else if(en == 0 || alm_en==0)
        pll_alm <= 0;
    else if(cnt > CNT_MAX)
        pll_alm <= 1;



endmodule