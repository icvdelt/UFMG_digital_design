library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity adder is
	generic (
		NUMBER_OF_BITS_PER_INPUT : natural := 4);
	port (
		en : in std_logic;
		i_operand_0 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		i_operand_1 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		o_result : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		o_carry : out std_logic);
end adder;

architecture bh_add of adder is
	signal output : std_logic_vector (NUMBER_OF_BITS_PER_INPUT downto 0);
	begin
		output <= std_logic_vector (to_unsigned(to_integer (unsigned (i_operand_0)) + to_integer (unsigned (i_operand_1)), NUMBER_OF_BITS_PER_INPUT + 1));
		o_result <= output ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0) when en = '1' else
						(others => '0');
		o_carry <= output (NUMBER_OF_BITS_PER_INPUT) when en = '1' else
					  '0';
end bh_add;