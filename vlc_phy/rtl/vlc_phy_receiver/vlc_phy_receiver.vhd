library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_FUNCTIONS.get_word_length;

entity vlc_phy_receiver is
    generic (
        PHY_TYPE : PhyType := PHY_I;
        MCS_ID_SIZE : integer := 6;
        WORD_LENGTH : integer := get_word_length(OPTICAL_CLOCK)
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_bit : in std_logic;
        i_rx_listen : in std_logic;
        i_rx_mcs_id : in std_logic_vector(MCS_ID_SIZE-1 downto 0);
        o_rx_error : out std_logic;
        o_rx_valid : out std_logic;
        o_rx_symbol : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end vlc_phy_receiver;

architecture behavioral of vlc_phy_receiver is
begin

end behavioral;