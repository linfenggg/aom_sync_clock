library verilog;
use verilog.vl_types.all;
entity burst is
    generic(
        DLY_MAX         : integer := 1023;
        END_MAX         : integer := 8
    );
    port(
        clk_i           : in     vl_logic;
        rstn_i          : in     vl_logic;
        EXT_TRIG        : in     vl_logic;
        BST_NUM         : in     vl_logic_vector(3 downto 0);
        BST_PERIOD      : in     vl_logic_vector(15 downto 0);
        BST_DLY         : in     vl_logic_vector(7 downto 0);
        FREQ_DIV_NUM    : in     vl_logic_vector(23 downto 0);
        AOM_CTRL_SEL    : in     vl_logic_vector(3 downto 0);
        SEED_SYNC_AOM1  : in     vl_logic;
        BST_SEL         : in     vl_logic;
        BST_PUL_NUM     : in     vl_logic_vector(4 downto 0);
        TRIG_PRE        : in     vl_logic_vector(7 downto 0);
        PROT_FREQ       : in     vl_logic_vector(7 downto 0);
        BURST_DATA1     : in     vl_logic_vector(7 downto 0);
        BURST_DATA2     : in     vl_logic_vector(7 downto 0);
        BURST_DATA3     : in     vl_logic_vector(7 downto 0);
        BURST_DATA4     : in     vl_logic_vector(7 downto 0);
        BURST_DATA5     : in     vl_logic_vector(7 downto 0);
        BURST_DATA6     : in     vl_logic_vector(7 downto 0);
        BURST_DATA7     : in     vl_logic_vector(7 downto 0);
        BURST_DATA8     : in     vl_logic_vector(7 downto 0);
        BURST_DATA9     : in     vl_logic_vector(7 downto 0);
        BURST_DATA10    : in     vl_logic_vector(7 downto 0);
        TTL_DIV         : out    vl_logic;
        TTL_tem         : out    vl_logic;
        AOM2_EXP        : out    vl_logic;
        FIBER_AOM_DATA  : out    vl_logic_vector(7 downto 0);
        FIBER_AOM_CLK   : out    vl_logic;
        FIBER_AOM_TTL   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DLY_MAX : constant is 1;
    attribute mti_svvh_generic_type of END_MAX : constant is 1;
end burst;
