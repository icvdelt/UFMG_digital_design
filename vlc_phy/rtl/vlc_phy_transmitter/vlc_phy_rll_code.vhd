library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.VLC_PHY_TYPES.B2BType;
use work.VLC_PHY_COMPONENTS.manchester_rll_code;
use work.VLC_PHY_COMPONENTS.b_to_b_rll_code;

entity vlc_phy_rll_code is
    port (
        i_mode : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(3 downto 0);
        o_data : out std_logic_vector(7 downto 0);
        o_is_length_6_or_8 : out std_logic;
        o_valid : out std_logic
    );
end vlc_phy_rll_code;
 
architecture behavioral of vlc_phy_rll_code is
    signal w_manchester_data : std_logic_vector(7 downto 0);
    signal w_4b6b_data : std_logic_vector(5 downto 0);
begin
    MANCHESTER_RLL_CODE_INST : manchester_rll_code
                               generic map (NUM_OF_UNITS => 4)
                               port map (i_data => i_data,
                                         o_data => w_manchester_data);

    B_TO_B_4B6B_RLL_CODE_INST : b_to_b_rll_code
                         generic map (B2B_TYPE => B2B_4b6b)
                         port map (i_data => i_data,
                                   o_data => w_4b6b_data);

    o_data <=  ("00" & w_4b6b_data) when i_mode else w_manchester_data;
    o_valid <= i_valid;
end behavioral;