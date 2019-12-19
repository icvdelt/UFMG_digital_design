library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity incrementer is
	generic (
	NUMBER_OF_BITS : natural := 4);
	
	port (
	input : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
	output : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
	carry_out : out std_logic);

end incrementer;

architecture dataflow_inc of incrementer is
	
	signal wire : std_logic_vector (NUMBER_OF_BITS downto 0);
	
	component half_adder_unit is
		port (
			input : in std_logic;
			c_in : in std_logic;
			output : out std_logic;
			c_out : out std_logic
		);
	end component;
	
	begin
	
		GENERATE_HALF_ADDER_UNITS : for it0 in 0 to (NUMBER_OF_BITS - 1) generate	--Generates multiple basic units according to the number of bits.
			HAUX : half_adder_unit port map (
			input => input (it0),
			c_in => wire (it0),
			output => output (it0),
			c_out => wire (it0 + 1));		
		end generate;
		
		wire (0) <= '1';
		carry_out <= wire (NUMBER_OF_BITS);
		
end dataflow_inc;