library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux_2x1 is
	generic (
		NUMBER_OF_BITS_PER_INPUT : natural := 4);
	port (
--		en : in std_logic;
		i_index : in std_logic;
		i_data_0 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		i_data_1 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
		o_data : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0));
end mux_2x1;

architecture bh_m2x1 of mux_2x1 is
	begin
		o_data <= i_data_0 when (i_index = '0') else
					 i_data_1 when (i_index = '1') else
					 (others => '0');
end bh_m2x1;