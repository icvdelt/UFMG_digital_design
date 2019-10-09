---------------------------------------------------------------------------
-- Universidade Federal de Minas Gerais (UFMG)
---------------------------------------------------------------------------
-- Project: Reed-Solomon Encoder
-- Design: RS Multiplier
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity rs_multiplier is
	generic (
        WORD_LENGTH : natural range 2 to 10;
        MULT_CONSTANT : natural range 0 to 2**WORD_LENGTH-1
    );
	port (
    	i : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end rs_multiplier;

architecture behavioral of rs_multiplier is
component rs_multiplier_lut is
    generic (
        WORD_LENGTH : natural range 2 to 10;
        MULT_CONSTANT : natural range 0 to 2**WORD_LENGTH-1
    );
    port (
    	i : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end component;

begin
MULT_LUT: rs_multiplier_lut 
          generic map (WORD_LENGTH, MULT_CONSTANT) 
          port map (i,
                    o);
end behavioral;
