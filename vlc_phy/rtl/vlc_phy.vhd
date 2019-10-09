library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.VLC_PHY_FUNCTIONS.get_word_length;
use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_COMPONENTS.vlc_phy_transmitter;

entity vlc_phy is
    generic (
        PHY_TYPE : PhyType := PHY_I;
        MCS_ID_SIZE : integer := 6;
        WORD_LENGTH : integer := get_word_length(OPTICAL_CLOCK)
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_rx_bit : in std_logic;
        i_rx_listen : in std_logic;
        i_tx_end_frame : in std_logic;
        i_tx_valid : in std_logic;
        i_rx_mcs_id : in std_logic_vector(MCS_ID_SIZE-1 downto 0);
        i_tx_mcs_id : in std_logic_vector(MCS_ID_SIZE-1 downto 0);
        i_tx_symbol : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_rx_error : out std_logic;
        o_rx_valid : out std_logic;
        o_tx_bit : out std_logic;
        o_rx_symbol : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end vlc_phy;

architecture behavioral of vlc_phy is
begin

VLC_PHY_TX_INST : vlc_phy_transmitter
                  generic map (PHY_TYPE => PHY_TYPE)
                  port map (clk => clk,
                            rst => rst,
                            i_tx_end_frame => i_tx_end_frame,
                            i_tx_valid => i_tx_valid,
                            i_tx_mcs_id => i_tx_mcs_id,
                            i_tx_symbol => i_tx_symbol,
                            o_tx_bit => o_tx_bit);
end behavioral;