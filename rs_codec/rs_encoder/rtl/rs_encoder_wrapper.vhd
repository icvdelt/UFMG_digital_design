---------------------------------------------------------------------------
-- Universidade Federal de Minas Gerais (UFMG)
---------------------------------------------------------------------------
-- Project: Reed-Solomon Encoder
-- Design: rs_encoder_wrapper
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
library WORK;
use WORK.RS_COMPONENTS.rs_encoder;
use WORK.RS_COMPONENTS.rs_syndrome_unit;
use work.GENERIC_TYPES.std_logic_vector_array;
use work.RS_TYPES.RSGFSize;
use work.RS_FUNCTIONS.get_word_length_from_rs_gf;

entity rs_encoder_wrapper is
	generic (
		N : natural range 2 to 1023;
		K : natural range 1 to N-1;
        RS_GF : RSGFSize := RS_GF_NONE;
		WORD_LENGTH : natural := get_word_length_from_rs_gf(N, RS_GF);
		TWO_TIMES_T : natural := N - K
   	);
	port (
		clk : in std_logic;
		rst : in std_logic;
		i_end_codeword : in std_logic;
		i_start_codeword : in std_logic;
		i_valid : in std_logic;
		i_symbol : in std_logic_vector(WORD_LENGTH-1 downto 0);
		o_end_codeword : out std_logic;
		o_error : out std_logic;
		o_in_ready : out std_logic;
		o_start_codeword : out std_logic;
		o_valid : out std_logic;
		o_symbol : out std_logic_vector(WORD_LENGTH-1 downto 0);
		o_syndrome : out std_logic_vector_array(TWO_TIMES_T-1 downto 0)(WORD_LENGTH-1 downto 0)
	);
end entity;

architecture behavior of rs_encoder_wrapper is
begin
	DUT: rs_encoder
		 generic map(N => N, 
		   			 K => K,
                     RS_GF => RS_GF)
		 port map(clk => clk,
				  rst => rst,
				  i_end_codeword => i_end_codeword,
				  i_start_codeword => i_start_codeword,
				  i_valid => i_valid,
			 	  i_symbol => i_symbol,
				  o_start_codeword => o_start_codeword,
			 	  o_end_codeword => o_end_codeword,
				  o_error => o_error,
				  o_in_ready => o_in_ready,
				  o_valid => o_valid,
				  o_symbol => o_symbol);

    RS_SYNDROME_UNIT_INST: rs_syndrome_unit
                           generic map(WORD_LENGTH => WORD_LENGTH, 
                                       TWO_TIMES_T => TWO_TIMES_T)
                           port map(clk => clk,
                                    rst => rst,
                                    i_select_feedback => not (o_start_codeword and o_valid),
                                    i_stall => not o_valid,
                                    i_symbol => o_symbol,
                                    o_syndrome => o_syndrome);   				  
end behavior;
