library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity half_subtractor_unit is

	port (
		input : in std_logic;
		c_in : in std_logic;
		output : out std_logic;
		c_out : out std_logic
	);

end half_subtractor_unit;

architecture dataflow_hsu of half_subtractor_unit is	
	begin
		
		c_out <= not (input) and c_in;	--Sets the carry out, depending on whether a 2 from the next bits is required.
		
		output <= input xor c_in;	--Sets the output, subtracting the carry in from the input.

end dataflow_hsu;