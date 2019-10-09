library IEEE;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.std_logic_1164.all;

library work;
use work.GENERIC_TYPES.std_logic_vector_array;
use work.GENERIC_COMPONENTS.generic_buffer;
use work.GENERIC_COMPONENTS.multiplexer_array;
use work.GENERIC_COMPONENTS.two_input_size_generic_buffer;

use work.VLC_PHY_COMPONENTS.vlc_phy_convolutional_encoder;
use work.VLC_PHY_COMPONENTS.vlc_phy_modulator;
use work.VLC_PHY_COMPONENTS.vlc_phy_rectangular_interleaver;
use work.VLC_PHY_COMPONENTS.vlc_phy_rll_code;
use work.VLC_PHY_COMPONENTS.vlc_phy_rs_encoder_set;
use work.VLC_PHY_COMPONENTS.vlc_phy_shr_generator;
use work.VLC_PHY_COMPONENTS.vlc_phy_tx_data_path_control;

use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_TYPES.rs_n_parameter;
use work.VLC_PHY_TYPES.rs_k_parameter;

use work.VLC_PHY_FUNCTIONS.get_frame_size_length;
use work.VLC_PHY_FUNCTIONS.get_num_of_rs_codecs;
use work.VLC_PHY_FUNCTIONS.get_rs_gf_length;
use work.VLC_PHY_FUNCTIONS.select_rll_input_from_mcs_id;

entity vlc_phy_transmitter is
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
end vlc_phy_transmitter;

architecture behavioral of vlc_phy_transmitter is

    --INPUT_8_TO_4_BUFFER outputs
    signal w_input_buffer_full : std_logic;
    signal w_input_buffer_data : std_logic_vector(WORD_LENGTH/2-1 downto 0);
    signal w_input_buffer_empty : std_logic;
    
    --VLC_PHY_RS_ENCODER_SET_INST outputs
    signal w_rs_encoder_set_o_end_codeword : std_logic;
    signal w_rs_encoder_set_o_start_codeword : std_logic;
    signal w_rs_encoder_set_error : std_logic;
    signal w_rs_encoder_set_in_ready : std_logic;
    signal w_rs_encoder_set_valid : std_logic;
    signal w_rs_encoder_set_symbol : std_logic_vector(WORD_LENGTH/2-1 downto 0);   

    --VLC_PHY_RECTANGULAR_INTERLEAVER_INST outputs
    signal w_interleaver_o_end_interleaver : std_logic;
    signal w_interleaver_error : std_logic;
    signal w_interleaver_o_start_interleaver : std_logic;
    signal w_interleaver_valid : std_logic;
    signal w_interleaver_data : std_logic_vector(WORD_LENGTH/2-1 downto 0);

    --VLC_PHY_INTERLEAVER_4_TO_1_BUFFER outputs
    signal w_4_to_1_buffer_empty : std_logic;
    signal w_4_to_1_buffer_full : std_logic;
    signal w_4_to_1_buffer_data : std_logic_vector(0 downto 0);

    --VLC_PHY_COVOLUTIONAL_CODE_INST outputs
    signal w_convolutional_encoder_data : std_logic_vector(3 downto 0);
    signal w_convolutional_encoder_valid : std_logic;

    signal w_multiplexer_array_input : std_logic_vector_array(2 downto 0)(4 downto 0);

    --RLL_MULTIPLEXER_INST outpurs
    signal w_rll_input : std_logic_vector(4 downto 0);

    --VLC_PHY_RLL_CODE_INST outputs
    signal w_rll_data : std_logic_vector(7 downto 0);
    signal w_rll_is_length_6_or_8 : std_logic;
    signal w_rll_valid : std_logic;

    --VLC o_in_ready status
    signal w_in_tx_data_ready : std_logic;
    signal w_in_sync_frame_ready : std_logic;

    signal w_rll_output_buffer_rd_en : std_logic;

    --VLC_PHY_RLL_CODE_6_8_TO_1_BUFFER outputs
    signal w_8_to_1_buffer_empty : std_logic;
    signal w_8_to_1_buffer_full : std_logic;
    signal w_8_to_1_buffer_data : std_logic_vector(0 downto 0);

    --VLC_PHY_SHR_GENERATOR_INST outputs
    signal w_vlc_phy_shr_data : std_logic;
    signal w_vlc_phy_shr_valid : std_logic;

    signal w_vlc_phy_mod_valid : std_logic;
    signal w_vlc_phy_mod_data : std_logic;
    signal w_rd_shr_data : std_logic;
    signal w_rd_output_buffer_data : std_logic;

    --VLC_PHY_MODULATOR_INST outputs
    signal w_mod_rd_tx_bit : std_logic;

    --VLC_PHY_TX_DATA_PATH_CONTROL_INST outputs
    signal w_i_end_interleaver : std_logic;
    signal w_i_start_interleaver : std_logic;
    signal w_input_buffer_wr_en : std_logic;
    signal w_input_buffer_rd_en : std_logic;
    signal w_rs_encoder_i_end_codeword : std_logic;
    signal w_rs_encoder_i_start_codeword : std_logic;
    signal w_rs_encoder_selector : std_logic_vector(RS_ENCODER_SELECTOR_LENGTH-1 downto 0);
    signal w_enable_end_interleaver : std_logic;
    signal w_enable_start_interleaver : std_logic;
    signal w_en_tx : std_logic;
    signal w_tx_frame : std_logic;
    signal w_mod_mode : std_logic;
    signal w_mcs_id : std_logic_vector(MCS_ID_SIZE-1 downto 0);
    signal w_rll_multiplexer_selector : std_logic_vector(1 downto 0);

begin

    INPUT_8_TO_4_BUFFER : generic_buffer
                          generic map (INPUT_LENGTH => 8,
                                       OUTPUT_LENGTH => 4,
                                       MEMORY_BIT_SIZE => 2026*4)
                          port map (clk => clk,
                                    rst => rst,
                                    i_rd_en => w_input_buffer_rd_en,
                                    i_wr_en => w_input_buffer_wr_en,
                                    i_wr_data => i_tx_data,
                                    o_empty_buffer => w_input_buffer_empty,
                                    o_full_buffer => w_input_buffer_full,
                                    o_rd_data => w_input_buffer_data);

    VLC_PHY_RS_ENCODER_SET_INST : vlc_phy_rs_encoder_set
                                  generic map (PHY_TYPE => PHY_TYPE)
                                  port map (clk => clk,
                                            rst => rst,      
                                            i_end_codeword => w_rs_encoder_i_end_codeword,
                                            i_start_codeword => w_rs_encoder_i_start_codeword,
                                            i_valid => not w_input_buffer_empty,
                                            i_symbol => w_input_buffer_data,
                                            i_encoder_selector => w_rs_encoder_selector,
                                            o_end_codeword => w_rs_encoder_set_o_end_codeword,
                                            o_error => w_rs_encoder_set_error,
                                            o_in_ready => w_rs_encoder_set_in_ready,
                                            o_start_codeword => w_rs_encoder_set_o_start_codeword,
                                            o_valid => w_rs_encoder_set_valid,
                                            o_symbol => w_rs_encoder_set_symbol);

    w_i_end_interleaver <= w_rs_encoder_set_o_end_codeword and w_enable_end_interleaver;
    w_i_start_interleaver <= w_rs_encoder_set_o_start_codeword and w_enable_start_interleaver;

    VLC_PHY_RECTANGULAR_INTERLEAVER_INST : vlc_phy_rectangular_interleaver
                                           generic map (NUMBER_OF_ELEMENTS => 15345,
                                                        NUMBER_OF_LINES => 15,
                                                        WORD_LENGTH => 4)
                                           port map (clk => clk,
                                                     rst => rst,
                                                     i_consume => not w_4_to_1_buffer_full,
                                                     i_end_interleaver => w_i_end_interleaver,
                                                     i_start_interleaver => w_i_start_interleaver,
                                                     i_valid => w_rs_encoder_set_valid,
                                                     i_data => w_rs_encoder_set_symbol,
                                                     o_end_interleaver => w_interleaver_o_end_interleaver,
                                                     o_error => w_interleaver_error,
                                                     o_start_interleaver => w_interleaver_o_start_interleaver,
                                                     o_valid => w_interleaver_valid,
                                                     o_data => w_interleaver_data);

    VLC_PHY_INTERLEAVER_4_TO_1_BUFFER : generic_buffer
                                        generic map (INPUT_LENGTH => 4,
                                                     OUTPUT_LENGTH => 1,
                                                     MEMORY_BIT_SIZE => 8)
                                        port map (clk => clk,
                                                  rst => rst,
                                                  i_rd_en => not w_4_to_1_buffer_empty,
                                                  i_wr_en => w_interleaver_valid,
                                                  i_wr_data => w_interleaver_data,
                                                  o_empty_buffer => w_4_to_1_buffer_empty,
                                                  o_full_buffer => w_4_to_1_buffer_full,
                                                  o_rd_data => w_4_to_1_buffer_data);

    VLC_PHY_COVOLUTIONAL_CODE_INST : vlc_phy_convolutional_encoder
                                     generic map (CASCADE_LENGTH => 7,
                                                  RATE => 3,
                                                  GENERATOR_POLY => (133, 171, 165))
                                     port map (clk => clk,
                                               rst => rst,
                                               i_data => w_4_to_1_buffer_data(0),
                                               i_valid => not w_4_to_1_buffer_empty,
                                               i_mcs_id => w_mcs_id,
                                               o_data => w_convolutional_encoder_data,
                                               o_valid => w_convolutional_encoder_valid);
                
    w_multiplexer_array_input <= (w_input_buffer_data & not w_input_buffer_empty,
                                  w_rs_encoder_set_symbol & w_rs_encoder_set_valid,
                                  w_convolutional_encoder_data & w_convolutional_encoder_valid);

    RLL_MULTIPLEXER_INST : multiplexer_array
                           generic map (WORD_LENGTH => 5,
                                        NUM_OF_ELEMENTS => 3)
                           port map (i_array => w_multiplexer_array_input,
                                     i_sel => w_rll_multiplexer_selector,
                                     o => w_rll_input);

    VLC_PHY_RLL_CODE_INST : vlc_phy_rll_code
                            port map (i_mode => w_mod_mode,
                                      i_valid => w_rll_input(0),
                                      i_data => w_rll_input(4 downto 1),
                                      o_data => w_rll_data,
                                      o_is_length_6_or_8 => w_rll_is_length_6_or_8,
                                      o_valid => w_rll_valid);

    VLC_PHY_RLL_CODE_6_8_TO_1_BUFFER : two_input_size_generic_buffer
                          generic map (INPUT_1_LENGTH => 8,
                                       INPUT_2_LENGTH => 6,
                                       OUTPUT_LENGTH => 1,
                                       --?????????????
                                       NUM_OF_OUTPUT_ELEMENTS => 140320)
                          port map (clk => clk,
                                    rst => rst,
                                    i_data_length_selector => w_rll_is_length_6_or_8,
                                    i_rd_en => w_rll_output_buffer_rd_en,
                                    i_wr_en => w_rll_valid,
                                    i_wr_data => w_rll_data,
                                    o_empty_buffer => w_8_to_1_buffer_empty,
                                    o_full_buffer => o_tx_buffer_overflow,
                                    o_rd_data => w_8_to_1_buffer_data);    

    VLC_PHY_SHR_GENERATOR_INST : vlc_phy_shr_generator 
                                 port map(clk => clk,
                                          rst => rst,
                                          i_sync_shr => i_tx_frame,
                                          i_valid => w_tx_frame and w_mod_rd_tx_bit,
                                          i_tdp_mod => i_tdp_mod,
                                          i_flp_size => i_flp_size,
                                          o_bit => w_vlc_phy_shr_data,
                                          o_valid => w_vlc_phy_shr_valid);

    w_vlc_phy_mod_valid <= '0' when not w_tx_frame else 
                           '1' when w_vlc_phy_shr_valid else
                            not w_8_to_1_buffer_empty;

    w_vlc_phy_mod_data <= w_vlc_phy_shr_data when w_vlc_phy_shr_valid else w_8_to_1_buffer_data(0);

    w_rll_output_buffer_rd_en <= w_mod_rd_tx_bit when not w_vlc_phy_shr_valid else '0';
    
    VLC_PHY_MODULATOR_INST : vlc_phy_modulator
                             port map (clk => clk,
                                       rst => rst,
                                       i_optical_clk => i_optical_clk,
                                       i_tx_bit => w_vlc_phy_mod_data,
                                       i_mod_mode => w_mod_mode,
                                       i_valid => not w_vlc_phy_mod_valid,
                                       o_rd_tx_bit => w_mod_rd_tx_bit,
                                       o_tx_bit => o_tx_bit);

    VLC_PHY_TX_DATA_PATH_CONTROL_INST : vlc_phy_tx_data_path_control
                                        generic map(NUMBER_OF_VLC_PHY_RS_CODECS => NUMBER_OF_VLC_PHY_RS_ENCODERS,
                                                    FRAME_SIZE_LENGTH => FRAME_SIZE_LENGTH)
                                        port map(clk => clk,
                                                 rst => rst,          

                                                 i_error => w_interleaver_error and o_tx_buffer_overflow and w_rs_encoder_set_error, 
                                                 i_sync_frame => i_sync_frame,
                                                 i_tx_data_valid => i_tx_data_valid,
                                                 i_tx_frame => i_tx_frame,

                                                 i_input_buffer_empty => w_input_buffer_empty,
                                                 i_input_buffer_full => w_input_buffer_full,

                                                 i_rs_encoder_set_in_ready => w_rs_encoder_set_in_ready,
                                                 i_rs_encoder_set_o_end_codeword => w_rs_encoder_set_o_end_codeword,
                                                 i_rs_encoder_set_o_start_codeword => w_rs_encoder_set_o_start_codeword,

                                                 i_end_interleaver => w_interleaver_o_end_interleaver,
                                                 i_start_interleaver => w_interleaver_o_start_interleaver,

                                                 i_mcs_id => i_mcs_id,
                                                 i_tx_frame_size => i_tx_frame_size,

                                                 o_en_tx => w_en_tx,
                                                 o_in_sync_frame_ready => o_in_sync_frame_ready,
                                                 o_in_tx_data_ready => o_in_tx_data_ready,

                                                 o_input_buffer_wr_en => w_input_buffer_rd_en,
                                                 o_input_buffer_rd_en => w_input_buffer_wr_en,
                                                 
                                                 o_mod_mode => w_mod_mode,

                                                 o_rs_encoder_i_end_codeword => w_rs_encoder_i_end_codeword,
                                                 o_rs_encoder_i_start_codeword => w_rs_encoder_i_start_codeword,

                                                 o_enable_end_interleaver => w_enable_end_interleaver,
                                                 o_enable_start_interleaver => w_enable_start_interleaver,

                                                 o_tx_frame => w_tx_frame,
                                                 o_rll_multiplexer_selector => w_rll_multiplexer_selector,
                                                 o_mcs_id => w_mcs_id,

                                                 o_rs_encoder_selector => w_rs_encoder_selector);
end behavioral;
