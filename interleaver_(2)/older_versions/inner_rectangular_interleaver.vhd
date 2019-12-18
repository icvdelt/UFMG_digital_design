library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity inner_rectangular_interleaver is
    generic (
        NUMBER_OF_ELEMENTS_INRI : natural := 15;
        NUMBER_OF_LINES_INRI : natural range 1 to 15 := 4;
        WORD_LENGTH_INRI : natural := 4;
        RAM_ADDR_LENGTH_INRI : 	natural := integer(ceil(log2(real(15))))
    );
    port (
	 
--		  o_filled : out std_logic;
	 
        clk : in std_logic;
        rst : in std_logic;
        i_consume : in std_logic;
        i_end_interleaver : in std_logic;
        i_start_interleaver : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(WORD_LENGTH_INRI-1 downto 0);
        i_ram_data : in std_logic_vector(WORD_LENGTH_INRI-1 downto 0);
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_in_ready : out std_logic;
        o_ram_wr_en : out std_logic;
		  o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_i_ram_addr : out std_logic_vector(RAM_ADDR_LENGTH_INRI-1 downto 0);
        o_i_ram_data : out std_logic_vector(WORD_LENGTH_INRI-1 downto 0);
        o_data : out std_logic_vector(WORD_LENGTH_INRI-1 downto 0)
    );
end inner_rectangular_interleaver;

architecture behavioral of inner_rectangular_interleaver is
	
	signal lin_cnt, last_line : std_logic_vector ((integer(ceil(log2(real(NUMBER_OF_LINES_INRI)))) - 1) downto 0) := (others => '0');	--Keeps, respectively, the current line and the last line after filling the interleaver.
	signal col_cnt, last_col : std_logic_vector ((integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI)))) - 1) downto 0) := (others => '0');	--Keeps, respectively, the current line and the last line after filling the interleaver.
--	signal data_counter : std_logic_vector ((RAM_ADDR_LENGTH_INRI - 1) downto 0) := (others => '0');	--Don't know how to use log2 nor ceil. Must change max index later...
	signal error, increment, filled, full_mem : std_logic := '0';	--Signals to indicate error, input of data, filled interleaver and capacity limit reached.
	signal empty_mem : std_logic := '1';	--Indicates that the memory is empty.
	signal switch0 : std_logic := '0';	--Auxiliary signal.
	signal switch1 : std_logic := '0';	--Auxiliary signal.
	signal switch2 : std_logic := '0'; --Auxiliary signal.
	signal switch3 : std_logic := '0'; --Auxiliary signal.

	begin
	
		switch_count : process (clk, rst, i_end_interleaver, i_valid, switch2)	--Helps updating the line and column counters.
			begin
				if (rst = '1') then	--Resets to 0.
					switch2 <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_end_interleaver = '1' AND i_valid = '1') then	---Checks for the end of the output.
							switch2 <= '1';
						elsif (switch2 = '1') then
							switch2 <= '0';
						end if;
					end if;
				end if;			
		end process;
	
		count_lines : process (clk, rst, i_valid, i_consume, increment, filled, full_mem, lin_cnt, col_cnt, switch2)	--Process for updating the current line.
			begin
				if (rst = '1') then	--Resets the line counter.
					lin_cnt <= (others => '0');
				else
					if (rising_edge (clk)) then	--Synchronous process.
						--if (i_start_interleaver = '1' AND increment = '0' AND i_valid = '1' AND full_mem = '0') then	--Checks for the start of data input.
							--if (to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) then	--In case the counter is in the last line.
								--lin_cnt <= (others => '0');
							--else
								--lin_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));
							--end if;
						if (increment = '1' AND i_valid = '1' AND full_mem = '0') then	--Checks for data input.
							if (to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) then	--In case the counter is in the last line.
								lin_cnt <= (others => '0');
							else
								lin_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));
							end if;
						elsif (switch2 = '1') then	--Checks for the end of data input.
							lin_cnt <= (others => '0');
						elsif ((to_integer (unsigned (lin_cnt)) < (to_integer (unsigned (last_line)) - 1)) AND filled = '1' AND i_consume = '1' AND (to_integer (unsigned (col_cnt)) = to_integer (unsigned (last_col)))) then	--Checks for data output on the complete lines.
							lin_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));
						elsif ((to_integer (unsigned (lin_cnt)) = (to_integer (unsigned (last_line)) - 1)) AND (to_integer (unsigned (last_col)) /= 0) AND filled = '1' AND i_consume = '1' AND (to_integer (unsigned (col_cnt)) = to_integer (unsigned (last_col)))) then	--Checks for data output on the complete lines.
							lin_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));
						elsif ((to_integer (unsigned (lin_cnt)) < (to_integer (unsigned (last_line)) - 1)) AND (to_integer (unsigned (last_col)) = 0) AND filled = '1' AND i_consume = '1' AND (to_integer (unsigned (col_cnt)) = to_integer (unsigned (last_col)))) then	--Checks for a possible end output.
							lin_cnt <= (others => '0');
						elsif ((to_integer (unsigned (lin_cnt)) >= to_integer (unsigned (last_line))) AND (to_integer (unsigned (lin_cnt)) < (NUMBER_OF_LINES_INRI - 1)) AND filled = '1' AND i_consume = '1' AND (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1))) then	--Checks for data output on the incomplete lines.
							lin_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));
						elsif ((to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) AND filled = '1' AND i_consume = '1' AND (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1))) then	--Checks for the most commom end of data output.
							lin_cnt <= (others => '0');
						end if;
					end if;
				end if;
		end process;
		
		count_cols : process (clk, rst, i_valid, i_consume, increment, filled, full_mem, lin_cnt, col_cnt, switch2)	--Process for updating the current column.
			begin
				if (rst = '1') then	--Resets the line counter.
					col_cnt <= (others => '0');
				else
					if (rising_edge (clk)) then	--Synchronous process.
						--if (i_start_interleaver = '1' AND increment = '0' AND i_valid = '1' AND full_mem = '0' AND (to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1))) then	--Checks for the start of data input.
							--col_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (col_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));	--Checks for data input.
						if (increment = '1' AND i_valid = '1' AND full_mem = '0' AND (to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1))) then
							col_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (col_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));
						elsif (switch2 = '1') then	--Checks for the end of data input.
							col_cnt <= (others => '0');
						elsif ((to_integer (unsigned (lin_cnt)) < to_integer (unsigned (last_line))) AND filled = '1' AND i_consume = '1') then	--Checks for data output on the complete lines.
							if (to_integer (unsigned (col_cnt)) = to_integer (unsigned (last_col))) then	--In case the current column is the last.
								col_cnt <= (others => '0');
							else
								col_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (col_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));
							end if;							
						elsif ((to_integer (unsigned (lin_cnt)) >= to_integer (unsigned (last_line))) AND (to_integer (unsigned (lin_cnt)) < NUMBER_OF_LINES_INRI) AND filled = '1' AND i_consume = '1') then	--Checks for data output on incomplete lines.
							if (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1)) then	--In case the current column is the last.
								col_cnt <= (others => '0');
							else
								col_cnt <= std_logic_vector(to_unsigned (((to_integer (unsigned (col_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));
							end if;	
						end if;
					end if;				
				end if;
		end process;
	
		full_matrix_detection : process (lin_cnt, col_cnt, last_line, last_col, rst)	--Verifies if the maximum capacity of the memory has been reached.
			begin
				if (rst = '1') then	--Starting condition.
					full_mem <= '0';
				elsif ((to_integer (unsigned (lin_cnt)) + 1 + NUMBER_OF_LINES_INRI * to_integer (unsigned (col_cnt))) = (NUMBER_OF_ELEMENTS_INRI + 1)) then	--Checks if the matrix is full.
					full_mem <= '1';
				elsif ((to_integer (unsigned (last_line)) + 1 + NUMBER_OF_LINES_INRI *to_integer (unsigned (last_col))) = (NUMBER_OF_ELEMENTS_INRI + 1)) then	--Checks if the matrix is full.
					full_mem <= '1';
				else	--Standard configuration.
					full_mem <= '0';
				end if;
		end process;
		
		empty_matrix_detection : process (rst, lin_cnt, col_cnt, filled)	--Verifies if the memory has no elements.
			begin
				if (rst = '1') then	--Starting condition.
					empty_mem <= '1';
				elsif ((((to_integer (unsigned (lin_cnt)) + 1) * (to_integer (unsigned (col_cnt)) + 1)) = 1) AND filled = '0') then
					empty_mem <= '1';
				else
					empty_mem <= '0';	--Standard configuration.
				end if;
		end process;
		
		increment_proc : process (clk, rst, i_start_interleaver, i_end_interleaver, filled, full_mem)	--Keeps receiving input.
			begin
				if (rst = '1') then	--Starting condition.
					increment <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_start_interleaver = '1' AND filled = '0' AND full_mem = '0') then	--Checks for the start of data input.
							increment <= '1';	--Sets up for receiving data.
						elsif (i_end_interleaver = '1') then	--Checks for the start of data input.
							increment <= '0';	--Stops receiving data.
						end if;
					end if;
				end if;
		end process;
		
		load : process (clk, rst, i_start_interleaver, i_end_interleaver, i_valid, full_mem, i_data, increment, filled)	--Enables the memory for storing the data received.
			begin
				if (rst = '1') then
					o_ram_wr_en <= '0';
				else
					if (rising_edge (clk)) then
						if ((i_start_interleaver = '1' OR increment = '1') AND i_valid = '1' AND full_mem = '0' AND filled = '0') then	--Checks for data input.
							o_ram_wr_en <= '1';
						elsif ((i_start_interleaver = '0' AND increment = '0') OR i_valid = '0' OR full_mem = '1' OR filled = '1') then
							o_ram_wr_en <= '0';
						end if;
					end if;
				end if;
		end process;
		
		o_i_ram_addr <= std_logic_vector (to_unsigned (to_integer (unsigned (lin_cnt)) + WORD_LENGTH_INRI * to_integer (unsigned (col_cnt)), RAM_ADDR_LENGTH_INRI));
				
		hold_data : process (clk, rst, i_start_interleaver, i_end_interleaver, i_valid, full_mem, i_data, increment)	--Stores temporarily the input data for the memory.
			begin
				if (rst = '1') then	--Resets to 0.
					o_i_ram_data <= (others => '0');
				else
					if (rising_edge (clk)) then	--Synchronous process.
						o_i_ram_data <= i_data;
					end if;
				end if;
		end process;
		
		occupy : process (clk, rst, i_end_interleaver, i_valid, i_consume, increment, full_mem, lin_cnt, col_cnt, filled)	--Configures the 'filled' condition for the interleaver.
			begin
				if (rst = '1') then	--Resets to 0.
					filled <= '0';
					last_line <= (others => '0');
					last_col <= (others => '0');
				else 
					if (rising_edge (clk)) then	--Synchronous process.
						if (switch2 = '1' AND full_mem = '0') then	--Checks for the end of data input.
							filled <= '1';
							if (to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) then	--In case current line is the last (before the last update of the line counter).
								last_line <= (others => '0');	--Stores the last line.
								last_col <= std_logic_vector(to_unsigned (((to_integer (unsigned (col_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));	--Stores the last column.
							else
								last_line <= std_logic_vector(to_unsigned (((to_integer (unsigned (lin_cnt))) + 1), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));	--Stores the last line.
								last_col <= std_logic_vector(to_unsigned (to_integer (unsigned (col_cnt)), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));	--Stores the last column.
							end if;
						elsif (switch2 = '1' AND full_mem = '1') then	--Checks for the end of data input.
							last_line <= std_logic_vector(to_unsigned (to_integer (unsigned (lin_cnt)), integer(ceil(log2(real(NUMBER_OF_LINES_INRI))))));	--Stores the last line.
							last_col <= std_logic_vector(to_unsigned (to_integer (unsigned (col_cnt)), integer(ceil(log2(real(NUMBER_OF_ELEMENTS_INRI/NUMBER_OF_LINES_INRI))))));	--Stores the last column.
						elsif ((((to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) AND (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1))) 
						OR ((to_integer (unsigned (lin_cnt)) = (to_integer (unsigned (last_line)) - 1)) AND (to_integer (unsigned (last_col)) = 0))) 
						AND filled = '1' AND i_consume = '1') then	--Checks for the end of data output.
							filled <= '0';	--Resets.
							last_line <= (others => '0');	--Resets.
							last_col <= (others => '0');	--Resets.
						end if;
					end if;
				end if;
		end process;
		
--		o_filled <= filled;
		
		o_in_ready <= NOT (filled OR error);
		
		validate : process (clk, rst, i_consume, filled)	--Validates the output data.
			begin
				if (rst = '1') then
					o_valid <= '0';
				else 
					if (rising_edge (clk)) then
						if (i_consume = '1' AND filled = '1') then	--Checks if there is an output process.
							o_valid <= '1';
						elsif (i_consume = '0' OR filled = '0')	then
							o_valid <= '0';
						end if;
					end if;
				end if;
		end process;
		
		switch_start : process (rst, clk, i_consume, filled)	--Auxiliary for pulsing the start interleaver signal.
			begin
				if (rst = '1') then	--Resets to 0.
					switch0 <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_consume = '1' AND filled = '1') then
							switch0 <= '1';
						elsif (filled = '0') then
							switch0 <= '0';
						end if;
					end if;
				end if;
		end process;
		
		start : process (rst, clk, i_consume, filled)	--Sends the start interleaver signal.
			begin
				if (rst = '1') then	--Starting condition.
					o_start_interleaver <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_consume = '1' AND filled = '1' AND switch0 = '0') then	--Checks for start of data output.
							o_start_interleaver <= '1';
						elsif (switch0 = '1') then
							o_start_interleaver <= '0';
						end if;
					end if;
				end if;
		end process;
		
		switch_finish : process (rst, clk, i_consume, filled)	--Auxiliary for pulsing the end interleaver signal.
			begin
				if (rst = '1') then	--Resets to 0.
					switch1 <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_consume = '1' AND filled = '1' AND
						((to_integer (unsigned (lin_cnt)) = 0) AND (to_integer (unsigned (col_cnt)) = 0))) then
							switch1 <= '0';
						elsif (i_consume = '1' AND filled = '1' AND
						(((to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) AND (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1))) 
						OR ((to_integer (unsigned (lin_cnt)) = (to_integer (unsigned (last_line)) - 1)) AND (to_integer (unsigned (last_col)) = 0)))) then
							switch1 <= '1';
						end if;
					end if;
				end if;
		end process;
		
		finish : process (rst, clk, i_consume, filled)	--Sends the end interleaver signal.
			begin
				if (rst = '1') then	--Starting condition.
					o_end_interleaver <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_consume = '1' AND filled = '1' AND switch1 = '0' AND
						(((to_integer (unsigned (lin_cnt)) = (NUMBER_OF_LINES_INRI - 1)) AND (to_integer (unsigned (col_cnt)) = (to_integer (unsigned (last_col)) - 1))) 
						OR ((to_integer (unsigned (lin_cnt)) = (to_integer (unsigned (last_line)) - 1)) AND (to_integer (unsigned (last_col)) = 0)))) then	--Checks for the end of data output.
							o_end_interleaver <= '1';
						elsif (switch1 = '1') then
							o_end_interleaver <= '0';
						end if;
					end if;
				end if;
		end process;
		
		switch_out : process (clk, rst, i_consume, filled, i_ram_data)
			begin
				if (rst = '1') then
					switch3 <= '0';
				else
					if (rising_edge (clk)) then
						if (i_consume = '1' AND filled = '1') then	--Checks if there is an output process.
							switch3 <= '1';
						elsif (i_consume = '0' OR filled = '0') then
							switch3 <= '0';
						end if;
					end if;
				end if;
		end process;
		
		unload : process (clk, rst, switch3, i_ram_data)	--Loads the data from the memory to the output.
			begin
				if (rst = '1') then
					o_data <= (others => '0');
				elsif (switch3 = '1') then	--Checks if there is an output process.
					o_data <= i_ram_data;
				else
					o_data <= (others => '0');
				end if;
		end process;
		
		error_detection : process (clk, rst, i_start_interleaver, i_consume, i_valid, increment, full_mem, empty_mem, filled)	--Signaling the occurrence of error.
			begin	--increment and i_start_interleaver, sequencial
				if (rst = '1') then	--No error when reset.
					error <= '0';
				else
					if (rising_edge (clk)) then	--Synchronous process.
						if (i_start_interleaver = '1' AND increment = '1') then	--Error due to multiple starts.
							error <= '1';
						elsif (full_mem = '1' AND (i_start_interleaver = '1' OR increment = '1') AND i_valid = '1') then	--Error due to possible overflow.
							error <= '1';
						elsif (filled = '1' AND (i_start_interleaver = '1' OR increment = '1') AND i_valid = '1') then --Error due to occupied resources.
							error <= '1';
						elsif (empty_mem = '1' AND i_consume = '1') then	--Error due to lack of data.
							error <= '1';
						elsif ((i_start_interleaver = '0' AND increment = '0') OR ((i_start_interleaver = '1' XOR increment = '1') AND ((full_mem = '0' AND filled = '0') OR i_valid = '0'))) then	--Checking if errors have been fixed.
							error <= '0';
						elsif (empty_mem = '0' OR i_consume = '0') then	--Checking if errors have been fixed.
							error <= '0';
						end if;
					end if;
				end if;
		end process;
		
		o_error <= error;

end behavioral;
