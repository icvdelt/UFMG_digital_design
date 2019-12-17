library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_matrix_indexer_incrementer is
	generic (NUMBER_OF_BITS : natural := 4);
end tb_matrix_indexer_incrementer;

architecture test of tb_matrix_indexer_incrementer is
	component matrix_indexer_incrementer is
    	generic(
        	NUMBER_OF_BITS : natural := 4);
        port (
        	clk : in std_logic;
        	rst : in std_logic;
            clear_line : in std_logic;
            clear_column : in std_logic;
            inc : in std_logic;
            axis : in std_logic;
            lin_counter : out std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
            column_counter: out std_logic_vector(NUMBER_OF_BITS - 1 downto 0));
	end component;
    
    signal clk, rst, clear_line, clear_column, inc, axis : std_logic;
    signal lin_counter : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
    signal column_counter : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
    constant c_period : time := 10 ns;
    
    begin
    	
        process_clock: process
		begin
    		clock_loop : loop
     			clk <= '0';
      			wait for (c_period*0.5);
      			clk <= '1';
      			wait for (c_period*0.5);
    		end loop clock_loop;
		end process process_clock;
        
        mii : matrix_indexer_incrementer
        generic map(NUMBER_OF_BITS => NUMBER_OF_BITS)
        port map   (clk => clk,
        			rst => rst,
                    clear_line => clear_line,
                    clear_column => clear_column,
                    inc => inc,
                    axis => axis,
                    lin_counter => lin_counter,
                    column_counter => column_counter);
         
		rst <= '1', '0' after 10 ns, '1' after 100 ns, '0' after 110 ns, '1' after 200 ns;
        axis <= '0', '1' after 50 ns, '0' after 60 ns, '1' after 110 ns, '0' after 120 ns, '1' after 130 ns, '0' after 140 ns, '1' after 150 ns, '0' after 160 ns, '1' after 170 ns, '0' after 180 ns, '1' after 190 ns;
        inc <= '1';
        clear_line <= '0', '1' after 50 ns, '0' after 60 ns;
        clear_column <= '0','1' after 120 ns, '0' after 130 ns, '1' after 140 ns, '0' after 150 ns, '1' after 160 ns, '0' after 170 ns, '1' after 180 ns, '0' after 190 ns;
         
end test;                    
  
  