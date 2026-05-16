library verilog;
use verilog.vl_types.all;
entity PCA9555 is
    generic(
        DIV_MAX         : integer := 400;
        DIV_QUA         : vl_notype;
        DIV_3_QUA       : vl_notype;
        WR              : vl_logic := Hi0;
        RD              : vl_logic := Hi1;
        ACK             : vl_logic := Hi0;
        NOACK           : vl_logic := Hi1;
        SLAVE_ADDR      : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        CMD_BYTE        : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk_i           : in     vl_logic;
        rstn_i          : in     vl_logic;
        AD_START        : in     vl_logic;
        SCL             : out    vl_logic;
        SDA             : in     vl_logic;
        data0           : out    vl_logic_vector(7 downto 0);
        data1           : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DIV_MAX : constant is 1;
    attribute mti_svvh_generic_type of DIV_QUA : constant is 3;
    attribute mti_svvh_generic_type of DIV_3_QUA : constant is 3;
    attribute mti_svvh_generic_type of WR : constant is 1;
    attribute mti_svvh_generic_type of RD : constant is 1;
    attribute mti_svvh_generic_type of ACK : constant is 1;
    attribute mti_svvh_generic_type of NOACK : constant is 1;
    attribute mti_svvh_generic_type of SLAVE_ADDR : constant is 1;
    attribute mti_svvh_generic_type of CMD_BYTE : constant is 1;
end PCA9555;
