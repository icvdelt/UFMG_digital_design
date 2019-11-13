library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity inner_deinterleaver is
    generic (
        NUMBER_OF_ELEMENTS : natural;
        NUMBER_OF_LINES : natural range 1 to 15;
        WORD_LENGTH : natural;
        RAM_ADDR_LENGTH : 	natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_consume : in std_logic;
        i_end_interleaver : in std_logic;
        i_start_interleaver : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_in_ready : out std_logic;
        o_ram_wr_en : out std_logic;
		o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_i_ram_addr : out std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
        o_i_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0);
        o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end inner_deinterleaver;

architecture behavioral of inner_deinterleaver is

    
    signal max_element : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    signal wr_pointer : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    signal rd_pointer : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    signal beg_pointer : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    signal s_step : integer range (NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) downto 0 := 0;
    signal b_step : integer range (NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) downto 0 := 0;
    signal turns_cnt : integer range NUMBER_OF_ELEMENTS - 1 downto 0 := 0;
    signal b_turns : integer range NUMBER_OF_LINES downto 0 := 0;
    signal lin_cnt : integer range NUMBER_OF_LINES - 1 downto 0 := 0;
    signal col_cnt : integer range ((NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) - 1) downto 0 := 0;
    signal last_line : integer range NUMBER_OF_LINES - 1 downto 0 := 0;
    signal last_col : integer range ((NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) - 1) downto 0 := 0;
    signal cnt : integer range NUMBER_OF_ELEMENTS - 1 downto 0;
    signal r_error, r_writing, r_reading, r_full_mem : std_logic := '0';
    signal r_empty_mem : std_logic := '1';
    
    begin
    
    	-- establishes how the pointer is going to move through the memory
        rd_pointer_process : process(clk,rst,i_start_interleaver, i_valid, i_end_interleaver, i_consume, r_reading, r_writing, r_error)
        begin
        	if(rst = '1') then
            	rd_pointer <= 0;
                b_step <= 0;
                s_step <= 0;
                turns_cnt <= 0;
                b_turns <= 0;
                beg_pointer <= 0;
            elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '1') then
            	rd_pointer <= 0;
                b_step <= last_col + 1; ---cte
                s_step <= last_col; -- cte
                b_turns <= last_line + 1; --cte
                turns_cnt <= 0;
                beg_pointer <= 0;
                max_element <= cnt - 1;
            else
            	if(rising_edge(clk)) then
                	if(cnt = 0) then
                    	rd_pointer <= 0;
               			b_step <= 0;
                		s_step <= 0;
                		turns_cnt <= 0;
                		b_turns <= 0;
                		beg_pointer <= 0;
            		elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt < b_turns AND rd_pointer <= max_element - b_step) then 
                		rd_pointer <= rd_pointer + b_step;
                    	turns_cnt <= turns_cnt + 1;
                	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt < b_turns AND rd_pointer > max_element - b_step) then
                		beg_pointer <= beg_pointer+1;
                    	rd_pointer <= beg_pointer + 1;
                    	turns_cnt <= turns_cnt + 1;
                	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt >= b_turns AND turns_cnt < NUMBER_OF_LINES - 1 AND rd_pointer <= max_element - s_step) then
                		rd_pointer <= rd_pointer + s_step;
                    	turns_cnt <= turns_cnt + 1;
                	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt >= b_turns AND turns_cnt < NUMBER_OF_LINES - 1 AND rd_pointer > max_element - s_step) then
                		beg_pointer <= beg_pointer + 1;
                    	rd_pointer <= beg_pointer + 1;
                    	turns_cnt <= turns_cnt + 1;
                	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt >= NUMBER_OF_LINES - 1 AND rd_pointer <= max_element - b_step) then
                    	rd_pointer <= rd_pointer + b_step;
                    	turns_cnt <= 0;
                	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0' AND turns_cnt >= NUMBER_OF_LINES - 1 AND rd_pointer > max_element - b_step) then
                		beg_pointer <= beg_pointer + 1;
                   		rd_pointer <= beg_pointer + 1;
                    	turns_cnt <= 0;
                	end if;
            	end if;
             end if;
        end process;
                    
        -- talvez mudar aqui
        wr_pointer_process : process(clk, rst, i_start_interleaver, i_valid, i_end_interleaver, i_consume, r_writing, r_reading, r_error)
        variable last_input : std_logic := '0';
        begin
        	if(rst = '1') then
        		wr_pointer <= 0;
                last_input := '0';
        	else
        		if(rising_edge(clk)) then
            		if(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '0' ) then 
                		wr_pointer <= wr_pointer + 1;
                     elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '1' AND i_start_interleaver = '0') then
                     	wr_pointer <= wr_pointer + 1;
                        last_input := '1';
                     elsif(last_input = '1') then
                     	last_input := '0';
                        wr_pointer <= 0;
                    end if;
            	end if;
         	end if;
		end process;
                                	
                                    
    	--counts the number of elements that enters in the block: will be used later in another signal	
        count_process : process(clk, rst)
        begin
        	if(rst = '1') then
        		cnt <= 0;
            elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_start_interleaver = '1' AND i_end_interleaver = '0') then
            	cnt <= 1;
            elsif(rising_edge(clk)) then
        		if(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_start_interleaver = '0' AND i_end_interleaver = '0') then
            		cnt <= cnt + 1;
            	elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_start_interleaver = '0' AND i_end_interleaver = '1') then
            		cnt <= cnt + 1;
            	elsif(r_reading = '1' AND i_consume = '1' AND r_error = '0') then 
                	cnt <= cnt - 1;
            	end if;
            end if;
		end process;

        --counts the current line to determine the pointer later
		count_lines : process (clk, rst, i_start_interleaver, i_valid, i_end_interleaver, i_consume, r_writing, r_reading, r_error, lin_cnt, col_cnt)
        variable last_input : std_logic := '0';
        	begin
            	if (rst = '1') then
					lin_cnt <= 0;
                    last_input := '0';
				else
                	if (rising_edge (clk)) then
						if (r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '0') then
							if (lin_cnt = (NUMBER_OF_LINES - 1)) then
								lin_cnt <= 0;
							else
								lin_cnt <= (lin_cnt + 1);
                            end if;
                            last_input := '0';
                        elsif(r_writing = '1' AND i_end_interleaver = '1' AND i_valid = '1' AND r_error = '0') then
                         	if (lin_cnt = (NUMBER_OF_LINES - 1)) then
								lin_cnt <= 0;
							else
								lin_cnt <= (lin_cnt + 1);
                            end if;
                            last_input := '1';
                        elsif(last_input = '1') then
                        	lin_cnt <= 0;
                            last_input := '0';
                        end if;
                    end if;        
     			end if;
        end process;
            
        -- counts the current column to determine the pointer later
        count_cols : process (clk, rst, i_start_interleaver, i_valid, i_end_interleaver, i_consume, r_writing, r_reading, r_error, lin_cnt, col_cnt)
        variable last_input: std_logic := '0';
        begin
        	if (rst = '1') then
					col_cnt <= 0;
                    last_input := '0';
			else
				if (rising_edge (clk)) then
                	if (r_writing = '1' AND i_valid = '1' AND r_error = '0' AND lin_cnt = (NUMBER_OF_LINES - 1) AND i_end_interleaver = '0') then
						col_cnt <= (col_cnt + 1);
                        last_input := '0';
                    elsif (r_writing = '1' AND i_valid = '1' AND r_error = '0' AND lin_cnt = (NUMBER_OF_LINES - 1) AND i_end_interleaver = '0') then
						col_cnt <= (col_cnt + 1);
                        last_input := '0';
                    elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '1') then
                    	if(lin_cnt = (NUMBER_OF_LINES - 1)) then
                        	col_cnt <= (col_cnt + 1);
                        end if;
                        last_input := '1';
                    elsif(last_input = '1') then
                    	col_cnt <= 0;
                        last_input := '0';
                    end if;
                end if;
            end if;
        end process;
            
        -- defines conditions for entering into the state "writing"    
        wr_state_process : process (clk, rst, i_start_interleaver, i_end_interleaver)
        variable end_writing : std_logic := '0';
        variable last_input :std_logic := '0';
			begin
				if (rst = '1') then
					r_writing <= '0';
                    last_input := '0';
                    end_writing := '1';
				else
                	if (rising_edge(clk)) then
						if (i_start_interleaver = '1') then 
							r_writing <= '1';
                            last_input := '0';
                            end_writing := '0';
                    	elsif(i_end_interleaver = '1') then
                            r_writing <= '1';
                            last_input := '1';
                        elsif(last_input = '1') then
                        	end_writing := '1';
                            last_input := '0';
                        elsif(end_writing = '1') then
                        	end_writing := '0';
                        	r_writing <= '0';
						end if;
					end if;
				end if;
		end process;
        
        
        -- enables writing
        wr_ram_process : process (rst, clk)
        --variable end_writing : std_logic := '0';
        	begin
            	if (rst = '1') then
					o_ram_wr_en <= '0';
                    --end_writing := '0';
                elsif(rising_edge(clk)) then
                	if(i_start_interleaver = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '0') then
                    	o_ram_wr_en <= '1';
                	elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '0') then
                		o_ram_wr_en <= '1'; 
                	elsif(r_writing = '1' AND i_valid = '1' AND r_error = '0' AND i_end_interleaver = '1') then
                		o_ram_wr_en <= '1';
                        --end_writing := '1';
                    --elsif(r_writing = '1' AND end_writing = '1') then
                    --	end_writing := '0';
                    --    o_ram_wr_en <= '1';
                    elsif(r_writing = '1' AND i_valid = '0' AND r_error = '0') then
                    	o_ram_wr_en <= '0';
                    elsif(r_writing = '0') then
                    	o_ram_wr_en <= '0';
                        --end_writing := '0';
					end if;
                 end if;
		end process;
        
        o_i_ram_addr <= std_logic_vector (to_unsigned ((wr_pointer), RAM_ADDR_LENGTH)) when r_writing = '1' else std_logic_vector (to_unsigned ((rd_pointer), RAM_ADDR_LENGTH)) when r_reading = '1' else (others => '0');
        
        
        i_data_process : process(clk)
        begin
        	if(rising_edge(clk)) then
        		o_i_ram_data <= i_data;
           	end if;
        end process;
        
        o_in_ready <= NOT (r_reading OR r_error); 
        
        -- set o_valid to HIGH when the output is valid
        validate: process(rst, i_consume, r_reading, r_error)
        	begin
        		if(rst = '1') then
                	o_valid <= '0';
                elsif(i_consume = '1' AND r_reading = '1' AND r_error = '0') then
                	o_valid <= '1';
                else
                	o_valid <= '0';
                end if;
        end process; 
        
        -- set o_start_interleaver to HIGH when the first element is sent
        o_start_process : process(rst, clk, i_consume, r_reading, r_error)
        variable start : std_logic := '0';
        begin
        	if(rst = '1') then
            	o_start_interleaver <= '0';
            else
            	if(rising_edge(clk)) then
                	if(i_consume = '1' AND r_reading = '1' AND r_error = '0' AND start = '0') then
                    	o_start_interleaver <= '1';
                        start := '1';
                    elsif(start = '1' AND r_reading = '1') then
                    	o_start_interleaver <= '0';
                    elsif(start = '1' AND r_reading = '0') then
                    	start := '0';
                     end if;
                end if;
            end if;
       end process;
       
       -- set o_end_interleaver to HIGH when the first element is sent
       o_end_process : process(rst, clk, i_consume, r_reading, r_error)
       variable last_output : std_logic := '0';
       begin
       	if(rst = '1') then
        	o_end_interleaver <= '0';
            last_output := '0';
        else
        	if(rising_edge(clk)) then
				if(i_consume = '1' AND cnt = 2 AND r_reading = '1' AND r_error = '0') then 
                	last_output := '1';
                 elsif(i_consume = '1' AND r_reading = '1' AND r_error = '0' AND last_output = '1') then
                 	o_end_interleaver <= '1';
                    last_output := '0';
                  elsif(last_output = '0') then
                  	o_end_interleaver <= '0';
                end if;
             end if;
        end if;
       end process;
       
        
      --  defines the conditions for entering into the state "reading"
      rd_state_process : process (clk, rst, i_end_interleaver, i_valid, i_consume, r_writing, r_error, lin_cnt, col_cnt, r_reading)
      variable last_input : std_logic := '0';
      variable end_writing : std_logic := '0';
      	begin
        	if (rst = '1') then
				r_reading <= '0';
				last_line <= 0;
				last_col <= 0;
                last_input := '0';
                end_writing := '0';
            else
            	if(rising_edge(clk)) then
                	if(i_end_interleaver = '1' AND r_writing = '1' AND i_valid = '1' AND r_error = '0') then
                    	if(lin_cnt = (NUMBER_OF_LINES-1)) then
                    		last_line <= 0;
                        	last_col <= col_cnt + 1;
                    	else
                    		last_line <= lin_cnt + 1;
                        	last_col <= col_cnt;
                    	end if;
                        last_input := '1';
                    elsif(last_input = '1') then
                    	end_writing := '1';
                        last_input := '0';
                    elsif(end_writing = '1') then
                    	r_reading <= '1';
                        end_writing := '0';
                    elsif(r_reading = '1' AND r_error = '0' AND cnt = 0) then -- mudei aqui, ver implicação disso dps
                    	r_reading <= '0';
                    end if;
            	end if;
            end if;
      end process;
      
      error_process : process(clk)
      begin
      if(rst = '1') then
      	r_error <= '0';
      elsif(rising_edge(clk)) then
      	if(r_writing = '1' AND i_start_interleaver = '1') then
        	r_error <= '1';
        end if;
      end if;
      end process;
      
      o_error <= r_error;
        
      
     --o_data <= i_ram_data;
      o_data <= i_ram_data when o_valid = '1' else (others => '0');
     
    -- condições erro
      
	-- problemas com contador na segunda vez
end behavioral;