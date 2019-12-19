library IEEE;
use IEEE. STD_LOGIC_1164.all;

entity testbench_dec is
end testbench_dec;

architecture dataflow_tbd of testbench_dec is
	
	component decrementer is
		generic (
			NUMBER_OF_BITS : natural := 4);
	
		port (
			input : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			output : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			carry_out : out std_logic);
	
	end component;
	
	signal output, input : std_logic_vector (3 downto 0);
	signal carry_out : std_logic;

	begin
		
		DEC0 : decrementer port map (
			input => input,
			output => output,
			carry_out => carry_out);
		
		input <= "0000", "0001" after 70 ns, "1111" after 130 ns, "0010" after 200 ns, "1110" after 270 ns, "0011" after 330 ns, "1100" after 400 ns, "0100" after 470 ns, "1101" after 530 ns, "1010" after 600 ns, "1011" after 670 ns, "0110" after 730 ns, "1001" after 800 ns, "0111" after 870 ns, "0101" after 930 ns, "1000" after 990 ns;
		
end dataflow_tbd;