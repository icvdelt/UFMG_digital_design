library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
library work;
use work.GENERIC_TYPES.array_of_integers;
use work.VLC_PHY_TYPES.B2BType;
use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_FUNCTIONS.get_max_rs_galois_field;
use work.VLC_PHY_FUNCTIONS.get_frame_size_length;
use work.VLC_PHY_FUNCTIONS.get_num_of_rs_codecs;
use work.VLC_PHY_FUNCTIONS.get_rs_gf_length;

package VLC_PHY_COMPONENTS is

component vlc_phy_shr_generator is
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_sync_shr : in std_logic;
        i_valid : in std_logic;
        i_tdp_mod : in std_logic_vector(1 downto 0);
        i_flp_size : in std_logic_vector(15 downto 0);
        o_bit : out std_logic;
        o_valid : out std_logic);
end component;

component vlc_phy_convolutional_encoder_puncture is
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(2 downto 0);
        i_mcs_id : in std_logic_vector(5 downto 0);
        o_valid : out std_logic;
        o_data : out std_logic_vector(3 downto 0)
    );
end component;

component vlc_phy_tx_data_path_control is
    generic ( 
        NUMBER_OF_VLC_PHY_RS_CODECS : natural := 8;
        FRAME_SIZE_LENGTH : natural;
        --internal
        MCS_ID_SIZE : natural := 6;
        RS_ENCODER_SELECTOR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_VLC_PHY_RS_CODECS))))
    );
    port (
       clk : in std_logic;
       rst : in std_logic;
       i_error : in std_logic;

       i_sync_frame : in std_logic;
       i_tx_data_valid : in std_logic;
       i_tx_frame : in std_logic;

       i_input_buffer_empty : in std_logic;
       i_input_buffer_full : in std_logic;

       i_rs_encoder_set_in_ready : in std_logic;
       i_rs_encoder_set_o_end_codeword : in std_logic;
       i_rs_encoder_set_o_start_codeword : in std_logic;

       i_end_interleaver : in std_logic;
       i_start_interleaver : in std_logic;

       i_mcs_id : in std_logic_vector(MCS_ID_SIZE-1 downto 0);
       i_tx_frame_size : in std_logic_vector(FRAME_SIZE_LENGTH-1 downto 0);

       o_en_tx : out std_logic;
       o_in_sync_frame_ready : out std_logic;
       o_in_tx_data_ready : out std_logic;

       o_input_buffer_wr_en : out std_logic;
       o_input_buffer_rd_en : out std_logic;

       o_mod_mode : out std_logic;

       o_rs_encoder_i_end_codeword : out std_logic;
       o_rs_encoder_i_start_codeword : out std_logic;

       o_enable_end_interleaver : out std_logic;
       o_enable_start_interleaver : out std_logic;

       o_tx_frame : out std_logic;
       o_rll_multiplexer_selector : out std_logic_vector(1 downto 0);
       o_mcs_id : out std_logic_vector(MCS_ID_SIZE-1 downto 0);
       o_rs_encoder_selector : out std_logic_vector(RS_ENCODER_SELECTOR_LENGTH-1 downto 0)
    ); 
end component;

component manchester_rll_code is
    generic (
        NUM_OF_UNITS : natural range 1 to 10
    );
    port (
        i_data : in std_logic_vector(NUM_OF_UNITS-1 downto 0);
        o_data : out std_logic_vector(2*NUM_OF_UNITS-1 downto 0)
    );
end component;

component b_to_b_rll_code is
    generic (
        B2B_TYPE : B2BType
    );
    port (
        i_data : in std_logic_vector(3 downto 0);
        o_data : out std_logic_vector(5 downto 0)
    );
end component;

component vlc_phy_ook is
    port (
      clk : in std_logic;
      rst : in std_logic;
      i_optical_clk : in  std_logic;
      i_send : in std_logic;
      i_bit : in std_logic;
      o_rd_tx_bit : out std_logic;
      o_bit : out std_logic
    );
end component;

component vlc_phy_vppm is
    port (
      clk : in std_logic;
      rst : in std_logic;
      i_optical_clk : in  std_logic;
      i_send : in std_logic;
      i_bit : in std_logic;
      o_rd_tx_bit : out std_logic;
      o_bit : out std_logic
    );
end component;

component vlc_phy_modulator is
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
end component;

component vlc_phy_rll_code is
  port (
    i_mode : in  std_logic;
    i_valid : in std_logic;
    i_data : in std_logic_vector(3 downto 0);
    o_data : out std_logic_vector(7 downto 0);
    o_is_length_6_or_8 : out std_logic;
    o_valid : out std_logic
  );
end component;

component vlc_phy_convolutional_encoder is
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
end component;

component vlc_phy_rectangular_interleaver is
    generic (
        NUMBER_OF_ELEMENTS : natural;
        NUMBER_OF_LINES : natural range 1 to NUMBER_OF_ELEMENTS;
        WORD_LENGTH : natural;
        RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_consume : in std_logic;
        i_end_interleaver : in std_logic;
        i_start_interleaver : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end component;

component vlc_phy_rs_encoder_set is
    generic (
        --User definitions
        PHY_TYPE : PhyType := PHY_I;

        --Internal definitions
        NUMBER_OF_VLC_PHY_RS_ENCODERS : natural := get_num_of_rs_codecs(PHY_TYPE);
        RS_ENCODER_SELECTOR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_VLC_PHY_RS_ENCODERS))));
        WORD_LENGTH : natural := get_rs_gf_length(PHY_TYPE)
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_end_codeword : in  std_logic;
        i_start_codeword : in std_logic;
        i_valid : in std_logic;
        i_encoder_selector : in std_logic_vector(RS_ENCODER_SELECTOR_LENGTH-1 downto 0);
        i_symbol : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_end_codeword : out std_logic;
        o_error : out std_logic;
        o_in_ready : out std_logic;
        o_start_codeword : out std_logic;
        o_valid : out std_logic;
        o_symbol : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end component;

component vlc_phy_rs_encoder_control is
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
end component;

component vlc_phy_codeword_delimiter is
    generic (
        MAX_CODEWORD_SIZE : integer range 1 to 1024
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_consume_symbol : in std_logic;
        i_codeword_size : in integer range 0 to MAX_CODEWORD_SIZE;
        o_end_codeword : out std_logic;
        o_start_codeword : out std_logic
    );
end component;

component vlc_phy_transmitter is
    generic (
        --User definitions
        PHY_TYPE : PhyType := PHY_I;

        --Internal definitions
        FRAME_SIZE_LENGTH : natural := get_frame_size_length(PHY_TYPE);
        MCS_ID_SIZE : natural := 6;
        NUMBER_OF_VLC_PHY_RS_ENCODERS : natural := get_num_of_rs_codecs(PHY_TYPE);
        RS_ENCODER_SELECTOR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_VLC_PHY_RS_ENCODERS))));
        RS_GF_LENGTH : natural := get_rs_gf_length(PHY_TYPE);
        WORD_LENGTH : natural := 8
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_optical_clk : in std_logic;
        i_sync_frame : in std_logic;
        i_tx_data_valid : in std_logic;
        i_tx_frame : in std_logic;
        i_mcs_id : in std_logic_vector(MCS_ID_SIZE-1 downto 0);
        i_tdp_mod : in std_logic_vector(1 downto 0);
        i_flp_size : in std_logic_vector(15 downto 0);
        i_tx_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        i_tx_frame_size : in std_logic_vector(FRAME_SIZE_LENGTH-1 downto 0);
        o_in_sync_frame_ready : out std_logic;
        o_in_tx_data_ready : out std_logic;
        o_tx_buffer_overflow : out std_logic;
        o_tx_bit : out std_logic
    );
end component;

end package VLC_PHY_COMPONENTS;
