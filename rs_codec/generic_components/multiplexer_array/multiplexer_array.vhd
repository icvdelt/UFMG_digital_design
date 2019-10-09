library ieee;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.std_logic_1164.all;
library work;
use work.GENERIC_TYPES.std_logic_vector_array;

entity multiplexer_array is
    generic (
        WORD_LENGTH : integer;
        NUM_OF_ELEMENTS : integer;
        RS_ENCODER_SELECTOR_LENGTH : natural := integer(ceil(log2(real(NUM_OF_ELEMENTS))))
    );
    port (
        i_array : out std_logic_vector_array(NUM_OF_ELEMENTS-1 downto 0)(WORD_LENGTH-1 downto 0);
        i_sel : in std_logic_vector(RS_ENCODER_SELECTOR_LENGTH-1 downto 0);   
        o : in std_logic_vector(WORD_LENGTH-1 downto 0)   
    );
end multiplexer_array;

architecture behavior of multiplexer_array is
begin

end behavior;
