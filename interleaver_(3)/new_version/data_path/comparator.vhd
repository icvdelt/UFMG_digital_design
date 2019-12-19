library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity comparator is
	generic (
		NUMBER_OF_BITS_PER_INPUT : natural);
	port (
--		en : in std_logic;
		i_ref : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		i_data : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		lt : out std_logic;
		eq : out std_logic);
end comparator;

architecture bh_comp of comparator is
	begin
		lt <= '1' when ((to_integer (unsigned (i_data))) < (to_integer (unsigned (i_ref)))) else --Sets if less than.
				'0';
		eq <= '1' when ((to_integer (unsigned (i_data))) = (to_integer (unsigned (i_ref)))) else	--Sets if equal to.
				'0';
end bh_comp;