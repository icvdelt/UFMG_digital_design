---------------------------------------------------------------------------
-- Universidade Federal de Minas Gerais (UFMG)
---------------------------------------------------------------------------
-- Project: Reed-Solomon Decode
-- Design: RS Forney
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.GENERIC_COMPONENTS.no_rst_dff;
use work.GENERIC_TYPES.std_logic_vector_array;
use work.RS_COMPONENTS.rs_adder;
use work.RS_COMPONENTS.rs_inverse;
use work.RS_COMPONENTS.rs_multiplier;
use work.RS_COMPONENTS.rs_full_multiplier;
use work.RS_FUNCTIONS.get_pow;

entity rs_forney is
    generic (
        WORD_LENGTH : natural range 2 to 10;
        T : natural range 1 to (2**WORD_LENGTH-2)
    );
    port (
        clk : in std_logic;
	    i_has_error : in std_logic;
	    i_select_input : in std_logic;
	    i_derivative : in std_logic_vector(WORD_LENGTH-1 downto 0);	
        i_terms : in std_logic_vector_array(T-1 downto 0)(WORD_LENGTH-1 downto 0);
	    o_symbol_correction : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end rs_forney;

architecture behavioral of rs_forney is
    constant word_zero : std_logic_vector(WORD_LENGTH-1 downto 0) := (others => '0');
    signal w_inverter : std_logic_vector(WORD_LENGTH-1 downto 0);
    signal w_full_mult : std_logic_vector(WORD_LENGTH-1 downto 0);
    signal w_selector : std_logic_vector_array(T-1 downto 0)(WORD_LENGTH-1 downto 0);
    signal w_multiplier : std_logic_vector_array(T-1 downto 0)(WORD_LENGTH-1 downto 0);
    signal r_flop : std_logic_vector_array(T-1 downto 0)(WORD_LENGTH-1 downto 0);
    signal w_adder : std_logic_vector_array(T-1 downto 0)(WORD_LENGTH-1 downto 0);
begin
    GEN_rs_forney_UNIT: for I in 0 to T-1 generate
    begin
        w_selector(I) <= i_terms(I) when i_select_input else r_flop(I);
        MULTIPLIER: rs_multiplier
                --create afunction that return this operation that is inside the galois fiels.
                    generic map (WORD_LENGTH => WORD_LENGTH,
                                MULT_CONSTANT => get_pow(WORD_LENGTH, I))
                    port map (i => w_selector(I), 
                              o => w_multiplier(I));
        D_FLOP: no_rst_dff 
                generic map (WORD_LENGTH => WORD_LENGTH) 
                port map (clk => clk,
                          d => w_multiplier(I),
                          q => r_flop(I));
        GEN_ADDER: if  I = 1 generate 
                ADDER: rs_adder 
                    generic map (WORD_LENGTH => WORD_LENGTH)
                    port map (i1 => r_flop(I-1),
                              i2 => r_flop(I),
                              o => w_adder(0));
        elsif I > 1 generate
                ADDER: rs_adder 
                    generic map (WORD_LENGTH => WORD_LENGTH)
                    port map (i1 => w_adder(I-2),
                              i2 => r_flop(I),
                              o =>  w_adder(I-1));
        end generate;
    end generate;
    INVERTER: rs_inverse
              generic map(WORD_LENGTH => WORD_LENGTH)
              port map(i => i_derivative,
                       o => w_inverter);
    FULL_MULT: rs_full_multiplier
               generic map(WORD_LENGTH => WORD_LENGTH)
               port map(i1 => w_inverter,
                        i2 => w_adder(T-2),
                        o => w_full_mult);
    o_symbol_correction <= w_full_mult when i_has_error else word_zero;
end behavioral;
