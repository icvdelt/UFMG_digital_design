library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity testbench_ri is
end testbench_ri;

architecture dataflow_tbri of testbench_ri is
    	
      component rectangular_interleaver is
			generic (
				NUMBER_OF_ELEMENTS : natural := 15;
				NUMBER_OF_LINES : natural range 1 to 15 := 4;
				WORD_LENGTH : natural := 4;
				RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(15))))
			);
			port (
			
--				o_filled : out std_logic;
--				o_memory : out std_logic_vector ((WORD_LENGTH * NUMBER_OF_ELEMENTS - 1) downto 0);
			
				clk : in std_logic;
				rst : in std_logic;
				i_consume : in std_logic;
				i_end_interleaver : in std_logic;
				i_start_interleaver : in std_logic;
				i_valid : in std_logic;
				i_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
				o_end_interleaver : out std_logic;
				o_error : out std_logic;
				o_in_ready : out std_logic;
				o_start_interleaver : out std_logic;
				o_valid : out std_logic;
				o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
			);
		end component;
      
--		signal o_memory : std_logic_vector (59 downto 0);
		signal i_data, o_data : std_logic_vector (3 downto 0);
		signal clk, rst, i_consume, i_end_interleaver, i_start_interleaver, i_valid, o_end_interleaver, o_error, o_in_ready, o_start_interleaver, o_valid : std_logic;
--		signal filled : std_logic;
        
      begin
			RI0 : rectangular_interleaver port map (
			
--				o_filled => filled,
--				o_memory => o_memory,
			
				clk => clk,
				rst => rst,
				i_consume => i_consume,
				i_end_interleaver => i_end_interleaver,
				i_start_interleaver => i_start_interleaver,
				i_valid => i_valid,
				i_data => i_data,
				o_end_interleaver => o_end_interleaver,
				o_error => o_error,
				o_in_ready => o_in_ready,
				o_start_interleaver => o_start_interleaver,
				o_valid => o_valid,
				o_data => o_data);
				
			
			rst <= '1', '0' after 45001 ps;
			i_valid <= '0', '1' after 105001 ps, '0' after 185001 ps, '1' after 205001 ps, '0' after 325001 ps, '1' after 405001 ps, '0' after 425001 ps;
			i_consume <= '0', '1' after 505001 ps, '0' after 585001 ps, '1' after 705001 ps, '0' after 745001 ps, '1' after 805001 ps, '0' after 885001 ps;
			i_start_interleaver <= '0', '1' after 105001 ps, '0' after 125001 ps, '1' after 405001 ps, '0' after 425001 ps;
			i_end_interleaver <= '0', '1' after 305001 ps, '0' after 325001 ps;
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
			
end dataflow_tbri;