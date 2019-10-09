library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity vlc_phy_convolutional_encoder_puncture is
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(2 downto 0);
        i_mcs_id : in std_logic_vector(5 downto 0);
        o_valid : out std_logic;
        o_data : out std_logic_vector(3 downto 0)
    );
end vlc_phy_convolutional_encoder_puncture;

architecture behavioral of vlc_phy_convolutional_encoder_puncture is
begin
end behavioral;
