library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity read_addr_indexer_deinterleaver is
    generic (
        NUMBER_OF_ELEMENTS : natural;
        NUMBER_OF_LINES : natural range 1 to 15;
        WORD_LENGTH : natural;
        RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
    );
	port(
    	clk : in std_logic;
        rst: in std_logic;
        i_error: in std_logic;
        i_en_read_addr_indexer: in std_logic;
        i_addr : in std_logic; //0 pra write, 1 pra read
        i_last_line: integer range NUMBER_OF_LINES - 1 downto 0;
        i_last_column: integer range ((NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) - 1) downto 0;
        o_read_addr : out std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
        o_last_output : out std_logic
        );
end read_addr_indexer_deinterleaver;

architecture behavioral of read_addr_indexer_deinterleaver is
	signal last_position : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    	signal starting_point : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0; 
    	signal short_step : integer range (NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) downto 0 := 0; 
    	signal long_step : integer range (NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) downto 0 := 0;
	signal cnt_steps_per_turn : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    	signal cnt_turns : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
	signal long_steps_per_turn : integer range NUMBER_OF_LINES downto 0 := 0;
    	signal r_read_pointer : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    	signal last_line : integer range NUMBER_OF_LINES - 1 downto 0 := 0;
    	signal last_column : integer range ((NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) - 1) downto 0 := 0;
    
	begin
    
    	process(clk, rst, i_error)	
    	begin
        	if(rst = '1' or i_error = '1') then 
                	long_step <= 0;
                	short_step <= 0;
		        cnt_steps_per_turn <= 0;
		        long_steps_per_turn <= 0;
		        starting_point <= 0;
		        r_read_pointer <= 0;
		        last_position <= 0;
		        cnt_turns <= 0;
		        last_line <= (others => '0');
		        last_columns <= (others => '0');
		elsif(rising_edge(clk)) then
            		if(i_addr = '0') then
               			long_step <= i_last_column + 1;
               	 		short_step <= i_last_column;
		        	cnt_steps_per_turn <= 0;
		        	long_steps_per_turn <= i_last_line + 1;
		        	starting_point <= 0;
		        	last_position <= (i_last_column * NUMBER_OF_LINES) + i_last_line;
				r_read_pointer <= 0;
				cnt_turns <= 0;
				last_line <= i_last_line;
				last_column <= i_last_column;
               	 	elsif(i_addr = '1' and i_en_read_addr_indexer = '1') then 
				if(cnt_steps_per_turn < long_steps_per_turn AND r_read_pointer <= last_position - long_step) then
                    			r_read_pointer <= r_read_pointer + long_step;
                    			cnt_steps_per_turn <= cnt_steps_per_turn + 1;
                     		elsif(cnt_steps_per_turn < long_steps_per_turn AND r_read_pointer > last_position - long_step) then
                     			starting_point <= starting_point + 1;
                    			r_read_pointer <= starting_point + 1;
                        		cnt_steps_per_turn <= cnt_steps_per_turn + 
				elsif(cnt_steps_per_turn >= long_steps_per_turn AND cnt_steps_per_turn < NUMBER_OF_LINES - 1 AND r_read_pointer <= last_position - short_step) then
				     	r_read_pointer <= r_read_pointer + short_step;
				        cnt_steps_per_turn <= cnt_steps_per_turn + 1;
				elsif(cnt_steps_per_turn >= long_steps_per_turn AND cnt_steps_per_turn < NUMBER_OF_LINES - 1 AND rd_pointer > last_position - short_step) then
				     	starting_point <= starting_point + 1;
				    	rd_pointer <= starting_point + 1;
				    	cnt_steps_per_turn <= cnt_steps_per_turn + 1;
				elsif(cnt_steps_per_turn >= NUMBER_OF_LINES - 1 AND r_read_pointer <= last_position - long_step) then
				     	r_read_pointer <= r_read_pointer + long_step;
				    	cnt_steps_per_turn <= 0;
				        cnt_turns <= cnt_turns + 1;
				elsif(cnt_steps_per_turn >= NUMBER_OF_LINES - 1 AND r_read_pointer > last_position - long_step) then
				     	starting_point <= starting_point + 1;
				   	r_read_pointer <= starting_point + 1;
				    	cnt_steps_per_turn <= 0;
				        cnt_turns <= cnt_turns + 1;
				end if;
                	end if;
           	 end if;
	end process;
    
    o_read_addr <= std_logic_vector (to_unsigned ((r_read_pointer), RAM_ADDR_LENGTH)) when o_valid = '1' else (others => '0');
    
    o_last_output <= '1' when (cnt_turns = last_column and cnt_steps_per_turn = last_line - 1 and i_addr = '1') else '0';
    
end behavioral;