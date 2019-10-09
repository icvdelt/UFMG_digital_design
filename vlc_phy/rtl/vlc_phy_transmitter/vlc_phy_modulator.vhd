library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.VLC_PHY_COMPONENTS.vlc_phy_ook;
use work.VLC_PHY_COMPONENTS.vlc_phy_vppm;

entity vlc_phy_modulator is
    port (
      clk : in std_logic;
      rst : in std_logic;
      i_optical_clk : in  std_logic;
      i_valid : in std_logic;
      i_tx_bit : in std_logic;
      i_mod_mode : in std_logic;
      o_rd_tx_bit : out std_logic;
      o_tx_bit : out std_logic
    );
end vlc_phy_modulator;

architecture behavioral of vlc_phy_modulator is
    signal w_ook_send : std_logic;
    signal w_vppm_send : std_logic;
    signal w_ook_rd_tx_bit : std_logic;
    signal w_ook_tx_bit : std_logic;
    signal w_vppm_rd_tx_bit : std_logic;
    signal w_vppm_tx_bit : std_logic;
begin

    w_ook_send <= i_valid when not i_mod_mode else '0';
    VLC_PHY_OOK_INST : vlc_phy_ook
                       port map (clk => i_optical_clk,
                                 rst => rst,
                                 i_optical_clk => i_optical_clk,
                                 i_send => w_ook_send,
                                 i_bit => i_tx_bit,
                                 o_rd_tx_bit => w_ook_rd_tx_bit,
                                 o_bit => w_ook_tx_bit);

    w_vppm_send <= i_valid when not i_mod_mode else '0';
    VLC_PHY_VPPM_INST : vlc_phy_vppm
                        port map (clk => clk,
                                  rst => rst,
                                  i_optical_clk => i_optical_clk,
                                  i_send => w_vppm_send,
                                  i_bit => i_tx_bit,
                                  o_rd_tx_bit => w_vppm_rd_tx_bit,
                                  o_bit => w_vppm_tx_bit);

    o_rd_tx_bit <= w_vppm_rd_tx_bit when i_mod_mode else w_ook_rd_tx_bit;
    o_tx_bit <= w_vppm_tx_bit when i_mod_mode else w_ook_tx_bit;

end behavioral;