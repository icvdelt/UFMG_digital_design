library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.NUMERIC_STD.all;
library work;
use work.RS_CONSTANTS.gp_inverse_2;
use work.RS_CONSTANTS.gp_inverse_3;
use work.RS_CONSTANTS.gp_inverse_4;
use work.RS_CONSTANTS.gp_inverse_5;
use work.RS_CONSTANTS.gp_inverse_6;
use work.RS_CONSTANTS.gp_inverse_7;
use work.RS_CONSTANTS.gp_inverse_8;
use work.RS_CONSTANTS.gp_inverse_9;
use work.RS_CONSTANTS.gp_inverse_10;

entity rs_inverse is
    generic (
        WORD_LENGTH : natural range 2 to 10
    );
    port (
    	i : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end rs_inverse;

architecture lut of rs_inverse is
begin
    MULT_LUT: case WORD_LENGTH generate
        when 2 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_2(to_integer(unsigned(i))), WORD_LENGTH));
        when 3 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_3(to_integer(unsigned(i))), WORD_LENGTH));
        when 4 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_4(to_integer(unsigned(i))), WORD_LENGTH));
        when 5 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_5(to_integer(unsigned(i))), WORD_LENGTH));
        when 6 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_6(to_integer(unsigned(i))), WORD_LENGTH));
        when 7 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_7(to_integer(unsigned(i))), WORD_LENGTH));
        when 8 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_8(to_integer(unsigned(i))), WORD_LENGTH));
        when 9 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_9(to_integer(unsigned(i))), WORD_LENGTH));
        when 10 =>
            o <= std_logic_vector(to_unsigned(gp_inverse_10(to_integer(unsigned(i))), WORD_LENGTH));
        when others => 
            o <= (others => '0');
    end generate;
end architecture;
