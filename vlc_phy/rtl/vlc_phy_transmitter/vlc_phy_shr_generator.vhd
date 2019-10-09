library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity vlc_phy_shr_generator is
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_sync_shr : in std_logic;
        i_valid : in std_logic;
        i_tdp_mod : in std_logic_vector(1 downto 0);
        i_flp_size : in std_logic_vector(15 downto 0);
        o_bit : out std_logic;
        o_valid : out std_logic);
end vlc_phy_shr_generator;

architecture behavioral of vlc_phy_shr_generator is
begin
end behavioral;