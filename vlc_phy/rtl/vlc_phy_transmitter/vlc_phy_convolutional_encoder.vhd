library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.GENERIC_TYPES.array_of_integers;
use work.CONVOLUTIONAL_ENCODER_COMPONENTS.convolutional_encoder;
use work.VLC_PHY_COMPONENTS.vlc_phy_convolutional_encoder_puncture;

entity vlc_phy_convolutional_encoder is
    generic (
        CASCADE_LENGTH : natural;
        RATE : natural;
        GENERATOR_POLY : array_of_integers
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_data : in std_logic;
        i_valid : in std_logic;
        i_mcs_id : in std_logic_vector(5 downto 0);
        o_valid : out std_logic;
        o_data : out std_logic_vector(3 downto 0)
    );
end vlc_phy_convolutional_encoder;
 
architecture behavioral of vlc_phy_convolutional_encoder is

signal w_convolutional_encoder_data : std_logic_vector(2 downto 0);
signal w_convolutional_encoder_valid : std_logic;

begin
    COVOLUTIONAL_CODE_INST : convolutional_encoder
                             generic map (CASCADE_LENGTH => CASCADE_LENGTH,
                                          RATE => RATE,
                                          GENERATOR_POLY => GENERATOR_POLY)
                             port map (clk => clk,
                                       rst => rst,
                                       i_data => i_data,
                                       i_valid => i_valid,
                                       o_data => w_convolutional_encoder_data,
                                       o_valid => w_convolutional_encoder_valid);
    
    VLC_PHY_CONVOLUTIONAL_ENCODER_PUNCTURE_INST : vlc_phy_convolutional_encoder_puncture
                                                  port map (clk => clk,
                                                            rst => rst,
                                                            i_valid => w_convolutional_encoder_valid,
                                                            i_data => w_convolutional_encoder_data,
                                                            i_mcs_id => i_mcs_id,
                                                            o_valid => o_valid,
                                                            o_data => o_data);
end behavioral;