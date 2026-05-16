library verilog;
use verilog.vl_types.all;
entity cnt_delay is
    port(
        clk_i           : in     vl_logic;
        rstn_i          : in     vl_logic;
        dly_in          : in     vl_logic;
        dly_num         : in     vl_logic_vector(7 downto 0);
        dly_out         : out    vl_logic
    );
end cnt_delay;
