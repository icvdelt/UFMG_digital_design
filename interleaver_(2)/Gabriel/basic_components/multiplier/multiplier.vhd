library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity multiplier is
	generic (
		NUMBER_OF_BITS_PER_INPUT : natural := 4);
	port (
		en : in std_logic;
		i_operand_0 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		i_operand_1 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		o_low : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		o_high : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0));
end multiplier;

architecture bh_mult of multiplier is
	signal output : std_logic_vector ((2 * NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
	begin
		output <= std_logic_vector (to_unsigned(to_integer (unsigned (i_operand_0)) * to_integer (unsigned (i_operand_1)), (2 * NUMBER_OF_BITS_PER_INPUT)));
		o_low <= output ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0) when (en = '1') else
					(others => '0');
		o_high <= output ((2 * NUMBER_OF_BITS_PER_INPUT - 1) downto (NUMBER_OF_BITS_PER_INPUT)) when (en = '1') else
					 (others => '0');
end bh_mult;