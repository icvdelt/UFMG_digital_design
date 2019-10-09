library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
library work;
use work.GENERIC_COMPONENTS.async_dff;
use work.VLC_PHY_COMPONENTS.vlc_phy_rs_encoder_control;

entity vlc_phy_tx_data_path_control is
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
end vlc_phy_tx_data_path_control;

architecture behavioral of vlc_phy_tx_data_path_control is
    --configuration register signals
    signal w_wr_config_register : std_logic;
    signal w_config_register_mcs_id_data : std_logic_vector(MCS_ID_SIZE-1 downto 0);
    signal w_config_register_frame_size : std_logic_vector(FRAME_SIZE_LENGTH-1 downto 0);

    --CONFIG_REGISTER_MCS_ID outputs
    signal r_config_register_mcs_id : std_logic_vector(MCS_ID_SIZE-1 downto 0);

    --CONFIG_REGISTER_FRAME_SIZE outputs
    signal r_config_register_frame_size : std_logic_vector(FRAME_SIZE_LENGTH-1 downto 0);

    --VLC_PHY_RS_ENCODER_CONTROL_INST signals
    signal w_valid_rs_input : std_logic;
    signal w_is_input_buffer_read_by_rs_encoder : std_logic;

    signal w_consume_input_buffer : std_logic;

    signal w_in_sync_frame_ready : std_logic;
    signal w_in_tx_data_ready : std_logic;
begin
    w_wr_config_register <= i_sync_frame and w_in_sync_frame_ready;

    w_config_register_mcs_id_data <= i_mcs_id when w_wr_config_register else r_config_register_mcs_id;
    CONFIG_REGISTER_MCS_ID : async_dff
                             generic map (WORD_LENGTH => MCS_ID_SIZE)
                             port map (clk => clk,
                                       rst => rst,
                                       d => w_config_register_mcs_id_data,
                                       q => r_config_register_mcs_id);

    w_config_register_frame_size <= i_tx_frame_size when w_wr_config_register else r_config_register_frame_size;
    CONFIG_REGISTER_FRAME_SIZE : async_dff
                                 generic map (WORD_LENGTH => FRAME_SIZE_LENGTH)
                                 port map (clk => clk,
                                           rst => rst,
                                           d => w_config_register_frame_size,
                                           q => r_config_register_frame_size);

    --comb. logic for input_buffer_wr_en
    o_input_buffer_wr_en <= i_tx_data_valid and not i_input_buffer_full and w_in_tx_data_ready and w_in_tx_data_ready;

    --comb. logic for input_buffer_wr_en
    w_consume_input_buffer <= i_rs_encoder_set_in_ready when w_is_input_buffer_read_by_rs_encoder else '1';
    o_input_buffer_rd_en <= not i_input_buffer_empty and w_consume_input_buffer;

    w_valid_rs_input <= i_rs_encoder_set_in_ready and not i_input_buffer_empty and w_is_input_buffer_read_by_rs_encoder;
    VLC_PHY_RS_ENCODER_CONTROL_INST : vlc_phy_rs_encoder_control
                                      generic map (NUMBER_OF_VLC_PHY_RS_CODECS => NUMBER_OF_VLC_PHY_RS_CODECS,
                                                   I_FRAME_SIZE_LENGTH => FRAME_SIZE_LENGTH)
                                       port map (clk => clk,
                                                 rst => rst,
                                                 i_sync_frame => i_sync_frame,
                                                 i_valid_rs_input => w_valid_rs_input,
                                                 i_frame_size => i_tx_frame_size,
                                                 o_rs_encoder_end_codeword => o_rs_encoder_i_end_codeword,
                                                 o_rs_encoder_start_codeword => o_rs_encoder_i_start_codeword); 
end behavioral;
