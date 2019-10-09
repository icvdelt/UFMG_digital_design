library IEEE;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.GENERIC_TYPES.std_logic_vector_array;
use work.GENERIC_COMPONENTS.demultiplexer_array;
use work.GENERIC_COMPONENTS.multiplexer_array;
use work.RS_COMPONENTS.rs_encoder;
use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_TYPES.rs_n_parameter;
use work.VLC_PHY_TYPES.rs_k_parameter;
use work.VLC_PHY_FUNCTIONS.get_num_of_rs_codecs;
use work.VLC_PHY_FUNCTIONS.get_rs_gf_length;

entity vlc_phy_rs_encoder_set is
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
        o_valid : out std_logic;
        o_start_codeword : out std_logic;
        o_symbol : out std_logic_vector(WORD_LENGTH-1 downto 0)
  );
end vlc_phy_rs_encoder_set;
 
architecture behavioral of vlc_phy_rs_encoder_set is
     signal w_rs_encoder_i_valid_vector : std_logic_vector_array(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0)(0 downto 0);
     signal w_rs_encoder_in_ready : std_logic_vector(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0);
     signal w_rs_encoder_o_start_codeword : std_logic_vector(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0);
     signal w_rs_encoder_o_end_codeword : std_logic_vector(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0);
     signal w_rs_encoder_in_error : std_logic_vector(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0);
     signal w_rs_encoder_o_valid : std_logic_vector(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0);
     signal w_rs_encoder_symbol : std_logic_vector_array(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0)(WORD_LENGTH-1 downto 0); 
     signal w_rs_encoder_outputs : std_logic_vector_array(NUMBER_OF_VLC_PHY_RS_ENCODERS-1 downto 0)(5+WORD_LENGTH-1 downto 0); 
     signal w_rs_selected_output : std_logic_vector(5+WORD_LENGTH-1 downto 0); 
begin
    RS_ENCODER_SET_SELECTOR_INST : demultiplexer_array
                                       generic map (WORD_LENGTH => 1,
                                                    NUM_OF_ELEMENTS => NUMBER_OF_VLC_PHY_RS_ENCODERS)
                                       port map (i(0) => i_valid,
                                                 i_sel => i_encoder_selector,
                                                 o_array => w_rs_encoder_i_valid_vector);

    GEN_RS_ENCODERS: for I in 0 to NUMBER_OF_VLC_PHY_RS_ENCODERS-1 generate
    	  RS_ENCODER_INST: rs_encoder
		                     generic map (N => rs_n_parameter(I), 
	                  	   	      		  K => rs_k_parameter(I))
	                	     port map (clk => clk,
	                    			       rst => rst,
	                    			       i_end_codeword => i_end_codeword,
	                    			       i_start_codeword => i_start_codeword,
	                    			       i_valid => w_rs_encoder_i_valid_vector(I)(0),
	                    		 	       i_symbol => i_symbol,            
	                    			       o_start_codeword => w_rs_encoder_o_start_codeword(I),
                      		 	       o_end_codeword => w_rs_encoder_o_end_codeword(I),
                      			       o_error => w_rs_encoder_in_error(I),
	                    			       o_in_ready => w_rs_encoder_in_ready(I),
	                    			       o_valid => w_rs_encoder_o_valid(I),
	                    			       o_symbol => w_rs_encoder_symbol(I));

        w_rs_encoder_outputs(I) <= w_rs_encoder_o_start_codeword(I) &
                                   w_rs_encoder_o_end_codeword(I) &
                                   w_rs_encoder_in_error(I) &
                                   w_rs_encoder_in_ready(I) &
                                   w_rs_encoder_o_valid(I) &
                                   w_rs_encoder_symbol(I);
    end generate GEN_RS_ENCODERS;
    RS_ENCODER_SET_MULTIPLEXER_INST : multiplexer_array
                                      generic map (WORD_LENGTH => WORD_LENGTH+5,
                                                    NUM_OF_ELEMENTS => NUMBER_OF_VLC_PHY_RS_ENCODERS)
                                      port map (i_array => w_rs_encoder_outputs,
                                                i_sel => i_encoder_selector,
                                                o => w_rs_selected_output);
    o_start_codeword <= w_rs_selected_output(5+WORD_LENGTH-1);
    o_end_codeword <= w_rs_selected_output(5+WORD_LENGTH-2);
    o_error <= w_rs_selected_output(5+WORD_LENGTH-3);
    o_in_ready <= w_rs_selected_output(5+WORD_LENGTH-4);
    o_valid <= w_rs_selected_output(5+WORD_LENGTH-5);
    o_symbol <= w_rs_selected_output(WORD_LENGTH-1 downto 0);
end behavioral;
