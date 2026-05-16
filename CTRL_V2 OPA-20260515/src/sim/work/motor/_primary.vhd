library verilog;
use verilog.vl_types.all;
entity motor is
    port(
        clk_i           : in     vl_logic;
        rstn_i          : in     vl_logic;
        AD_START        : in     vl_logic;
        reset           : in     vl_logic;
        period          : in     vl_logic_vector(15 downto 0);
        step_num        : in     vl_logic_vector(17 downto 0);
        step_sta        : out    vl_logic_vector(17 downto 0);
        overflow        : out    vl_logic;
        cw              : in     vl_logic;
        ccw             : in     vl_logic;
        pulse           : out    vl_logic;
        direct          : out    vl_logic
    );
end motor;
