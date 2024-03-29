library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench_reg is
end testbench_reg;

architecture dataflow_tbreg of testbench_reg is
    	
      component reg is
			generic (
				NUMBER_OF_BITS : natural := 4);
			port (
				rst : in std_logic;
				clk : in std_logic;
				ld : in std_logic;
				i_data : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
				o_data : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0));
		end component;
      
		signal i_data, o_data : std_logic_vector (3 downto 0);
		signal clk, rst, ld : std_logic;
        
      begin
			REG0 : reg port map (
				clk => clk,
				rst => rst,
				ld => ld,
				i_data => i_data,
				o_data => o_data);
				
			
			rst <= '1', '0' after 45001 ps, '1' after 505001 ps, '0' after 605001 ps;
			ld <= '0', '1' after 105001 ps, '0' after 185001 ps, '1' after 205001 ps, '0' after 325001 ps, '1' after 405001 ps, '0' after 425001 ps, '1' after 705001 ps, '0' after 965001 ps;
			i_data <= "0000", "0001" after 105001 ps, "0100" after 125001 ps, "0111" after 145001 ps, "1001" after 165001 ps, "1111" after 185001 ps, "0010" after 205001 ps, "0101" after 225001 ps, "1000" after 245001 ps, "1010" after 265001 ps, "0011" after 285001 ps, "0110" after 305001 ps, "1111" after 405001 ps;
         
			pulse : process
				begin
					clk <= '0';
					wait for 5 ns;
					clk <= '1';
					wait for 10 ns;
					clk <= '0';
					wait for 5 ns;
			end process;
			
end dataflow_tbreg;