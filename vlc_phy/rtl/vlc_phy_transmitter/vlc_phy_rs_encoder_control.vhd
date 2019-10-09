library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.VLC_PHY_FUNCTIONS.get_max_rs_galois_field;

entity vlc_phy_rs_encoder_control is
  generic (
    NUMBER_OF_VLC_PHY_RS_CODECS : natural;
    I_FRAME_SIZE_LENGTH : natural
  );
  port (
    clk : in std_logic;
    rst : in std_logic;
    i_sync_frame : in  std_logic;
    i_valid_rs_input : in std_logic;
    i_frame_size : in std_logic_vector(I_FRAME_SIZE_LENGTH-1 downto 0);
    o_rs_encoder_end_codeword : out std_logic;
    o_rs_encoder_start_codeword : out std_logic
  );
end vlc_phy_rs_encoder_control;
 
architecture behavioral of vlc_phy_rs_encoder_control is
begin
end behavioral;
