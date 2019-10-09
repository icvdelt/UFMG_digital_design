library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity vlc_phy_ook is
    port (
      clk : in std_logic;
      rst : in std_logic;
      i_optical_clk : in  std_logic;
      i_send : in std_logic;
      i_bit : in std_logic;
      o_rd_tx_bit : out std_logic;
      o_bit : out std_logic
    );
end vlc_phy_ook;

architecture behavioral of vlc_phy_ook is
begin
end behavioral;