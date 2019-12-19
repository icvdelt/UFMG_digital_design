library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity testbench_idp is
	generic (
			NUMBER_OF_ELEMENTS : natural := 12;
			NUMBER_OF_LINES : natural range 1 to 16 := 3;
			WORD_LENGTH : natural := 3;
			LINE_ADDR_LENGTH : natural := integer(ceil(log2(real(3))));
			COLUMN_ADDR_LENGTH : natural := integer(ceil(log2(real(12/3)))));
end testbench_idp;

architecture behaviour_tbidp of testbench_idp is
	component interleaver_data_path is
		generic (
			NUMBER_OF_ELEMENTS : natural;
			NUMBER_OF_LINES : natural;
			WORD_LENGTH : natural;
			LINE_ADDR_LENGTH : natural;
			COLUMN_ADDR_LENGTH : natural);
			
		port (
			clk : in std_logic;								--Clock signal.
			wr_rd_status : in std_logic;					--Status of the memory according dsd to the state of the FSM.
			rst_last_input : in std_logic;				--Resets the last line and last column registers.
			en_last_input : in std_logic;					--Enables the last line and last column register.
			en_ram_input : in std_logic;					--Enables the input register.
			rst_indexer : in std_logic;					--Resets the line counter and column counter registers.
			en_indexer : in std_logic;						--Enables the load of the line counter and column counter registers.
			ram_wr_en : in std_logic;						--Enables the ram.
		
			i_data : in std_logic_vector ((WORD_LENGTH - 1) downto 0); --Data input.
		
			full_ram_first_out : out std_logic;			--Represents that the ram is full or that the first output has been sent depending on the selection of the target.
			last_out : out std_logic;						--Represents that the last output has been sent.
			
			lin_count : out std_logic_vector ((LINE_ADDR_LENGTH - 1) downto 0);
			col_count : out std_logic_vector	((COLUMN_ADDR_LENGTH - 1) downto 0);
		
			o_data : out std_logic_vector ((WORD_LENGTH -1 ) downto 0));	--Data output.	
	end component;
    
   signal clk,	wr_rd_status, rst_last_input, en_last_input,  en_ram_input, rst_indexer, en_indexer, ram_wr_en : std_logic;
	signal i_data : std_logic_vector ((WORD_LENGTH - 1) downto 0);
	signal full_ram_first_out, last_out : std_logic;
	signal o_data : std_logic_vector ((WORD_LENGTH -1 ) downto 0);
	signal lin_count : std_logic_vector ((LINE_ADDR_LENGTH - 1) downto 0);
	signal col_count : std_logic_vector ((COLUMN_ADDR_LENGTH - 1) downto 0);
    
   begin
    	
      pulse : process
			begin
				clk <= '0';
				wait for 5 ns;
				clk <= '1';
				wait for 10 ns;
				clk <= '0';
				wait for 5 ns;
		end process;
        
      IDP0 : interleaver_data_path
			generic map (
				NUMBER_OF_ELEMENTS => NUMBER_OF_ELEMENTS,
				NUMBER_OF_LINES => NUMBER_OF_LINES,
				WORD_LENGTH => WORD_LENGTH,
				LINE_ADDR_LENGTH => LINE_ADDR_LENGTH,
				COLUMN_ADDR_LENGTH => COLUMN_ADDR_LENGTH)
			port map (
				clk => clk,
				wr_rd_status => wr_rd_status,
				rst_last_input => rst_last_input,
				en_last_input => en_last_input,
				en_ram_input => en_ram_input,
				rst_indexer => rst_indexer,
				en_indexer => en_indexer,
				ram_wr_en => ram_wr_en,
		
				i_data => i_data,
		
				full_ram_first_out => full_ram_first_out,
				last_out => last_out,
				
				lin_count => lin_count,
				col_count => col_count,
		
				o_data => o_data);	

			en_ram_input <= '1', '0' after 185001 ps, '1' after 705001 ps;
			rst_indexer <= '1', '0' after 45001 ps, '1' after 185001 ps, '0' after 205001 ps, '1' after 705001 ps;
			wr_rd_status <= '0',	'1' after 185001 ps, '0' after 705001 ps;
			en_indexer <= '0', '1' after 45001 ps,	'0' after 125001 ps, '1' after 145001 ps,	'0' after 185001 ps, '1' after 505001 ps, '0' after 545001 ps, '1' after 565001 ps, '0' after 585001 ps, '1' after 645001 ps, '0' after 705001 ps;
			rst_last_input <= '0', '1' after 705001 ps, '0' after 725001 ps;
			en_last_input <= '0', '1' after 185001 ps, '0' after 205001 ps;
			ram_wr_en <= '0', '1' after 45001 ps, '0' after 125001 ps, '1' after 145001 ps, '0' after 205001 ps;
			
			i_data <= "000", "011" after 45001 ps, "101" after 65001 ps, "001" after 85001 ps, "100" after 105001 ps, "110" after 145001 ps, "010" after 165001 ps;
end behaviour_tbidp;                    
  
  