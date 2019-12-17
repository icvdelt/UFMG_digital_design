library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;


entity testbench_spr is
end testbench_spr;

architecture dataflow_tbspr of testbench_spr is
    	
      component single_port_ram is
			generic (
				NUMBER_OF_ELEMENTS : natural := 16;
				NUMBER_OF_LINES : natural range 1 to 16 := 4;
				WORD_LENGTH : natural := 4;
				LINE_ADDR_LENGTH : natural := integer(ceil(log2(real(4))));
				COLUMN_ADDR_LENGTH : natural := integer(ceil(log2(real(16/4))))
			);
	
			port (
				clk : in std_logic;
				i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
				i_ram_wr_en : in std_logic;
				i_lin_addr : in std_logic_vector(LINE_ADDR_LENGTH-1 downto 0);
				i_col_addr : in std_logic_vector(COLUMN_ADDR_LENGTH-1 downto 0);
				o_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
			);
		end component;
		
		signal i_ram_data, o_ram_data : std_logic_vector (3 downto 0);
		signal i_lin_addr, i_col_addr : std_logic_vector (1 downto 0);
		signal clk, i_ram_wr_en: std_logic;
        
      begin
			SPR0 : single_port_ram port map (
				clk => clk,
				i_ram_data => i_ram_data,
				i_ram_wr_en => i_ram_wr_en,
				i_lin_addr => i_lin_addr,
				i_col_addr => i_col_addr,
				o_ram_data => o_ram_data);
				
			
				
			i_ram_wr_en <= '0', '1' after 130 ns, '0' after 230 ns, '1' after 360 ns, '0' after 460 ns, '1' after 500 ns, '0' after 600 ns, '1' after 700 ns, '0' after 800 ns, '1' after 950 ns, '0' after 1000 ns;
			i_lin_addr <= "00", "01" after 100 ns, "00" after 230 ns, "10" after 330 ns, "01" after 460 ns, "00" after 500 ns, "11" after 700 ns, "00" after 850 ns, "11" after 900 ns, "10" after 950 ns, "00" after 1000 ns;
			i_col_addr <= "00", "11" after 100 ns, "01" after 230 ns, "01" after 330 ns, "11" after 460 ns, "00" after 500 ns, "01" after 700 ns, "10" after 850 ns, "01" after 900 ns, "00" after 950 ns, "01" after 1000 ns;
         i_ram_data <= "0000", "0001" after 160 ns, "0010" after 260 ns, "0011" after 300 ns, "0100" after 400 ns, "0101" after 530 ns, "0110" after 630 ns, "1111" after 750 ns, "1010" after 800 ns, "1001" after 900 ns, "1110" after 1000 ns;
			
			pulse : process
				begin
					clk <= '0';
					wait for 5 ns;
					CLK <= '1';
					wait for 10 ns;
					CLK <= '0';
					wait for 5 ns;
			end process;        
end dataflow_tbspr;