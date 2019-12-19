library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench_comp is
end testbench_comp;

architecture dataflow_tbc of testbench_comp is
    	
      component comparator is
			generic (
				NUMBER_OF_BITS_PER_INPUT : natural := 4);
			port (
--				en : in std_logic;
				i_ref : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
				i_data : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
				gt : out std_logic;
				lt : out std_logic;
				eq : out std_logic);
		end component;
      
		signal i_ref, i_data : std_logic_vector (3 downto 0);
		signal gt, lt, eq : std_logic;
        
      begin
			COMP0 : comparator port map (
--				en => en,
				i_ref => i_ref,
				i_data => i_data,
				eq => eq,
				lt => lt,
				gt => gt);
				
--			en <= '0', '1' after 105001 ps, '0' after 185001 ps, '1' after 205001 ps, '0' after 325001 ps, '1' after 405001 ps, '0' after 425001 ps, '1' after 705001 ps, '0' after 965001 ps;
			i_ref <= "0000", "0001" after 105001 ps, "0100" after 125001 ps, "0111" after 145001 ps, "1001" after 165001 ps, "1111" after 185001 ps, "0010" after 205001 ps, "0101" after 225001 ps, "1000" after 245001 ps, "1010" after 265001 ps, "0011" after 285001 ps, "0110" after 305001 ps, "1111" after 405001 ps;
         i_data <= "0000", "0001" after 105001 ps, "0010" after 125001 ps, "0011" after 145001 ps, "0100" after 165001 ps, "0101" after 285001 ps, "0110" after 305001 ps, "0111" after 425001 ps, "1000" after 545001 ps, "1001" after 665001 ps, "1010" after 785001 ps, "1011" after 805001 ps, "1100" after 905001 ps;
         
end dataflow_tbc;